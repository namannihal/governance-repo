<#
.SYNOPSIS
    Parses CPF (Cloud Product Framework) index.md files and generates JSON schema files
    that an AI agent can use to build Terraform code invoking CPF modules.

.DESCRIPTION
    For each CPF module folder, reads the index.md HTML/Markdown file, extracts:
    - Module metadata (name, type, description)
    - GitLab source URL
    - Prerequisites
    - Terraform Inputs (variables with type, default, required)
    - Terraform Outputs
    - Azure resources created
    Then writes a structured JSON schema to the output directory.
#>

param(
    # Path to the folder containing CPF module sub-folders (each with an index.md).
    # Defaults to templates/cpf/ relative to this script's repository root.
    # Override on the command line: -CpfRoot "D:\my-cpf-source"
    [string]$CpfRoot = (Join-Path $PSScriptRoot "..\templates\cpf"),

    # Path where the generated JSON schema files will be written.
    # Defaults to templates/cpf-schemas/ relative to this script's repository root.
    # Override on the command line: -OutputDir "D:\my-output"
    [string]$OutputDir = (Join-Path $PSScriptRoot "..\templates\cpf-schemas")
)

# ------------------------------------------------------------------
# Helper: strip HTML tags, decode entities, unescape markdown
# ------------------------------------------------------------------
function Strip-Html {
    param([string]$Html)
    if ([string]::IsNullOrWhiteSpace($Html)) { return "" }
    $t = $Html -replace '<[^>]+>', ' '
    $t = $t -replace '&amp;',  '&'
    $t = $t -replace '&lt;',   '<'
    $t = $t -replace '&gt;',   '>'
    $t = $t -replace '&quot;', '"'
    $t = $t -replace '&#39;',  "'"
    $t = $t -replace '&nbsp;', ' '
    $t = $t -replace '\\_',    '_'   # unescape markdown \_ → _
    $t = $t -replace '\\\*',   '*'   # unescape markdown \* → *
    $t = $t -replace '\'+'`',   '`'
    $t = $t -replace '\s+',    ' '
    return $t.Trim()
}

# ------------------------------------------------------------------
# Helper: clean a cell value — strip backtick wrappers, unescape
# ------------------------------------------------------------------
function Clean-Cell {
    param([string]$Val)
    if ([string]::IsNullOrWhiteSpace($Val)) { return $Val }
    # Strip backtick code spans: `value` -> value
    $v = $Val.Trim()
    if ($v -match '^`(.*)`$') { $v = $Matches[1] }
    # Unescape markdown backslash sequences
    $v = $v -replace '\\_', '_'
    $v = $v -replace '\\\*', '*'
    return $v.Trim()
}

# ------------------------------------------------------------------
# Helper: extract content between two regex patterns
# ------------------------------------------------------------------
function Get-Between {
    param([string]$Text, [string]$StartPattern, [string]$EndPattern)
    $si = $Text -match $StartPattern
    if (-not $si) { return "" }
    $startIdx = $Text.IndexOf($Matches[0]) + $Matches[0].Length
    $remaining = $Text.Substring($startIdx)
    if ($remaining -match $EndPattern) {
        $endIdx = $remaining.IndexOf($Matches[0])
        return $remaining.Substring(0, $endIdx)
    }
    return $remaining
}

# ------------------------------------------------------------------
# Helper: extract the module title
# Supports both old HTML (aria-label) and new pure-Markdown (# Heading)
# ------------------------------------------------------------------
function Get-ModuleTitle {
    param([string]$Content)
    # New format: pure markdown, first # heading
    if ($Content -match '(?m)^#\s+(.+)$') {
        $t = Strip-Html $Matches[1]
        if ($t.Length -gt 2) { return $t }
    }
    # Old HTML format: aria-label on logo element
    if ($Content -match 'aria-label="([^"]+)"[^>]*data-md-component="logo"') {
        return $Matches[1].Trim()
    }
    # fallback: first h1
    if ($Content -match '<h1[^>]*>([^<]+)<') {
        return Strip-Html $Matches[1]
    }
    return ""
}

