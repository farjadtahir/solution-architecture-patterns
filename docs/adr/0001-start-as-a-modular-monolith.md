# ADR 0001: Start as a modular monolith

* **Status:** Accepted (worked example)
* **Date:** 2026-01-15
* **Deciders:** Engineering lead, product lead, and the two backend developers

> This is a fictional example that shows how to fill in the [ADR template](0000-adr-template.md). The company, numbers, and details are invented for illustration.

## Context

A small company is building a subscription billing product for local gyms. The facts at the time of the decision:

* One product team of five developers, with no dedicated operations staff.
* The business domain is still being discovered. Pricing rules and reporting needs change nearly every month.
* Expected traffic in the first year is modest, and steady during business hours.
* Several features, such as invoices and payments, need strong consistency.
* The team has solid experience with one web framework and with relational databases. It has little experience running distributed systems.
* The company hopes to grow, and may add a second product team within two years.

## Decision

We will build the product as a **modular monolith**: one deployable application, split into modules for accounts, subscriptions, invoicing, and reporting. Each module will expose a small public interface and own its own database tables. Automated checks in the build will fail if a module reaches into another module's internals.

## Options considered

| Option | Benefits | Costs and risks |
|---|---|---|
| Plain [monolith](../01-monolith.md) | Fastest start, least structure to maintain. | Boundaries are likely to erode as the team grows, which makes later changes harder. |
| [Modular monolith](../02-modular-monolith.md) | Simple operations, clear ownership, strong consistency, and a prepared path to split later. | Needs discipline and boundary checks. Modules cannot scale or deploy independently. |
| [Microservices](../03-microservices.md) | Independent deployment and scaling. | Too much operational work for five developers. Domain boundaries are not yet stable, so splits would likely be wrong. |
| [Serverless](../04-serverless.md) | Low operations effort and pay per use. | Billing workflows need strong consistency across steps, and the team prefers to avoid provider specific lock in. |

## Consequences

**Easier:**

* One build, one deployment, and one place to look when something fails.
* Transactions across invoicing and payments stay simple.
* Changing boundaries while the domain is still moving is a code change, not a migration.

**Harder:**

* The team must keep boundaries honest. Boundary checks run in continuous integration, and breaking them requires explicit approval.
* All modules deploy together, so a broken module can block a release.
* If one module needs very different scaling later, we will need to extract it.

## Revisit when

* A second team is formed and the teams block each other on releases.
* Measurements show one module needs scaling that the rest does not.
* A compliance rule requires stronger isolation for a part of the system.
* Build or test times grow enough to slow delivery noticeably.

## Links

* [Modular Monolith](../02-modular-monolith.md)
* [Decision guide](../decision-guide.md)
* [Case study: Shopify's modular monolith](../case-studies/02-shopify-modular-monolith.md)
