<span class="md-content__button md-icon md-status--published" href="#" title="Status: Published"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE4LjUgMmgtMTNDMy42IDIgMiAzLjYgMiA1LjV2MTNDMiAyMC40IDMuNiAyMiA1LjUgMjJIMTZsNi02VjUuNUMyMiAzLjYgMjAuNCAyIDE4LjUgMk0yMCAxNWgtMS41Yy0xLjkgMC0zLjUgMS42LTMuNSAzLjVWMjBINS44Yy0xIDAtMS44LS44LTEuOC0xLjhWNS44QzQgNC44IDQuOCA0IDUuOCA0aDEyLjVjMSAwIDEuOC44IDEuOCAxLjhWMTVtLTQuOS02LjggMS41IDEuNS02IDYtMy41LTMuNSAxLjUtMS41IDIgMnoiIC8+PC9zdmc+) </span> <span class="md-content__button md-icon .md-status--published" title="Valid from 2024-06-28"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE5IDE5SDVWOGgxNG0wLTVoLTFWMWgtMnYySDhWMUg2djJINWEyIDIgMCAwIDAtMiAydjE0YTIgMiAwIDAgMCAyIDJoMTRhMiAyIDAgMCAwIDItMlY1YTIgMiAwIDAgMC0yLTJtLTIuNDcgOC4wNkwxNS40NyAxMGwtNC44OCA0Ljg4LTIuMTItMi4xMi0xLjA2IDEuMDZMMTAuNTkgMTd6IiAvPjwvc3ZnPg==) </span> <span class="md-content__button md-icon actions-date" title="Published on 2024-06-28">![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkgMTB2Mkg3di0yem00IDB2MmgtMnYtMnptNCAwdjJoLTJ2LTJ6bTItN2EyIDIgMCAwIDEgMiAydjE0YTIgMiAwIDAgMS0yIDJINWEyIDIgMCAwIDEtMi0yVjVhMiAyIDAgMCAxIDItMmgxVjFoMnYyaDhWMWgydjJ6bTAgMTZWOEg1djExek05IDE0djJIN3YtMnptNCAwdjJoLTJ2LTJ6bTQgMHYyaC0ydi0yeiIgLz48L3N2Zz4=)</span> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/edit/main/docs/patterns/identity-and-access-management/0024-internal-web-authentication-entra-and-oidc.md" class="md-content__button md-icon" title="Edit this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEwIDIwSDZWNGg3djVoNXYzLjFsMi0yVjhsLTYtNkg2Yy0xLjEgMC0yIC45LTIgMnYxNmMwIDEuMS45IDIgMiAyaDR6bTEwLjItN2MuMSAwIC4zLjEuNC4ybDEuMyAxLjNjLjIuMi4yLjYgMCAuOGwtMSAxLTIuMS0yLjEgMS0xYy4xLS4xLjItLjIuNC0uMm0wIDMuOUwxNC4xIDIzSDEydi0yLjFsNi4xLTYuMXoiIC8+PC9zdmc+" /></a> <a href="https://gitlab.dx1.lseg.com/app/app-51723/migration-patterns/mig-pat-source-to-target/blob/main/docs/patterns/identity-and-access-management/0024-internal-web-authentication-entra-and-oidc.md" class="md-content__button md-icon" title="View source of this page"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3IDE4Yy41NiAwIDEgLjQ0IDEgMXMtLjQ0IDEtMSAxLTEtLjQ0LTEtMSAuNDQtMSAxLTFtMC0zYy0yLjczIDAtNS4wNiAxLjY2LTYgNCAuOTQgMi4zNCAzLjI3IDQgNiA0czUuMDYtMS42NiA2LTRjLS45NC0yLjM0LTMuMjctNC02LTRtMCA2LjVhMi41IDIuNSAwIDAgMS0yLjUtMi41IDIuNSAyLjUgMCAwIDEgMi41LTIuNSAyLjUgMi41IDAgMCAxIDIuNSAyLjUgMi41IDIuNSAwIDAgMS0yLjUgMi41TTkuMjcgMjBINlY0aDd2NWg1djQuMDdjLjcuMDggMS4zNi4yNSAyIC40OVY4bC02LTZINmEyIDIgMCAwIDAtMiAydjE2YTIgMiAwIDAgMCAyIDJoNC41YTguMiA4LjIgMCAwIDEtMS4yMy0yIiAvPjwvc3ZnPg==" /></a>

Document Metadata

