ts() { echo "[$(date +'%F %T')] $*"; }
ok() { echo "[$(date +'%F %T')] ✔ $*"; }
err(){ echo "[$(date +'%F %T')] ERROR: $*" >&2; exit 1; }

require_env() {
  local missing=()
  for v in "$@"; do
    if [ -z "${!v:-}" ]; then missing+=("$v"); fi
  done
  if ((${#missing[@]})); then
    err "Missing required environment variables: ${missing[*]}"
    exit 1
  fi
}

download_with_auth() {
  # usage: download_with_auth URL DEST_DIR USERNAME PASSWORD
  local url="$1"
  local dest="$2"
  local usrname="$3"
  local pswrd="$4"
  local filename
  filename=$(basename "$url")
  ts "Downloading $filename to $dest"
  wget -q "$url" -O "$dest/$filename" --user="$usrname" --password="$pswrd" || { err "Download failed: $url"; return 1; }
}

wait_for_file() {
  # Poll until file exists or timeout (works with directories too!)
  local file="$1"
  local timeout="$2"
  local elapsed=0

  while [ ! -d "$file" ] && [ $elapsed -lt $timeout ]; do
    sleep 2
    elapsed=$((elapsed+2))
  done
  [ -e "$file" ] || err "file is not present after ${timeout}s: $file"
}

trap 'err "Failed at line $LINENO: $BASH_COMMAND"' ERR