# ------------------------------------------------------------------
# Helper: extract GitLab source URL
# Supports both old HTML href and new Markdown link syntax
# ------------------------------------------------------------------
function Get-GitLabSource {
    param([string]$Content)
    # Old HTML: href attribute
    if ($Content -match 'href="(https://gitlab[\w\.\-/:%]+/-/tree/[^"]+)"') {
        return $Matches[1]
    }
    # New Markdown: [text](https://gitlab.../-/tree/...)
    if ($Content -match '\(https://gitlab[\w\.\-/:%]+/-/tree/[^)]+\)') {
        return $Matches[0].Trim('(',')')
    }
    return ""
}

# ------------------------------------------------------------------
# Helper: extract module version from YAML frontmatter
# Reads the --- block at the top of index.md for: version: X.Y.Z
# ------------------------------------------------------------------
function Get-ModuleVersion {
    param([string]$Content)
    # YAML frontmatter block: ---\nversion: X.Y.Z\n---
    if ($Content -match '(?m)^---[\s\S]*?^version:\s*([^\s#]+)') {
        return $Matches[1].Trim()
    }
    # Fallback: Details table row  | version | X.Y.Z |
    if ($Content -match '(?im)^\|\s*version\s*\|\s*([0-9]+\.[0-9]+\.[0-9][^\|]*)\|') {
        return $Matches[1].Trim()
    }
    return ""
}

# ------------------------------------------------------------------
# Helper: derive Terraform module source from CpfId
# When a version tag is supplied the ?ref= pin is appended.
# ------------------------------------------------------------------
function Get-TerraformSource {
    param([string]$CpfId, [string]$GitLabUrl = "", [string]$Version = "")
    $ref = if ($Version -ne "") { "?ref=$Version" } else { "" }
    # Derive directly from CpfId — the canonical repo path
    if ($CpfId -match 'cpf-azure-(prdsvc|prdapppat|prdsvcpat)-(.+)$') {
        $modType = $Matches[1]
        $modName = $Matches[2]
        $baseUrl = 'https://gitlab.dx1.lseg.com/app/app-51310/azure'
        $repoName = "azure-$modType-terraform-$modName"
        return "git::$baseUrl/$modType/terraform/$repoName.git//$ref"
    }
    # Fallback: derive from GitLab tree URL if available
    if (-not [string]::IsNullOrEmpty($GitLabUrl)) {
        return ($GitLabUrl -replace '/-/tree/main.*$', ".git//$ref")
    }
    return ""
}

# ------------------------------------------------------------------
# Helper: extract description / overview paragraph
# ------------------------------------------------------------------
function Get-Description {
    param([string]$Content)
    # Try to get text after the first <h1> or after ## Overview
    $patterns = @(
        '(?s)<h1[^>]*>.*?</h1>(.*?)<(?:h2|h3)',
        '(?s)## Overview.*?</h2>(.*?)<(?:h2|h3|##)'
    )
    foreach ($pat in $patterns) {
        if ($Content -match $pat) {
            $raw = Strip-Html $Matches[1]
            if ($raw.Length -gt 20) {
                return ($raw -replace '\s+', ' ').Trim() | Select-Object -First 1
            }
        }
    }
    return ""
}