|  |  |
|----|----|
| Identifier | **`LMP-PAT-0024`** |
| Type | **Technical Design Pattern** |
| Status | **Published** |
| Approvals | <span class="md-tag">LMP Migration Architecture Approval</span> |
| Governance Reference | **[]()** |
| Pattern Source Repo | []() |
| Published on | **June 28, 2024** |
| Valid From | **June 28, 2024** |
| Authors | <span class="md-source-file__fact"> </span> |
| Tags | <span class="md-tag">Identity & Access Management</span> |
| Technology Capabilities | <span class="md-tag">Delivery / Security & Compliance / Identity & Access Management</span> |

# Internal Web Authentication / SSO using OIDC and Microsoft Entra<a href="#internal-web-authentication-sso-using-oidc-and-microsoft-entra" class="headerlink" title="Permanent link">¶</a>

## Introduction<a href="#introduction" class="headerlink" title="Permanent link">¶</a>

This pattern describes the model of using Microsoft Entra to provide single sign-on (SSO) authentication capabilities for internal users of applications in a web context.

The pattern is based on the group-wide [SP-0013 - Workforce User Authentication Pattern](https://confluence.refinitiv.com/display/PSAR/SP-0013+-+Authentication%3A+Workforce+User+Authentication+-+DRAFT) and [SP-0014 - Authentication - Component-to-Component Pattern](https://confluence.refinitiv.com/display/PSAR/SP-0014+-+Authentication+-+Component-to-Component+-+Full+Pattern+-+DRAFT).

The [cybersecurity MEC](https://lsegroup.sharepoint.com/:x:/r/teams/LMFoundationFM/_layouts/15/Doc.aspx?sourcedoc=%7BA885D426-5FF8-405B-9516-37F2EB533E2F%7D&file=Foundation%20Pillar-MinimumEntryCriteria-v0_2.xlsx&action=default&mobileredirect=true) item `SEC.MEC6.2` states that:

> Internally Exposed APIs: Internally consumed APIs are subject to positive authentication and authorisation with granular decisions for each consumer.

Item `SEC.MEC6.2` states that:

> Applications accessed by LSEG staff from within the LSEG network - the Application is using LSEG Approved Single Sign On capabilities using Modern Authentication Methods.

In this context, Microsoft Entra is the "LSEG Approved Single Sign On" system.

## Scope<a href="#scope" class="headerlink" title="Permanent link">¶</a>

As per the MEC, this scope includes any application that is looking to interactively authenticate internal staff users when providing functionality to those users in an interactive web-based context. The scope also includes LSEG-managed server systems requiring authentication before providing service to other LSEG-managed systems.

Authenticating internal users when they're part of a wider identity pool that includes external users is *out of scope*.

## Use Cases<a href="#use-cases" class="headerlink" title="Permanent link">¶</a>

> As an application engineer, I would like to require that incoming requests to my system from both human and system actors are strongly authenticated against a common identity domain so that I can reliably use that identity to make authorisation and entitlement decisions.

## Functional Requirements<a href="#functional-requirements" class="headerlink" title="Permanent link">¶</a>

The standard approach here is to use OpenID Connect (OIDC) to establish trust between the system ("relying party" or " RP") and the end-user, provided by MS Entra ("identity provider", or "IdP"). OIDC is based on the [OAuth 2.0 Framework](https://datatracker.ietf.org/doc/html/rfc6749).

If the application is required to persist data related to the authenticated user, they *SHOULD* use the user's employee ID, which is returned as the value of the claim named `employeeid` in the user's identity token.

### Pre-requisites<a href="#pre-requisites" class="headerlink" title="Permanent link">¶</a>

- The end-user has an active account & identity in the LSEG tenant of Microsoft Entra
- The relying party has been configured as an application in the IdP, and posseses both a "client identifier" and a " client secret" credential
- In the case where the end-user is a human, they are able to access both the relying party and the IdP either via the internet or via ZScaler Private Access (ZPA).
- In the case of human / interactive authentication, the relying party is able to access the IdP via the internet.
- In the case of system / system authentication, the system acting as the client is able to access the IdP via the internet.

### Context Diagram<a href="#context-diagram" class="headerlink" title="Permanent link">¶</a>

![Context Diagram](0024-internal-web-authentication-entra-and-oidc.assets/image-001.png)

### Deployment Diagram<a href="#deployment-diagram" class="headerlink" title="Permanent link">¶</a>

Example for Kubernetes with Nginx Ingress Controller, with connectivity to Entra back outbound via the internet

![Deployment Diagram](0024-internal-web-authentication-entra-and-oidc.assets/image-001.png)

### OIDC Flows<a href="#oidc-flows" class="headerlink" title="Permanent link">¶</a>

The OIDC specification describes a number of different flows, depending on what's needed by the relying party. In general, the most commonly-applicable flows are the Authorization Code Flow and the Client Credentials Flow.

#### Authorization Code Flow<a href="#authorization-code-flow" class="headerlink" title="Permanent link">¶</a>

This flow is primarily for humans in a context where they can interact with an authentication challenge from Entra. Typically, this will be a web browser.

The general principle is that the relying party detects an unauthenticated user (or user without a valid session), redirects that user to log into the IdP. On successful authentication to the IdP, the IdP issues an opaque code back to the user which the user then uses to send to the relying party. Finally, the relying party contacts the IdP with the code, exchanging it for a JWT-formatted *ID token*, an opaque *access token*, and (optionally) an opaque *refresh token*.

One of the main characteristics of this flow is that the RP is granted the ability to call other services on behalf of the end user. This is the purpose of the access token ends up with an access token that can be used to make requests of other services on behalf of the end user.

![Deployment Diagram](0024-internal-web-authentication-entra-and-oidc.assets/image-001.png)

Key factors in this flow are:

- The relying party is entirely responsible for session management. This includes detecting requests without a valid session and creating / storing sessions for users once they have been authenticated.
- The relying party *MUST* protect against cross-site request forgery (XSRF) by including a cryptographically-secure random state token when redirecting to the IdP. This state should be persisted and validated when the client returns from the IdP with an authorization code.
- The ID token returned from the IdP is a Javascript Web Token (JWT) that represents the authenticated user's identity. This *MUST* be validated. Specifically, the signature should be checked, the signature algorithm should be checked against a whitelist, the audience (`aud`) claim must be the same as the RP's client identity, and the expiry timestamp `exp` must be in the future.
- The access token returned from the IdP is for allowing the RP to call other services on behalf of the client. As such, it's effectively a sensitive credential, so should be treated as such. More details about the specific access tokens returned from Entra are available [from Microsoft](https://learn.microsoft.com/en-us/entra/identity-platform/access-tokens).
- If requested, the token exchange endpoint can also return a refresh token which can be used by the RP to request new access tokens for this end user if they expire. Access tokens typically have a fairly short lifetime, so if the RP needs to make requets to other services on behalf of the end user beyond the access token lifetime, the refresh token can be used against the IdP to issue a new access token. More details about refresh tokens from Entra are available [from Microsoft](https://learn.microsoft.com/en-us/entra/identity-platform/refresh-tokens).

#### Client Credentials Flow<a href="#client-credentials-flow" class="headerlink" title="Permanent link">¶</a>

This flow is useful mainly for system/system communication and authentication, where a service call is not being made on behalf of another user. It is simpler than the authorization code flow.

The main principles are the same as the authorization code flow. The primary difference is that the client system itself holds a set of credentials that it uses to fetch an *access token* directly from the Entra token endpoint. That access token can then be directly used against the server system.

![Deployment Diagram](0024-internal-web-authentication-entra-and-oidc.assets/image-001.png)

Key factors in this flow are:

- In the Microsoft Entra platform implementation, the server is capable of introspecting the supplied access token directly. The OIDC specification doesn't prescribe a method for validating the access token, and some implementations rely on the server passing the supplied access token to an "introspection endpoint". Microsoft chose to use JWTs as an access token format, allowing the server to parse and validate the access token with no request-time dependency on the IdP.
- The access token *can* be re-used for subsequent requests between the same client / server pair, assuming its constraints are still valid (e.g. not expired).

## Implementation<a href="#implementation" class="headerlink" title="Permanent link">¶</a>

It's highly recommended to use the [Microsoft Authentication Library](https://learn.microsoft.com/en-us/entra/identity-platform/msal-overview) which is available for a number of commonly-used ecosystems, including .NET, Java, Javascript, Python, Golang, Android and iOS.

In the event that MSAL isn't used, there are other libraries available that can help developers implement OIDC within their applications. It's recommended that these are used rather than trying to hand-roll the authentication process, but developers should study the documentation for these libraries carefully.

Authentication is a critical process, where small mistakes in implementation can easily turn into large security incidents.

## Further Reading<a href="#further-reading" class="headerlink" title="Permanent link">¶</a>

- [How OpenID Connect Works](https://openid.net/developers/how-connect-works/)
- [RFC6749 - The Oauth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749)
- [Access tokens in the Microsoft Identity Platform](https://learn.microsoft.com/en-us/entra/identity-platform/access-tokens)
- [Refresh tokens in the Microsoft Identity Platform](https://learn.microsoft.com/en-us/entra/identity-platform/refresh-tokens)
- [Microsoft identity platform and OAuth 2.0 authorization code flow](https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-auth-code-flow)
- [Microsoft identity platform and the OAuth 2.0 client credentials flow](https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-client-creds-grant-flow)

<span class="md-source-file__fact"> <span class="md-icon" title="Last update"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDEzLjFjLS4xIDAtLjMuMS0uNC4ybC0xIDEgMi4xIDIuMSAxLTFjLjItLjIuMi0uNiAwLS44bC0xLjMtMS4zYy0uMS0uMS0uMi0uMi0uNC0uMm0tMS45IDEuOC02LjEgNlYyM2gyLjFsNi4xLTYuMXpNMTIuNSA3djUuMmw0IDIuNC0xIDFMMTEgMTNWN3pNMTEgMjEuOWMtNS4xLS41LTktNC44LTktOS45QzIgNi41IDYuNSAyIDEyIDJjNS4zIDAgOS42IDQuMSAxMCA5LjMtLjMtLjEtLjYtLjItMS0uMnMtLjcuMS0xIC4yQzE5LjYgNy4yIDE2LjIgNCAxMiA0Yy00LjQgMC04IDMuNi04IDggMCA0LjEgMy4xIDcuNSA3LjEgNy45bC0uMS4yeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="May 30, 2025 16:15:49 UTC">May 30, 2025</span> </span> <span class="md-source-file__fact"> <span class="md-icon" title="Created"> ![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE0LjQ3IDE1LjA4IDExIDEzVjdoMS41djUuMjVsMy4wOCAxLjgzYy0uNDEuMjgtLjc5LjYyLTEuMTEgMW0tMS4zOSA0Ljg0Yy0uMzYuMDUtLjcxLjA4LTEuMDguMDgtNC40MiAwLTgtMy41OC04LThzMy41OC04IDgtOCA4IDMuNTggOCA4YzAgLjM3LS4wMy43Mi0uMDggMS4wOC42OS4xIDEuMzMuMzIgMS45Mi42NC4xLS41Ni4xNi0xLjEzLjE2LTEuNzIgMC01LjUtNC41LTEwLTEwLTEwUzIgNi41IDIgMTJzNC40NyAxMCAxMCAxMGMuNTkgMCAxLjE2LS4wNiAxLjcyLS4xNi0uMzItLjU5LS41NC0xLjIzLS42NC0xLjkyTTE4IDE1djNoLTN2MmgzdjNoMnYtM2gzdi0yaC0zdi0zeiIgLz48L3N2Zz4=) </span> <span class="git-revision-date-localized-plugin git-revision-date-localized-plugin-date" title="September 12, 2024 08:35:23 UTC">September 12, 2024</span> </span>

<a href="../../event-management/0079-observability-tech-ref-arch/" class="md-footer__link md-footer__link--prev" aria-label="Previous: Datadog Integration for Azure Services (Technical Design Pattern)"></a>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIwIDExdjJIOGw1LjUgNS41LTEuNDIgMS40Mkw0LjE2IDEybDcuOTItNy45MkwxMy41IDUuNSA4IDExeiIgLz48L3N2Zz4=)

</div>

<div class="md-footer__title">

<span class="md-footer__direction"> Previous </span>

<div class="md-ellipsis">

Datadog Integration for Azure Services (Technical Design Pattern)

</div>

</div>

<a href="../0061-external-authentication-patterns/" class="md-footer__link md-footer__link--next" aria-label="Next: External System Authentication Patterns"></a>

<div class="md-footer__title">

<span class="md-footer__direction"> Next </span>

<div class="md-ellipsis">

External System Authentication Patterns

</div>

</div>

<div class="md-footer__button md-icon">

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdib3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTQgMTF2MmgxMmwtNS41IDUuNSAxLjQyIDEuNDJMMTkuODQgMTJsLTcuOTItNy45MkwxMC41IDUuNSAxNiAxMXoiIC8+PC9zdmc+)

</div>

<div class="md-footer-meta md-typeset">

<div class="md-footer-meta__inner md-grid">

<div class="md-copyright">

Made with <a href="https://squidfunk.github.io/mkdocs-material/" target="_blank" rel="noopener">Material for MkDocs</a>

</div>

</div>

</div>

<div class="md-dialog" md-component="dialog">

<div class="md-dialog__inner md-typeset">

</div>

</div>
