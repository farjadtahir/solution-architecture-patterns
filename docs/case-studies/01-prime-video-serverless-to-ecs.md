# Case Study: Prime Video audio and video monitoring

[All case studies](README.md) | [Next: Shopify](02-shopify-modular-monolith.md)

**Movement:** A distributed, serverless workflow to a single application process running on containers.

## At a glance

| | |
|---|---|
| Company | Prime Video (Amazon) |
| Year | 2023 |
| Scope | One internal service: the audio and video quality inspection tool built by the Video Quality Analysis team. It is **not** the whole Prime Video platform. |
| From | A workflow built from AWS Step Functions and Lambda functions, with intermediate data stored in Amazon S3 |
| To | One application process per instance, running on Amazon ECS on EC2 |
| Original post | Written by Marcin Kolny and dated March 22, 2023, according to The New Stack |

## Context

The team had a tool that inspects streams for quality problems, such as glitches in video or audio, and triggers repair actions. Coverage of the story, including comments from Adrian Cockcroft, describes the first version as a quick prototype built from serverless parts, with components orchestrated by Step Functions. The team later wanted to monitor a much larger number of streams, and ran into cost and scaling limits at that scale.

## What changed

According to the InfoQ summary of the original post:

* The original design split streams into frames and audio buffers, and passed work between Lambda functions. Step Functions coordinated the steps, and S3 held the intermediate data.
* The team identified two problems. Costs were high, driven by many state transitions in Step Functions and heavy use of S3 to pass data between steps. Scaling hit an account wide limit on state transitions.
* They consolidated the processing logic into one application process, so data stays in memory instead of travelling through S3. They wrote their own orchestration to coordinate components inside each instance.
* To avoid the limits of a single machine, they ran different groups of detectors in separate ECS tasks.

## Reported results

* The team reported that infrastructure cost fell by more than 90 percent. The figure comes from the team's own account.
* They also said the change removed the scaling limit they had hit, and made it possible to use EC2 savings plans for further cost reduction.

## Caveats and uncertainty

* **The 90 percent figure is self reported.** The coverage we checked does not say what baseline or time period was used, so treat it as the team's claim.
* **The scope is narrow.** It is one service with a specific workload: high volume stream processing where large amounts of data move between steps. It does not show that serverless or microservices are wrong in general.
* **The labels are disputed.** The story was widely described as "microservices to monolith". Adrian Cockcroft, a well known cloud architect, said the team followed good practice and framed the change as adding containers where needed. In his view it was part of a serverless first approach, not a retreat from serverless. We have only the visible part of that article, so we cannot summarize his full argument.
* **The original post is not reachable.** When we checked on 2026-11-26, the original post's address redirected to an unrelated Amazon page. The facts above come from secondary coverage that quotes and summarizes it, so details could differ from the original wording.
* **Trade offs of the new design are not covered.** The coverage we found does not describe downsides of the single process design beyond the savings.

## Takeaways

* Billing by step, and moving data through a storage service between steps, can dominate costs when volume is high and steps are numerous.
* Platform limits that never matter at small scale can become the main constraint at large scale.
* Architecture labels hide detail. The final design still used managed cloud services and multiple ECS tasks, so it was not a simple "back to one server" story.
* Related patterns: [Serverless](../04-serverless.md), [Microservices](../03-microservices.md), [Monolith](../01-monolith.md).

## Sources

* Rafał Gancarz, news article summarizing the Prime Video post, InfoQ, May 2023: [infoq.com/news/2023/05/prime-ec2-ecs-saves-costs](https://www.infoq.com/news/2023/05/prime-ec2-ecs-saves-costs)
* The New Stack, article on the Prime Video change (gives the original post date and author): [thenewstack.io/return-of-the-monolith-amazon-dumps-microservices-for-video-monitoring](https://thenewstack.io/return-of-the-monolith-amazon-dumps-microservices-for-video-monitoring/)
* The Stack, coverage of Adrian Cockcroft's reaction (partly paywalled): [thestack.technology/prime-video-monolith-architecture-debate-bad-takes-adrian-cockcroft](https://thestack.technology/prime-video-monolith-architecture-debate-bad-takes-adrian-cockcroft)
* Original post, "Scaling up the Prime Video audio/video monitoring service and reducing costs by 90%", Prime Video Tech blog. Not linked because it no longer resolves to the article.
