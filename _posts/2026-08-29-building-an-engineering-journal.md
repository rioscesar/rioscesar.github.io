---
title: "Building an Engineering Journal"
description: "A public site became a private and public editorial workflow for preserving the engineering judgment that projects usually lose."
date: 2026-08-29
category: engineering-practice
tags: [editorial-workflow, ai-assisted-development, documentation, publishing]
repository: https://github.com/rioscesar/rioscesar.github.io
published: true
---

A Git repository tells me what a project became. It is much worse at showing how my thinking changed, what the project taught me, and why each decision made sense at the time.

That gap became hard to ignore while I was trying to write about Living Room TV. The finished launcher showed the result: a controller-first Windows experience, navigation behavior, a browser UI, a helper boundary, launch and system actions. It could not show why navigation became more important than visual polish, which assumptions failed, or how a helper process became necessary. Those were the parts I found most interesting.

I wanted an engineering journal because I wanted to write about that kind of work. My first assumption was straightforward: a completed engineering project should contain a good article. The project history existed. The conversations existed. With AI available to reconstruct and draft, turning that material into prose seemed like the easy part.

It was not.

The first problem was not writing quality. It was that a polished article can destroy evidence just as effectively as it can preserve it. Once I asked for a story too early, the rough edges became liabilities. Wrong turns disappeared. Chronology quietly repaired itself. A decision discovered through experiments started to read as though it had been obvious from the beginning.

That is a particularly tempting failure mode with AI. It can make the missing connections sound plausible. It can also make them sound inevitable. Neither is the same as knowing they happened.

The useful distinction was between asking, “What happened?” and asking, “What is the story?” I had been treating those as one task. They are not.

## Evidence before narrative

The first change was to make reconstruction deliberately unfriendly to good prose. Before an article exists, there is a retrospective whose job is to retain the awkward material: original assumptions, discarded ideas, bugs, surprises, turning points, and decisions that look less tidy in hindsight. It is not there to summarize the project. It gives the later prose something to answer to.

Only after that record exists does a separate stage decide whether there is an article worth writing. That stage can reject the premise. A project can contain several stories, a weak story, or no public story at all. Completion is not a publication criterion.

This changed the role of chronology too. Chronology is useful evidence, especially when trying to recover how a decision evolved. But it is rarely the most useful public structure. The article should be organized around the model that changed: what I assumed, what challenged it, which decisions followed, and what remains uncertain. The project is evidence. The changing judgment is the story.

That distinction changed the workflow around it. If evidence and narrative are separate jobs, they need a handoff. If the handoff matters, it cannot live only in the context window of whichever tool I happen to be using.

## Memory is not an editorial interface

The early version of the workflow leaned too heavily on a continuous conversation. That was convenient right up to the point that it was not. Chats end, context changes, and different tools are better suited to different tasks. More importantly, an assistant's memory is not a source of truth I can inspect, review, or hand to another stage.

The response was not one bigger prompt. It was explicit artifacts and bounded roles.

The retrospective produces evidence. Story discovery works from that evidence and decides on the narrative direction. Drafting works from declared sources rather than trying to rediscover history. A separate editorial pass looks for unsupported claims, weak pacing, and places where the prose has become too smooth. Publication promotes approved material through validation and a human gate.

The names of those files matter less than the boundary between them. A later step should be able to tell what it can rely on, what it is expected to produce, and what it must leave alone. That makes the work more portable across sessions, but it also makes it easier to challenge. If a claim appears in a draft, I should be able to trace it back to evidence rather than trusting that it sounded right when it was generated.

AI is useful inside those boundaries. It can help reconstruct a history, compare alternatives, draft from evidence, or critique a draft. But cheap generation increases the value of editorial judgment. The easier it is to produce plausible prose, the more care is required to prevent prose from hiding uncertainty.

## Build exclusion is not a privacy boundary

The next problem was less literary and more architectural.

At first, article-specific drafts and notes lived alongside the public site and were excluded from the generated Jekyll output. That seemed safe enough: if the site did not render the files, they were not public content.

It was the wrong boundary.

Not rendering a file does not make public Git history an appropriate home for raw evidence, rejected material, incomplete claims, or private working notes. Those artifacts have a different lifecycle from an approved article. The correction was to keep durable editorial policy with the public repository while moving article development into a physically separate private workspace.

That split created a little more ceremony. It also made the source-of-truth transition explicit. Before approval, evidence, drafts, and review notes stay private. After approval, the public site receives the article and approved assets. The boundary is not an implementation detail; it is part of what protects the work before it is ready to represent me publicly.

The same reasoning changed publication. I stopped treating it as the moment to finish writing. If a draft has passed editorial review, publication should promote that approved text, not quietly reshape it during deployment. Formatting fixes are one thing. A substantive discovery is a reason to return to review, not a reason to make an untracked last-minute edit. Validation, link checks, asset checks, and a human approval gate belong at that boundary because publication is consequential.

## The process earned its shape

This can look like a lot of process for a personal site. I am wary of that reading too. The workflow did not begin as a plan to turn writing into a miniature software factory. It accumulated because particular shortcuts kept failing.

Direct drafting lost history. Relying on conversation created hidden state. Keeping working material in a public repository confused build exclusion with privacy. Letting generation and review blur together made it too easy for a draft to approve its own assumptions. Treating publication as copy-and-paste invited unreviewed changes at the point of release.

The resulting process has familiar engineering properties: explicit state, provenance, boundaries, validation, promotion, and review. Writing and production systems do not have identical stakes. But those properties address the same kinds of failure: lost context, unclear ownership, and changes that cannot be explained afterward.

Living Room TV forced the first version of this workflow into existence. It has since been exercised on HLSTR, a product and validation story, and TrustClaw, an infrastructure and research-oriented story where caveats and scope boundaries matter. That is enough to show that the current process can carry more than one kind of narrative. It is not proof that the process is finished, optimal, or general.

There are already things I would change. I would establish the private/public boundary before the first article. I would capture major changes in judgment while a project is still in motion rather than depending entirely on retrospective reconstruction. I would preserve potential visuals during the work itself instead of searching for them when an article is nearly ready. The workflow is meant to evolve; treating it as complete would repeat the same hindsight problem it was designed to resist.

## What I am trying to keep

The public journal is the visible artifact. The more important system is the one behind it: the one that helps me keep the reasoning that would otherwise disappear once a project looks finished.

I started with a place to publish what I had learned. I ended up building a way to preserve how I learned it.

That is what I want the journal to hold. Not a cleaner version of the past, and not a tour of every project file. A record of the assumptions that changed, the tradeoffs that mattered, and the judgment that made the final code possible.
