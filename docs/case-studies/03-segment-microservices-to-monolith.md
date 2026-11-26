# Case Study: Segment's destination services

[All case studies](README.md) | [Previous: Shopify](02-shopify-modular-monolith.md)

**Movement:** From a separate service and queue for each destination, to one service with a shared worker pool.

## At a glance

| | |
|---|---|
| Company | Segment (now part of Twilio) |
| Year | The post was published on July 10, 2018. |
| Scope | The part of the pipeline that sends customer event data to server side destinations such as analytics and marketing tools. Other parts of Segment's infrastructure were not part of this change. |
| From | More than 140 services, one for each destination, each with its own queue |
| To | One service, with all destination code in a single repository |
| Author | Alexandra Noonan |

## Context

Segment's pipeline forwards events to over one hundred destinations. Early on, one queue held new events and retries for all destinations. When one destination slowed down, its retries flooded the queue and delayed every other destination. This is called head of line blocking.

## What changed

According to the post:

* **The first fix was microservices.** Each destination got its own service and queue, fed by a router. This isolated failures, so a slow destination no longer delayed the others.
* **New problems appeared.** The team first kept destination code in one repository, where one broken test could fail tests for all destinations. They then split each destination into its own repository.
* **Shared libraries became hard to maintain.** A change meant testing and deploying dozens of services, so library versions drifted apart.
* **Load was uneven, so autoscaling was hard.** Some services handled a handful of events a day and others thousands per second.
* **Overhead grew with every destination.** The authors report adding about three destinations a month during rapid growth, reaching over 140 services. Three full time engineers spent most of their time keeping the system running.
* **The consolidation had three parts.** A system called Centrifuge replaced the per destination queues and fed a single service. All destination code moved into one repository, with one version of each of 120 unique dependencies. A tool called Traffic Recorder recorded destination HTTP traffic once and replayed it in tests.

## Reported results

* The full test suite for 140 plus destinations ran in milliseconds after Traffic Recorder was added. Before, some destination tests took up to 5 minutes and the full suite could take up to an hour.
* The number of improvements to shared libraries rose from 32 under microservices to 46 in the year after the change.
* One engineer could deploy the service in minutes.
* A large shared pool of workers absorbed load spikes, so on call engineers no longer got paged for low volume destinations.

## Caveats and uncertainty

* **Self reported.** The numbers come from the company's own post. We did not find independent measurements.
* **The authors list their own downsides.** Fault isolation is harder, because a bug that crashes the service affects all destinations. Caches are spread across more than 3,000 processes, so in memory caching is less effective. Updating a shared dependency can break several destinations.
* **It is a specific workload.** Many similar services with shared code and a repetitive deployment pattern. The authors note that microservices work well in other parts of their infrastructure.
* **The label is loose.** Calling the result "a monolith" is common shorthand. The change covered the destination workers for one part of the pipeline, not necessarily all of Segment's infrastructure.
* **Later history is not covered here.** We have not checked how the system evolved after 2018.

## Takeaways

* Microservices solved the original isolation problem and created a maintenance problem. Both are real.
* Sharing code across many services creates coordination costs that are easy to underestimate.
* The right granularity depends on the workload, and can be changed later.
* Related patterns: [Microservices](../03-microservices.md), [Monolith](../01-monolith.md), and the distributed monolith and nano services entries in the [decision guide](../decision-guide.md).

## Sources

* Alexandra Noonan, "Goodbye Microservices: From 100s of problem children to 1 superstar", Twilio Segment blog, July 10, 2018: [twilio.com/en-us/blog/developers/best-practices/goodbye-microservices](https://twilio.com/en-us/blog/developers/best-practices/goodbye-microservices)
* InfoQ, "Why Segment Returned to a Monolith from Microservices", a summary of the post: [infoq.com/news/2018/07/segment-microservices](https://www.infoq.com/news/2018/07/segment-microservices)
