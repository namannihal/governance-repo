---
id: LMP-ADR-0007
type: ADR
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-05-03
valid_from: 2024-05-25
tags:
  - User Experience Layer (UI)
  - Development Tools & SDKs
tech_capabilities:
  - Delivery / Development / Design & Development / Development Tools & SDKs
  - Delivery / Development / Design & Development / User Experience Layer (UI)
---

# Replace Silverlight with React

## Context and Problem Statement

We have applications that are built on [Microsoft Silverlight](https://www.microsoft.com/silverlight/), a technology designed
 as an alternative to Adobe Flash in 2007.

As of 2021, Silverlight is
 [End of Support](https://learn.microsoft.com/en-GB/lifecycle/products/silverlight-5), with support dropped from Internet
  Explorer 11, the final browser to support it. Internet Explorer 11 was itself
  [retired in June 2022](https://www.microsoft.com/en-gb/download/internet-explorer.aspx).

Teams migrating under LMP should use an alternative front-end technology.

## Decision Drivers

Choice of new front-end web technology should be driven by characteristics that are similar to any other technology selection,
 including:

- Internal and external popularity, usage and skills
- Cost and/or licence
- Ease of use
- Performance

## Considered Options

- [Angular](https://angular.io)
- [AngularJS](https://angularjs.org)
- [React](https://react.dev)
- [Blazor](https://dotnet.microsoft.com/en-us/apps/aspnet/web-apps/blazor)

## Decision Outcome

Chosen option: React because it is the Group's most common choice, in particular with Workspaces, a flagship web application.

Whilst Workspaces uses both Angular and React, the direction of travel is currently React.

### Consequences

- Good, because React's one-way data flow promotes simpler management of application state
- Good, because React's component based architecture promotes better modularity and composability
- Good, because it has wider industry adoption and community support, a more innovative eco-system and more skill availability

## Pros and Cons of the Options

### Angular

- Good, because it is mature, with a strong community and industry support
- Neutral, because it is comprehensive, but therefore less flexible
- Neutral, because it supports bidirectional data bindings, but this can complicate state management

### AngularJS

- Bad, because AngularJS support officially ended in January 2022

### Blazor

- Neutral, because can build front-ends without writing JavaScript (using .NET and C#), but teams may not have familiarity
 with .NET or may not use it in their project

## More Information

- [Workspace App Development Standards](https://confluence.refinitiv.com/display/EAD/Workspace+App+Development+Standards)

