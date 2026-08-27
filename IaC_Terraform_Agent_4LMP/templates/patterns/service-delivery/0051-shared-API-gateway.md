---
id: LMP-PAT-0051
type: Functional Design Pattern
status: published
date: 2024-12-17
valid_from: 2024-12-17
developer_productivity_hrs: 0
approved_by:
  - LMP Migration Architecture Approval
tags:
  - Interfaces & APIs
tech_capabilities:
  - Platform / Application / Message Bus & Integration / Interfaces & APIs
---

# Shared API Gateway

## Introduction

The Shared API Gateway is a single instance API Gateway.  APIs will be published to this gateway from
multiple 'API Providers' these will be producing API implementations across many platforms, on-prem, AWS, Azure and
external.  This pattern will outline the process for publishing APIs to the shared gateway with the aim of
making this as frictionless and convenient as possible.  This will help reduce the lead time between a publisher wishing
to deploy an API to the gateway and it being available and ready to use.

## Scope

API provider has created a new API and wishes to expose this via an API gateway for wider use.
This pattern can also be followed for the migration of APIs published on existing platforms and
being moved to the Shared API Gateway.
The Gateway is intended for externally facing APIs, primarily for customer use.  This guide should be therefore followed
for those providers wishing to expose their APIs externally.

APIs published internally on other API gateways would not need to follow this pattern
and would likely have their own process for deployment

## Use Cases

A shared API gateway offers numerous benefits, including centralized management of API traffic,
which enhances security by providing a single entry point for all API requests.
It simplifies the implementation of cross-cutting
concerns such as authentication, authorization, rate limiting, and logging, ensuring consistent
enforcement of policies across all services. Additionally, it improves scalability and performance by
offloading common tasks from individual services, allowing them to focus on core functionality.
The gateway also facilitates easier monitoring and analytics, providing valuable insights into
API usage patterns and potential issues. Overall, a shared API gateway streamlines API management,
enhances security, and improves the efficiency of service interactions.

The shared GW has been fully reviewed and approved from a security perspective,  onboarding API providers will
simply have to follow the onboarding process to publish their APIs to the platform.  They will not have to
maintain their own infrastructure or conduct their own security and architecture reviews for the API surface.
They will still be responsible for the approval of the backend API implementation.

THe shared API Gateway is primarily focussed on providing externally facing API access, for internal service to
service calls then other platforms such as APIM may be a more appropriate choice

## Functional Requirements

API Providers will onboard through API Provider Portal.  This will provide the ability for the API provider to track the
progress through the onboarding lifecycle and engage the relevant teams

During the initial design the API Providers should follow the
[API Guidelines](https://lsegroup.sharepoint.com/teams/APILifecycle/SitePages/API-Design-Guidelines.aspx?web=1)
when designing their API.  To facilitate this Spectral tooling can be used within Postman to check compliance with the guidelines.

## Infrastructure

Network connectivity between the API implementation and Gateway will need to be established.  This could take the form of:-

- Private Link
- On Prem routing
- AWS Routing
- External

Indicative initial usage and future growth would need to be provider by the onboarding team to
ensure capacity management can take place

## Configuration

OAS spec is intended to be kept as clean as possible so the configuration is driven by separate config files

Each Kong plugin will require a separate config file, this will contain just the configuration of that plugin
and be a cut down versions of that, with just the pertinent config being exposed to the provider.
The other configuration will be completed by the API deployment pipeline

Deployment pipeline will contain:-

- OAS for the API definition
- Any number of config files to configure any plugins required by the API
- Markdown documentation to be used to describe the API in the API Portal

Each API will be required to provide a healthcheck endpoint to ensure effective monitoring of the API status

There will be two environments that are usable for the API Providers, a PPE environment for testing and the Production environment.
Configuration can be provided on a per environment basis, allowing teams to have different configuration in PPE to Prod

Multi-region environments will be available moving forward and will be able to be configured separately
through the use of separate config files for each region

## Deployment

A standard API deployment pipeline will be made available to deploy the API definition, config and documentation.
This will have check against API design guideline and deployment approvals

A separate config only pipeline will be available to enable API Providers to make configuration changes to the APIs,
for example amending the rate limit without the risk of impacting the API

## AuthZ and AuthN

API Provider would need to establish the AuthN requirements for their API. This could be :-

- Entra
- STS/AAA
- Ping
- Heimdal

Once this has been established then configuration is required on the API route to apply the particular AuthN mechanism.
This is done through plugin configuration

AuthZ is handled by PO codes.  These would need to be created in a specific namespaces and attached to appropriate licenses.
These are relevant only to the gateway and will cover macro level entitlements.
This is to allow access to an API endpoint or not.
The configuration is supplied through a plugin configuration file and enforced by the gateway on each request.
If there are any micro level,content specific entitlements then these should be handled via the backend AP
implementation or backing services and be part of a separate entitlement namespace

![Shared Gateway](img/0051-sharedgw.png "Process Overview")

## Further Reading

To begin the onboarding process please get in contact with [API Centre of Excellence](mailto:api-coe@lseg.com)
and they will guide through the process

For further reading on the overall API Strategy please see this document [API Strategy](https://lsegroup.sharepoint.com/:p:/r/teams/LSEGLMPAppMigrationApprovers/Shared%20Documents/Architecture%20Docs%20-%20Proposals,%20Strategies%20etc/D%26A%20API%20Strategy%20-%20LMP%20SIAs%20%26%20Migrations.pptx?d=w4529665b39e34cc4be47920ea4439e4d&csf=1&web=1&e=RNL3yh)

