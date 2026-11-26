# Case Studies

[Back to the README](../../README.md) | [Comparison](../comparison.md) | [Decision guide](../decision-guide.md)

These short case studies show that real teams move between architecture styles in more than one direction. They are here to illustrate trade offs, not to prove that any pattern is right or wrong.

| Case study | Movement | Main lesson |
|---|---|---|
| [Prime Video: audio and video monitoring](01-prime-video-serverless-to-ecs.md) | Serverless orchestration to a single process on containers | Per step costs and platform limits can change the best design for one specific workload. |
| [Shopify: modular monolith](02-shopify-modular-monolith.md) | Large monolith to enforced modules, not to microservices | Structure can be improved without distributing the system, but enforcement is hard work. |
| [Segment: destination services](03-segment-microservices-to-monolith.md) | Many per destination services to one service | Splitting too far multiplies operational cost, and the right size depends on the workload. |

## Rules these pages follow

* Only migrations we could verify from the company's own engineering writing or from reputable coverage are included.
* Numbers are attributed to whoever reported them. They are not independently verified.
* Where a detail is uncertain, missing, or disputed, the page says so.
* Facts were checked against the cited sources on 2026-11-26. Web pages change, so please report any link that no longer works.

Want to add a case study? Read the case study rules in [CONTRIBUTING.md](../../CONTRIBUTING.md) first.
