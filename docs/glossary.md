# Glossary

[Back to the README](../README.md) | [Comparison](comparison.md) | [Decision guide](decision-guide.md)

Plain language definitions of terms used across this repository. Terms are in alphabetical order.

| Term | Meaning |
|---|---|
| **ACID** | A set of guarantees for database transactions: Atomicity (all or nothing), Consistency (rules are never broken), Isolation (concurrent work does not interfere), and Durability (committed data survives crashes). Easy within one database, hard across many services. |
| **API gateway** | A single entry point that routes client requests to the right backend service. It often also handles authentication, rate limiting, and logging. |
| **Blast radius** | How much of a system is affected when one part fails or is changed badly. Smaller is safer. |
| **Bounded context** | A boundary within which a particular domain model and its terms have one clear meaning. For example, "customer" may mean different things in billing and in support. A term from domain driven design, and a common guide for service boundaries. |
| **CAP theorem** | A result about distributed data systems: when the network is partitioned, you must choose between consistency and availability. It is often cited, and often oversimplified. |
| **Circuit breaker** | A safety mechanism that stops calling a failing dependency for a while, so failures do not pile up and the dependency can recover. |
| **Cold start** | The extra delay when a serverless platform has to start a new execution environment before running your code. |
| **Command** | A request to change something, such as "place order". It may be accepted or rejected. See [CQRS & Event Sourcing](07-cqrs-and-event-sourcing.md). |
| **Conway's law** | The observation that the structure of a system tends to mirror the communication structure of the organization that builds it. It is often used to argue that team design and architecture should be planned together. |
| **Coupling and cohesion** | Coupling is how much one part depends on another. Cohesion is how closely the contents of one part belong together. Good designs aim for low coupling and high cohesion. |
| **CQRS** | Command Query Responsibility Segregation. Using separate models for changing data and for reading data. |
| **Dead letter queue** | A holding area for messages that could not be processed after several attempts, so they can be inspected without blocking other messages. |
| **Dependency inversion** | A design principle where high level code depends on an abstraction, and low level details implement it. This is what lets [Hexagonal](06-hexagonal-architecture.md) and [Clean / Onion](09-clean-onion-architecture.md) keep business rules free of technology details. |
| **Distributed monolith** | A system split into separate services that are so tightly coupled they must be changed and deployed together. It combines the costs of both styles. See the [decision guide](decision-guide.md). |
| **Domain driven design (DDD)** | An approach to software that centers on modeling the business domain with a shared language between developers and domain experts. |
| **Domain event** | A record that something meaningful happened in the business, such as "order placed". Named in the past tense. |
| **Enterprise service bus (ESB)** | A central integration layer that routes and transforms messages between systems. Typical of classic [SOA](10-service-oriented-architecture.md). |
| **Event** | An immutable fact that something has happened. See [Event Driven Architecture](05-event-driven-architecture.md). |
| **Event sourcing** | Storing every change as an event, and rebuilding the current state by replaying events, instead of storing only the latest state. |
| **Eventual consistency** | A model where different parts of a system may briefly show different data, but will agree if no new changes arrive. The common trade off for scalability and independence. |
| **Idempotency** | The property that doing an operation more than once has the same effect as doing it once. Essential when messages or requests can be retried or delivered twice. |
| **In memory data grid** | A cluster of machines that holds data in memory and keeps it synchronized. Central to [Space Based Architecture](11-space-based-architecture.md). |
| **Message broker** | Software that receives messages from producers and delivers them to consumers, often with queues or topics. Examples include Kafka and RabbitMQ. |
| **Observability** | The ability to understand what a system is doing from the outside, using logs, metrics, and traces. |
| **Orchestration and choreography** | Two ways to coordinate a multi step process. With orchestration, a central coordinator tells each step what to do. With choreography, each component reacts to events and decides for itself. |
| **Outbox pattern** | A technique for reliably publishing events. The service saves the event in its own database as part of the same transaction as the data change, and a separate process publishes it afterward. |
| **Port and adapter** | In [Hexagonal](06-hexagonal-architecture.md) architecture, a port is an interface owned by the core, and an adapter is code that connects a port to a real technology such as a database or web framework. |
| **Projection** | A read model built by processing events. It is shaped for a particular screen or report. |
| **Saga** | A way to manage a business process that spans several services without a shared transaction. Each step has a matching compensating action that undoes it if a later step fails. |
| **Service mesh** | Infrastructure that manages service to service traffic, usually handling security, retries, and metrics outside the application code. |
| **Snapshot** | A saved copy of current state at a point in time, used so event replay does not have to start from the very first event. |
| **Strangler fig pattern** | A migration approach where new functionality gradually replaces parts of an old system, behind a routing layer, until the old system can be retired. |
| **Tier and layer** | A layer is a logical grouping of code. A tier is a physical place where code runs. See [Layered / N Tier](08-layered-n-tier.md). |
| **Two phase commit** | A protocol that coordinates a transaction across multiple databases. It provides strong guarantees, but reduces availability and is usually avoided across services. |
| **Vendor lock in** | Dependence on one provider's products that makes switching costly. A common concern with [Serverless](04-serverless.md). |
