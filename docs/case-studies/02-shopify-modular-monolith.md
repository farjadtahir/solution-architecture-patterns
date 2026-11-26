# Case Study: Shopify's modular monolith

[All case studies](README.md) | [Previous: Prime Video](01-prime-video-serverless-to-ecs.md) | [Next: Segment](03-segment-microservices-to-monolith.md)

**Movement:** A large Ruby on Rails monolith to a monolith with enforced internal modules. Microservices were considered and not chosen as the main strategy.

## At a glance

| | |
|---|---|
| Company | Shopify |
| Period | The team started in early 2017. Two engineering posts followed, in 2019 and 2020. |
| Scope | Shopify's core Rails application |
| From | A monolith with few boundaries between business areas |
| To | A modular monolith, which Shopify calls "componentization" |
| Authors | Kirsten Westeinde (2019 post) and Philip Müller (2020 post) |

## Context

The 2019 post describes the core application as one of the largest Ruby on Rails codebases in existence, worked on for over a decade by more than a thousand developers. Around 2016, the team felt the downsides of the monolith were outweighing the benefits. The problems they described:

* **Fragility:** A change in one area could have surprising effects elsewhere, for example tax code affecting shipping rates.
* **Missing boundaries:** Code in one area could call code in another freely.
* **Slow tests:** Tests were hard to write and slow in continuous integration.
* **Hard onboarding:** A developer needed to understand unrelated areas before shipping a first feature.

## What changed

* The authors say they considered microservices and decided against making them the main answer. They expected extra pipelines and infrastructure, limited access to data, network latency and reliability costs on every call, and coordinated changes for large refactors. They also wrote that no one size fits all.
* They chose a modular monolith: one deployable application, with strictly enforced boundaries between domains.
* Components were organized around business concepts, such as orders, shipping, and billing, rather than technical roles. The goal was a public interface and exclusive ownership of data for each component.
* About 6,000 classes were mapped to components and moved in one large change using automated scripts. The authors acknowledge that this cost some Git history.
* In 2019, a custom tool called Wedge used runtime call tracing in continuous integration to flag calls that bypassed public interfaces.
* By 2020, Wedge had been replaced by Packwerk, which analyzes code statically and runs in pull requests to block changes that break boundaries. Contracts at component boundaries moved to Sorbet.

## Reported results

* The 2019 post says the isolation work made it possible to replace a legacy tax engine with a new tax calculation system, which the authors say would have been nearly impossible before.
* The 2020 post reports that Packwerk runs a full analysis of the largest codebase in a few minutes, which the authors compare favorably with Wedge, which took over an hour.
* The 2020 post reports 37 components, Packwerk in use on about a third of them, and an Architecture Guild with about 400 members.

## Caveats and uncertainty

* **Isolation was unfinished.** The 2019 post describes complete isolation as ongoing work. The 2020 post says almost no component yet had a complete, strong boundary. Named blockers included a partly circular GraphQL API and heavy use of the ORM in some query paths.
* **No outcome metrics.** Neither post reports measured results for test speed, defect rates, or developer productivity.
* **Self reported.** Both posts are written by Shopify engineers about their own work.
* **It is one company's context.** A very large Rails codebase with many developers is not the same situation as a small product team.
* **Details changed over time.** The 2020 post says the original ideas still stand, while many details changed. Tools described in 2019 were replaced.
* **We have not checked later developments.** This page covers the two posts above only.

## Takeaways

* Better structure does not require distribution. Shopify chose to improve boundaries inside one deployable.
* Enforcement matters. Both posts describe tooling and ownership as central, not just folder layouts.
* Boundary work takes years in a large codebase, and can stay partly unfinished.
* Related patterns: [Modular Monolith](../02-modular-monolith.md), [Monolith](../01-monolith.md), [Microservices](../03-microservices.md).

## Sources

* Kirsten Westeinde, "Deconstructing the Monolith: Designing Software that Maximizes Developer Productivity", Shopify Engineering, February 21, 2019: [shopify.engineering/deconstructing-monolith-designing-software-maximizes-developer-productivity](https://shopify.engineering/deconstructing-monolith-designing-software-maximizes-developer-productivity)
* Philip Müller, "Under Deconstruction: The State of Shopify's Monolith", Shopify Engineering, September 16, 2020: [shopify.engineering/shopify-monolith](https://shopify.engineering/shopify-monolith)
* InfoQ, "How Shopify Migrated to a Modular Monolith", a summary of the 2019 Shopify Unite talk: [infoq.com/news/2019/07/shopify-modular-monolith](https://www.infoq.com/news/2019/07/shopify-modular-monolith)
