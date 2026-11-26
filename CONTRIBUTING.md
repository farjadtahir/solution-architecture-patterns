# Contributing

Thank you for helping improve this guide. Corrections, clearer wording, better diagrams, and new patterns are all welcome.

By taking part, you agree to follow the [Code of Conduct](CODE_OF_CONDUCT.md).

## Ways to contribute

| You want to | Do this |
|---|---|
| Fix a factual error or broken link | Open a "Bug or correction" issue, or send a pull request. |
| Improve wording or a diagram | Send a pull request. |
| Add a missing pattern | Open a "New pattern request" issue first, then use [the pattern template](templates/pattern-template.md). |
| Add a case study | Open an issue to discuss it first. See the rules below. |

## Editorial principles

1. **Stay neutral.** Every pattern has real costs. Do not declare a winner, and do not use words like "obsolete" or "modern" as arguments.
2. **Be honest about trade offs.** Each pattern page needs real cons, not disguised strengths.
3. **Write in plain language.** Define jargon the first time, or link to [the glossary](docs/glossary.md).
4. **Keep sections short.** Prefer tables and short lists to long paragraphs.
5. **Write it yourself.** Do not copy text from books, articles, or other repositories. Short quotes with attribution are acceptable, and linking to a source is always better than copying it.
6. **Do not invent facts.** Numbers and claims about real companies or products need a source. If you are not sure, mark the statement as uncertain or leave it out.

## Rules for case studies

* Only include migrations that you can verify from a primary source, such as the company's own engineering blog or a conference talk.
* State what the source says, and attribute numbers to the people who reported them.
* Separate what was reported from what is your interpretation.
* List caveats, including anything uncertain, missing, or disputed.
* Link every source, and check that the link works.

## Structure of a pattern page

Every page in `docs/` uses the same sections in the same order. Start from [templates/pattern-template.md](templates/pattern-template.md).

1. Overview
2. Diagram
3. How it works
4. Pros
5. Cons
6. When to use
7. When to avoid
8. Common technologies
9. Real world considerations
10. Related patterns

## Diagrams

* Use Mermaid code blocks inside the Markdown so the diagram renders on GitHub.
* Stick to widely supported diagram types: `flowchart`, `graph`, and `sequenceDiagram`. Avoid anything marked beta or experimental.
* Quote node labels that contain punctuation, for example `A["Orders (public API)"]`.
* Some key diagrams also exist as exported files in [assets/diagrams](assets/diagrams/) so they display everywhere. If you change one of those diagrams, edit its `.mmd` source file, update the matching block in the Markdown, and run `scripts/render-diagrams.sh`.

## Check your changes locally

Lint the Markdown:

```bash
npx markdownlint-cli2 "**/*.md"
```

Check links, if you have [lychee](https://github.com/lycheeverse/lychee) installed:

```bash
lychee --no-progress "./**/*.md"
```

The same checks run automatically on every pull request.

## Pull request process

1. Fork the repository and create a branch with a short, descriptive name.
2. Make your change and run the checks above.
3. Open a pull request and fill in the template.
4. A maintainer will review it. Expect questions about sources and neutrality, because those matter most here.

## License

By contributing, you agree that your contributions are licensed under the [MIT License](LICENSE).
