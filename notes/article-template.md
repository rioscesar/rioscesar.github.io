# Article template

```yaml
---
title: "A specific, honest title"
description: "One sentence explaining the decision or lesson."
date: 2026-07-19
category: systems
tags: [architecture, tradeoffs]
repository: https://github.com/owner/repository # optional
image: /assets/images/example.png # optional; include meaningful alt text in the article
published: false # safe while drafting; set true or remove to publish
---
```

For a scratch draft, put the file in `_drafts/` and preview with `bundle exec jekyll serve --drafts`. For an unpublished post in `_posts/`, use `published: false` and preview with `bundle exec jekyll serve --unpublished`.

## 1. The real problem

What was difficult, costly, unclear, or fragile?

## 2. Initial assumptions

What did you believe at the beginning?

## 3. Why existing solutions were not quite right

Where did they fail the actual constraints?

## 4. Alternatives considered

Name credible options and why they were accepted or rejected.

## 5. Important engineering decisions

Describe the decisions that shaped the system.

## 6. Tradeoffs

What became better, and what became more expensive or constrained?

## 7. What changed my mind

Show the evidence, feedback, or failure that revised the approach.

## 8. Mistakes and regressions

Be specific about what did not work.

## 9. The final direction

State the current direction without pretending it is permanent.

## 10. Lessons that generalize

What might help someone reason about a different system?

## 11. What comes next

Name the open questions and next test.