# ------------------------------------------------------------------
# Helper: extract prerequisites
# ------------------------------------------------------------------
function Get-Prerequisites {
    param([string]$Content)
    $prereqs = @()
    # Look for Prerequisites section
    if ($Content -match '(?s)(?:## Prerequisites|Prerequisites</h2>)(.*?)(?=<h2|##\s)') {
        $section = $Matches[1]
        # Extract list items
        $items = [regex]::Matches($section, '<li[^>]*>(.*?)</li>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
        foreach ($item in $items) {
            $txt = Strip-Html $item.Groups[1].Value
            if ($txt.Length -gt 1) { $prereqs += $txt }
        }
        # Also look for backtick code items
        $codeItems = [regex]::Matches($section, '`([^`]+)`')
        foreach ($ci in $codeItems) {
            $val = $ci.Groups[1].Value.Trim()
            if ($val.Length -gt 1 -and $val -notin $prereqs) { $prereqs += $val }
        }
    }
    return $prereqs | Select-Object -Unique
}

# ------------------------------------------------------------------
# Helper: parse an HTML table into array of hashtables
# ------------------------------------------------------------------
function Parse-HtmlTable {
    param([string]$TableHtml)
    $rows = @()
    # Extract headers from <th>
    $headers = @()
    $thMatches = [regex]::Matches($TableHtml, '<th[^>]*>(.*?)</th>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($th in $thMatches) {
        $headers += (Strip-Html $th.Groups[1].Value).ToLower().Trim()
    }
    if ($headers.Count -eq 0) { return $rows }

    # Extract data rows <tr> that contain <td>
    $trMatches = [regex]::Matches($TableHtml, '<tr[^>]*>(.*?)</tr>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($tr in $trMatches) {
        $tdMatches = [regex]::Matches($tr.Groups[1].Value, '<td[^>]*>(.*?)</td>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
        if ($tdMatches.Count -eq 0) { continue }
        $row = @{}
        for ($i = 0; $i -lt [Math]::Min($headers.Count, $tdMatches.Count); $i++) {
            $row[$headers[$i]] = (Strip-Html $tdMatches[$i].Groups[1].Value)
        }
        $rows += $row
    }
    return $rows
}

# ------------------------------------------------------------------
# Helper: parse a GFM markdown pipe table into array of hashtables
# Format:  | Col1 | Col2 |
#          |------|------|
#          | val1 | val2 |
# ------------------------------------------------------------------
function Parse-MarkdownTable {
    param([string]$Text)
    $rows = @()
    $lines = $Text -split "`n" | Where-Object { $_.Trim() -match '^\|' }
    if ($lines.Count -lt 2) { return $rows }

    # First pipe-row is headers
    $headerLine = $lines[0]
    $headers = ($headerLine -split '\|' | Select-Object -Skip 1) |
               ForEach-Object { Strip-Html $_.Trim() } |
               Where-Object { $_ -ne '' } |
               ForEach-Object { $_.ToLower() }
    if ($headers.Count -eq 0) { return $rows }

    # Skip separator row (contains ---) and parse data rows
    foreach ($line in ($lines | Select-Object -Skip 2)) {
        if ($line.Trim() -match '^[\|\s\-:]+$') { continue }  # separator
        $cells = ($line -split '\|' | Select-Object -Skip 1) |
                 ForEach-Object {
                     $cell = Strip-Html $_.Trim()
                     # Extract name from TF-docs anchor: <a name="input_foo"></a> [foo\_bar](...) -> foo_bar
                     if ($cell -match 'name="(?:input|output|requirement|provider|resource)_([^"]+)"') {
                         $cell = $Matches[1]  # already clean underscore name
                     } elseif ($cell -match '^\[([^\]]+)\]') {
                         $cell = Clean-Cell ($Matches[1])  # strip backslash escapes
                     } else {
                         $cell = Clean-Cell $cell
                     }
                     $cell
                 }
        if ($cells.Count -eq 0) { continue }
        $row = @{}
        for ($i = 0; $i -lt [Math]::Min($headers.Count, $cells.Count); $i++) {
            if ($headers[$i] -ne '') { $row[$headers[$i]] = $cells[$i] }
        }
        $rows += $row
    }
    return $rows
}

# ------------------------------------------------------------------
# Helper: extract table (HTML or Markdown) from a section
# Returns array of hashtables
# ------------------------------------------------------------------
function Get-SectionTable {
    param([string]$Content, [string]$SectionPattern)
    $rows = @()
    # Try HTML table first
    if ($Content -match "(?s)$SectionPattern[\s\S]{0,200}?<table>([\s\S]*?)</table>") {
        $tableHtml = $Matches[1]
        $rows = Parse-HtmlTable "<table>$tableHtml</table>"
        if ($rows.Count -gt 0) { return $rows }
    }
    # Fall back to markdown pipe table
    # No character cap here — trimming to the next section heading is handled below.
    # A cap (e.g. {0,5000}) would silently truncate large tables in modules with
    # complex object-type inputs (e.g. windowsvirtualmachine with ~19 KB of inputs).
    if ($Content -match "(?s)$SectionPattern([\s\S]+)") {
        $section = $Matches[1]
        # Grab only content up to the next section header
        if ($section -match '(?s)([\s\S]+?)(?=\n#{1,3}\s|\z)') {
            $section = $Matches[1]
        }
        $rows = Parse-MarkdownTable $section
    }
    return $rows
}

# ------------------------------------------------------------------
# Helper: extract Inputs table
# ------------------------------------------------------------------
function Get-Inputs {
    param([string]$Content)
    $inputs = @()
    # Split on Inputs headers
    $sections = [regex]::Split($Content, '(?m)^#{1,3}\s+Inputs')
    if ($sections.Count -lt 2) { return $inputs }
    $rows = Get-SectionTable ($sections[1]) ''
    foreach ($row in $rows) {
        $name = if ($row['name']) { $row['name'].Trim() } else { '' }
        # Strip any remaining [xxx] markdown link syntax or backslash escapes
        if ($name -match '^\[([^\]]+)\]') { $name = Clean-Cell $Matches[1] }
        $name = Clean-Cell $name
        if ([string]::IsNullOrEmpty($name)) { continue }
        $desc = if ($row['description']) { (Clean-Cell $row['description']).Trim() } else { '' }
        $type = if ($row['type']) { Clean-Cell $row['type'] } else { 'string' }
        $default = if ($row['default']) { Clean-Cell $row['default'] } else { $null }
        $required = if ($row['required']) { $row['required'].Trim().ToLower() -eq 'yes' } else { $false }
        if ($default -eq 'n/a' -or $default -eq '') { $default = $null }
        $inputs += [ordered]@{
            name        = $name
            description = $desc
            type        = $type.Trim()
            default     = $default
            required    = $required
        }
    }
    return $inputs
}

# ------------------------------------------------------------------
# Helper: extract Outputs table
# ------------------------------------------------------------------
function Get-Outputs {
    param([string]$Content)
    $outputs = @()
    # Find ALL Outputs sections and use the last populated one
    $sections = [regex]::Split($Content, '(?m)^#{1,3}\s+Outputs')
    $bestRows = @()
    foreach ($section in ($sections | Select-Object -Skip 1)) {
        $rows = Get-SectionTable $section ''
        if ($rows.Count -gt $bestRows.Count) { $bestRows = $rows }
    }
    foreach ($row in $bestRows) {
        $name = if ($row['name']) { $row['name'].Trim() } else { '' }
        if ($name -match '^\[([^\]]+)\]') { $name = Clean-Cell $Matches[1] }
        $name = Clean-Cell $name
        if ([string]::IsNullOrEmpty($name)) { continue }
        $desc = if ($row['description']) { (Clean-Cell $row['description']).Trim() } else { '' }
        $outputs += [ordered]@{ name = $name; description = $desc }
    }
    return $outputs
}

# ------------------------------------------------------------------
# Helper: extract Resources table (only rows with resource/data source types)
# ------------------------------------------------------------------
function Get-Resources {
    param([string]$Content)
    $resources = @()
    # Split on Resources headers and process each candidate section
    $sections = [regex]::Split($Content, '(?m)^#{1,3}\s+Resources')
    foreach ($section in ($sections | Select-Object -Skip 1)) {
        $rows = Get-SectionTable $section ''
        $found = @()
        foreach ($row in $rows) {
            $name = if ($row['name']) { $row['name'] -replace '\[([^\]]+)\].*', '$1' } else { '' }
            $name = $name.Trim()
            if ([string]::IsNullOrEmpty($name)) { continue }
            $type = if ($row['type']) { $row['type'].Trim() } else { '' }
            if ($type -notmatch '(?i)resource|data source|module') { continue }
            $found += [ordered]@{ terraform_resource = $name; type = $type }
        }
        if ($found.Count -gt 0) { $resources = $found; break }
    }
    return $resources
}

# ------------------------------------------------------------------
# Helper: extract Terraform Requirements (provider versions)
# ------------------------------------------------------------------
function Get-Requirements {
    param([string]$Content)
    $reqs = @{}
    # Split on Requirements headers and process each candidate section
    $sections = [regex]::Split($Content, '(?m)^#{1,3}\s+Requirements')
    foreach ($section in ($sections | Select-Object -Skip 1)) {
        $rows = Get-SectionTable $section ''
        foreach ($row in $rows) {
            $name = if ($row['name']) { ($row['name'] -replace '\[([^\]]+)\].*', '$1').Trim() } else { '' }
            $ver  = if ($row['version']) { $row['version'].Trim() } else { '' }
            if ($name -and $ver -match '>|=|~|\d') { $reqs[$name] = $ver }
        }
    }
    return $reqs
}

# ------------------------------------------------------------------
# Helper: build a usage example Terraform block
# ------------------------------------------------------------------
function Build-UsageExample {
    param(
        [string]$CpfId,
        [string]$GitLabUrl,
        [array]$RequiredInputs
    )
    $moduleName = $CpfId -replace '^cpf-azure-(prdsvc|prdapppat|prdsvcpat)-', ''
    $lines = @("module `"$moduleName`" {")
    $lines += "  source  = `"$GitLabUrl`""
    $lines += ""
    foreach ($inp in $RequiredInputs) {
        $lines += "  $($inp.name) = <$($inp.type)>  # $($inp.description -replace '"', '')"
    }
    $lines += "}"
    return $lines -join "`n"
}

# ------------------------------------------------------------------
# Helper: determine module category from CPF ID
# ------------------------------------------------------------------
function Get-ModuleType {
    param([string]$CpfId)
    if ($CpfId -match 'prdsvcpat') { return "service-pattern" }
    if ($CpfId -match 'prdapppat') { return "application-pattern" }
    return "service"
}

# ------------------------------------------------------------------
# Helper: derive Azure service name from folder name
# Inserts spaces before capital letters to split camelCase
# ------------------------------------------------------------------
function Get-AzureServiceName {
    param([string]$FolderName)
    $svc = $FolderName -replace '^cpf-azure-(prdsvc|prdapppat|prdsvcpat)-', ''
    # Handle hyphenated names first
    $svc = $svc -replace '-', ' '
    # Insert space before capital letter sequences embedded in lowercase
    $svc = [regex]::Replace($svc, '(?<=[a-z])(?=[A-Z])', ' ')
    return (Get-Culture).TextInfo.ToTitleCase($svc.ToLower())
}

# ==================================================================
# MAIN
# ==================================================================

if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    Write-Host "Created output directory: $OutputDir"
}

$folders = Get-ChildItem $CpfRoot -Directory | Sort-Object Name
$total = $folders.Count
$count = 0
$errors = @()

Write-Host "Processing $total CPF modules..."
Write-Host ("=" * 60)

foreach ($folder in $folders) {
    $count++
    $cpfId = $folder.Name
    $indexPath = Join-Path $folder.FullName "index.md"

    if (-not (Test-Path $indexPath)) {
        Write-Host "[$count/$total] SKIP (no index.md): $cpfId"
        continue
    }

    Write-Host "[$count/$total] Processing: $cpfId"

    try {
        $content = [System.IO.File]::ReadAllText($indexPath, [System.Text.Encoding]::UTF8)
        # Normalize CRLF to LF so multiline regex anchors work correctly
        $content = $content -replace "`r`n", "`n" -replace "`r", "`n"

        # Extract all components
        $title       = Get-ModuleTitle    $content
        $gitlabUrl   = Get-GitLabSource   $content
        $moduleVersion = Get-ModuleVersion $content
        $tfSource    = Get-TerraformSource $cpfId $gitlabUrl $moduleVersion
        $moduleType  = Get-ModuleType     $cpfId
        $azureService = Get-AzureServiceName $cpfId
        $prerequisites = Get-Prerequisites $content
        $inputs      = Get-Inputs         $content
        $outputs     = Get-Outputs        $content
        $resources   = Get-Resources      $content
        $requirements = Get-Requirements  $content

        # Get required vs optional inputs
        $requiredInputs  = $inputs | Where-Object { $_.required -eq $true }
        $optionalInputs  = $inputs | Where-Object { $_.required -eq $false }

        # Build the JSON schema object
        $schema = [ordered]@{
            "`$schema"             = "http://json-schema.org/draft-07/schema#"
            "title"                = "CPF Module Schema: $title"
            "description"         = "JSON schema for CPF module '$cpfId'. Use this to generate Terraform code that calls the CPF module."
            "cpf_id"              = $cpfId
            "module_type"         = $moduleType
            "azure_service"       = $azureService
            "module_name"         = $title
            "latest_tag"          = $moduleVersion
            "gitlab_repository"   = $gitlabUrl
            "terraform_source"    = $tfSource
            "terraform_requirements" = $requirements
            "prerequisites"       = @($prerequisites)
            "azure_resources_created" = @($resources)
            "terraform_usage" = [ordered]@{
                "module_call_template" = [ordered]@{
                    "module_label"   = ($cpfId -replace '^cpf-azure-(prdsvc|prdapppat|prdsvcpat)-', '')
                    "source"         = $tfSource
                    "version"        = if ($moduleVersion -ne "") { $moduleVersion } else { "latest" }
                }
            }
            "inputs" = [ordered]@{
                "type"       = "object"
                "required"   = @($requiredInputs | ForEach-Object { $_.name })
                "properties" = [ordered]@{}
            }
            "outputs" = [ordered]@{}
            "agent_instructions" = [ordered]@{
                "summary"     = "To provision '$azureService' via Terraform, call this CPF module with the inputs defined below. Required inputs have no default and must be provided."
                "module_type_notes" = switch ($moduleType) {
                    "service"          { "This is a single-service CPF module. It provisions one Azure resource type." }
                    "service-pattern"  { "This is a service pattern module. It bundles multiple related services/configurations." }
                    "application-pattern" { "This is an application pattern module. It provisions a full application-ready infrastructure stack." }
                }
                "naming_convention" = "Resource names are auto-generated by the module using app_id, environment, and region."
                "prerequisite_modules" = @($prerequisites)
            }
        }

        # Populate inputs properties
        foreach ($inp in $inputs) {
            $prop = [ordered]@{
                "type"        = $inp.type
                "description" = $inp.description
                "required"    = $inp.required
            }
            if ($null -ne $inp.default -and $inp.default -ne "") {
                $prop["default"] = $inp.default
            }
            $schema["inputs"]["properties"][$inp.name] = $prop
        }

        # Populate outputs
        foreach ($out in $outputs) {
            $schema["outputs"][$out.name] = [ordered]@{
                "description" = $out.description
            }
        }

        # Convert to JSON and save
        $jsonContent = $schema | ConvertTo-Json -Depth 20 -Compress:$false
        $outputPath = Join-Path $OutputDir "$cpfId.json"
        [System.IO.File]::WriteAllText($outputPath, $jsonContent, [System.Text.Encoding]::UTF8)

    } catch {
        $errors += "[$cpfId] Error: $($_.Exception.Message)"
        Write-Warning "Error processing $cpfId`: $($_.Exception.Message)"
    }
}

Write-Host ""
Write-Host ("=" * 60)
Write-Host "Done. Generated schemas in: $OutputDir"
Write-Host "Total modules: $total | Processed: $count | Errors: $($errors.Count)"

if ($errors.Count -gt 0) {
    Write-Host ""
    Write-Host "Errors encountered:"
    $errors | ForEach-Object { Write-Warning $_ }
}

# Generate an index/catalog file listing all schemas
$catalog = @{
    generated_at   = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
    total_modules  = $count
    output_dir     = $OutputDir
    modules        = @()
}

Get-ChildItem $OutputDir -Filter "*.json" | Where-Object { $_.Name -ne "_catalog.json" } | Sort-Object Name | ForEach-Object {
    try {
        $mod = Get-Content $_.FullName -Raw | ConvertFrom-Json
        $catalog.modules += [ordered]@{
            cpf_id        = $mod.cpf_id
            module_type   = $mod.module_type
            azure_service = $mod.azure_service
            module_name   = $mod.module_name
            latest_tag    = $mod.latest_tag
            schema_file   = $_.Name
            input_count   = ($mod.inputs.properties.PSObject.Properties | Measure-Object).Count
            output_count  = ($mod.outputs.PSObject.Properties | Measure-Object).Count
        }
    } catch { }
}

$catalogPath = Join-Path $OutputDir "_catalog.json"
$catalog | ConvertTo-Json -Depth 10 | Out-File -FilePath $catalogPath -Encoding UTF8
Write-Host "Catalog written: $catalogPath"

# Generate a flat version map: cpf_id -> { version, pinned_source }
# Useful for quick lookups by downstream tools without parsing full schemas.
$versionMap = [ordered]@{
    generated_at = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
    modules      = [ordered]@{}
}

Get-ChildItem $OutputDir -Filter "*.json" |
    Where-Object { $_.Name -notin @("_catalog.json", "_version-map.json") } |
    Sort-Object Name |
    ForEach-Object {
        try {
            $mod = Get-Content $_.FullName -Raw | ConvertFrom-Json
            if (-not [string]::IsNullOrEmpty($mod.cpf_id)) {
                $versionMap.modules[$mod.cpf_id] = [ordered]@{
                    version       = if ($mod.latest_tag) { $mod.latest_tag } else { "" }
                    pinned_source = $mod.terraform_source
                }
            }
        } catch { }
    }

$versionMapPath = Join-Path $OutputDir "_version-map.json"
$versionMap | ConvertTo-Json -Depth 5 | Out-File -FilePath $versionMapPath -Encoding UTF8
Write-Host "Version map written: $versionMapPath"
