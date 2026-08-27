# API Documentation

API Documentation should serve as a comprehensive and user-friendly reference, detailing how to effectively use and integrate with an API.

A good API Documentation includes:
- Authentication Methods
- Available Endpoints (preferrably grouped by use-case)
- Parameters
- Request/Response formats
- Error codes

**Examples**
- Gitlab REST API: https://docs.gitlab.com/api/rest/
- Gitlab OpenAPI implementation: https://gitlab.com/gitlab-org/gitlab/-/blob/master/doc/api/openapi/openapi.yaml
- Kubernetes API reference: https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.32/#api-overview

**Standards**

A common standard for API Documentation is the [OpenAPI Specification](https://spec.openapis.org/oas/v3.1.0).

## Automation

Automation of the API Documentation is relatively easy if using the OpenAPI spec. The end-to-end approach would look like this:
1. Instrument your API code with necessary OpenAPI metadata (language/tool specific).
2. In your CI/CD pipeline, generate the OpenAPI spec as an artifact.
3. Reference the artifact according to the visualisation tool requirements

### Tooling Examples

**Spec Generation**
- Java - [swagger-core](https://github.com/swagger-api/swagger-core/wiki/Swagger-2.X---Integration-and-Configuration)
- Python - [FastAPI](https://fastapi.tiangolo.com/how-to/extending-openapi/?h=#generate-the-openapi-schema)
- Golang - [Swaggo](https://github.com/swaggo/swag)

**API Spec Visualisation**
- Gitlab `openapi.yaml` files. See: [Documentation](https://docs.gitlab.com/ee/api/openapi/openapi_interactive.html), [Example](https://gitlab.com/gitlab-org/gitlab/-/blob/master/doc/api/openapi/openapi.yaml)
- Confluence OpenAPI Plugin. See: [Open API Documentation for Confluence](https://marketplace.atlassian.com/apps/1215176/open-api-documentation-for-confluence?tab=overview&hosting=cloud)
