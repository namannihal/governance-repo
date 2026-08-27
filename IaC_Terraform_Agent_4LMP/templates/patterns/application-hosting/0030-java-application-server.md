---
id: LMP-PAT-0030
type: Technology Selection Pattern
status: published
approved_by:
  - LMP Migration Architecture Approval
date: 2024-05-20
valid_from: 2024-05-20
developer_productivity_hrs: 5
tags:
  - Application Hosting
tech_capabilities:
  - Delivery / Development / Design & Development / Development Tools & SDKs
---

# Java Application Servers

## Compatibility

This pattern is for applications looking to deploy Java applications on an application server that implements
the [Jakarta EE][jakarta] (formerly J2EE, Java EE etc.) specification.

These applications may be currently on a wide range of different implementations, such as [Apache Tomcat][tomcat],
[Oracle WebLogic][weblogic], [IBM WebSphere][websphere], [IBM JBoss][jboss] or [Jetty][jetty].
The recommended target will depend on both context and features that are required.

## Recommended Target

The recommended guidance varies depending on the runtime context and required features of the Java application. Broadly,
there are three recommended targets:

- [Apache Tomcat][tomcat]
- [Oracle WebLogic][weblogic]
- [Eclipse Jetty][jetty]

## Decision Tree Diagram

![Decision Tree](img/0030-java-ee-decision.drawio.png)

## Notable Differences

|                              | Apache Tomcat                                           | Eclipse Jetty                                           | Oracle Weblogic                           |
|------------------------------|---------------------------------------------------------|---------------------------------------------------------|-------------------------------------------|
| **HTTP Servlet Engine**      | Yes                                                     | Yes                                                     | Yes                                       |
| **EJB support**              | Some (with [Apache Tomee][tomee])                       | No                                                      | Yes                                       |
| **Configuration Complexity** | Medium                                                  | Low                                                     | High                                      |
| **Costs**                    | Open-source                                             | Open-source                                             | Commercial agreement with per-CPU license |
| **Enterprise Support**       | Available if needed from multiple vendors, not required | Available if needed from multiple vendors, not required | Yes, part of commercial agreement         |

## Considerations

- **Hosting context**: There are many Java / JVM-based web applications running inside containers. Because containers
  tend to be lightweight, running just a single service with few dependencies, a lightweight and simple embedded runtime
  such as [Jetty][jetty] is most appropriate. Many frameworks (e.g. [Spring Boot][spring-boot]) come with native
  integration for Jetty making configuration and deployment straightforward.
- **Application type**: A large number of our Java / JVM-based applications are primarily providing web services. I.e.
  their hosting requirement is for a servlet container. [Apache Tomcat][tomcat] is the industry standard open-source
  Jakarta Servlet and web server implementation and is well suited for running Java web applications in a virtual
  machine
  context. Some Jakarta EE features may be supported by extending with [Apache Tomee][tomee].
- **EJB / monoliths**: For the applications that require more features in the Jakarta EE stack (e.g. EJB, Jakarta
  Messaging, JDBC pooling) and/or may be looking to run many different applications on the same host, a full Jakarta EE
  server is required. Our preferred choice here is [Oracle WebLogic][weblogic] as it is well-understood, well-supported
  and fully-featured.

## Alternatives

- [Azure Spring Apps][azure-spring-apps]: A fully-managed Spring service that abstracts the underlying compute. Check
  the [Clearlist][clearlist] for the current constraints (data classification etc.) on this product.

[jakarta]: https://jakarta.ee/

[tomcat]: https://tomcat.apache.org/

[tomee]: https://tomee.apache.org/

[weblogic]: https://www.oracle.com/uk/java/weblogic/

[jetty]: https://jetty.org/index.html

[spring-boot]: https://spring.io/projects/spring-boot

[azure-spring-apps]: https://azure.microsoft.com/en-gb/products/spring-apps

[clearlist]: https://gitlab.dx1.lseg.com/app/app-51285/cloud-security-controls/azure-clear-listing

[websphere]: https://www.ibm.com/products/websphere-application-server

[jboss]: https://www.ibm.com/support/pages/support-jboss-server

