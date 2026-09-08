---
title: "A Good Spec Can Preserve the Wrong Assumption"
description: "Backburner showed me why real use matters more than a well-written spec."
date: 2026-09-07
category: engineering
tags: [engineering-judgment, product-development, testing, requirements]
repository: https://github.com/rioscesar/Backburner
published: true
---

The easy part of building Backburner was making a bookmark reappear.

Chrome already knows how to store bookmarks. Plenty of products know how to organize them, search them, decorate them with tags, or turn them into a read-later queue. The more interesting problem was the one I had been avoiding: a saved bookmark is often an unresolved intention. It might still be useful. It might be obsolete. It might be neither, but it should stop occupying a vague corner of my attention.

That became the product thesis: make forgotten bookmarks reach a decision.

I had a process I trusted to carry that idea into software. Backburner went through a graded spec and plan, bounded implementation work, deterministic checks, and explicit human decision points. The system was deliberately modest: Chrome bookmarks remained the source of truth; the extension kept only its own lifecycle state; there was no account, backend, telemetry, AI service, or browser-history permission.

That discipline mattered. It narrowed the product and made its behavior inspectable. But it also revealed something uncomfortable: a careful process can preserve a wrong assumption extremely well.

## The first bookmark that broke the spec

The original design avoided changing native bookmarks. If an item no longer mattered, Backburner could stop suggesting it. That sounded cautious and reversible.

Then the first real bookmark surfaced: an old HTML/CSS/PHP tutorial from 2013. My reaction was not “please hide this from the queue.” It was: this is not useful; I want it gone.

The difference is easy to miss in a product document. Suppression is a decision about an application's future behavior. Removal is a decision about the bookmark itself. The spec had protected the safer abstraction, but it had not matched the decision the user was actually trying to make.

So native deletion became a primary action, with a deliberately imperfect recovery path. Backburner keeps enough local information to recreate a removed bookmark, and asks for confirmation before destructive or recovery actions. It cannot promise a perfect rollback: restored bookmarks may not return to the exact original place or identity. That constraint is part of the product's honesty, not an implementation detail to hide.

![Synthetic Backburner recovery screen showing locally saved recovery copies, their restore state, and options to restore or forget each copy.](/assets/images/backburner-recovery-0.1.10.png)

This was not a test failure. The code had correctly implemented the requirement. The requirement had lost contact with the product.

I used to think of dogfooding as the last layer of QA: find rough edges after the behavior is settled. This was requirements discovery. A real encounter with the system supplied stronger evidence than a plausible sentence in a spec.

## A reminder that required remembering

The deletion decision was concrete. The more important correction was structural.

Backburner had a **Later** action, but the early implementation interpreted it as “show this again in the next session I start.” Notifications were out of scope. On paper, that was a reasonable way to keep the first release small.

In practice, it contradicted why the product existed. A bookmark reminder that depends on me remembering to open the reminder tool has outsourced its central job back to me.

The early research had always contained a different promise: a small review now, then another opportunity tomorrow or next week. Somewhere between that intention and a tidy implementation plan, the promise had narrowed into a pull-only queue. Nothing in implementation corrected it.

That distinction changed how I think about specifications. Feature requirements are not enough when they can satisfy the words while violating the point. Product invariants need to be written down in a form that survives research, specification, planning, and code. In this case, one invariant was simple: when a person chooses “Later,” the system should remember on their behalf.

The release scope changed. Backburner added optional reminders, bounded by a small attention budget: no more than one attempt per seven elapsed days, during local daytime hours, and a fourteen-day wait after an unanswered offer. “Later” also became a real elapsed-time promise. The policy is not an empirically proven optimum. It is an explicit starting hypothesis, with enough restraint to avoid turning bookmark review into another source of ambient pressure.

## Green checks, incomplete evidence

By version 0.1.3, the project had 75 passing automated checks and two passing CI runs. The alarms, notification API creation, restart reconstruction, and permission controls had evidence behind them. Those tests were useful. They ruled out a lot of deterministic failure.

They did not establish that a notification appeared in the operating system, that I could interact with it, and that the interaction led to the intended bookmark. That path crossed a boundary the tests had not crossed.

This is the kind of distinction that gets flattened when a build is called “green.” Green is not a universal confidence score. It means a particular set of claims has passed a particular set of checks. The important question is whether those checks meet the user where the product meets the user.

At that point, I kept the release hold open. Later, I used a separately marked test build with a thirty-second notification opportunity. It was not a production timing change; the normal product policy remained weekly. The feedback was direct: “30 second test was a success - love it. Ship the non-test if it's ready.” That closed the specific acceptance hold.

It did not create a detailed native-click trace, prove a week of natural use, or demonstrate retention. That is not false modesty. It is how I want evidence to work: close the gate it supports, then keep the remaining unknowns visible.

![Current synthetic Backburner review screen showing a bookmark with Keep as reference, Later, and Remove bookmark decisions.](/assets/images/backburner-review-0.1.10.png)

## Reality can reopen a decision in more than one way

Not every late discovery was a product correction. One recovery test uncovered an actual implementation defect.

During an interrupted restore test, Chrome reused the ID of the bookmark that had been removed. If native creation succeeded and the final journal save failed, treating ID equality as proof of identity could leave the recovery UI stuck. The correction was technical but instructive: interpret the durable operation phase before interpreting an ID match.

That bug belongs in the story because it keeps the larger argument honest. A specification can preserve the wrong assumption without explaining every later problem. Sometimes code has a real edge case, and the work is to reproduce it, fix it, and verify the boundary.

The final product correction was smaller, and that made it more revealing. I liked the sentence in the review flow: “Finish whenever it feels enough.” But completing an early session quietly stored that number as a cap for future sessions. The invitation sounded self-paced while the behavior was learning a quota.

The old release question asked for a comfortable default. The better question was why a low-pressure review needed a number at all. The answer was that it did not. Version 0.1.10 removed both the cap and the learning behavior while preserving existing unfinished queues. A user can review more, finish early, or stop when the session has done enough. The behavior finally agrees with the sentence.

That change came from a tidy requirement that had outlived its rationale. Friendly copy deserves the same scrutiny as storage behavior when it makes a promise about what the system will do later.

## A useful stopping point

Backburner 0.1.10 was merged with explicit authorization and submitted to the Chrome Web Store for an unlisted, family-first release. At the evidence cutoff, the submission was pending review.

That is a better ending than a victory lap. Submission is not approval. Approval is not a normal installation. Installation is not repeat use, and repeat use is not proof that the product helped anyone reach better decisions about their bookmarks.

The project moved the experiment forward. It did not answer the experiment.

The process was still useful. It narrowed the product, made its behavior inspectable, and left evidence I could use when an earlier decision stopped making sense. But it could not tell me that suppressing a bookmark was different from removing it, that a reminder had to remember on my behalf, or that a low-pressure review did not need a hidden quota.

A good spec can preserve the wrong assumption. The work is noticing when a real encounter with the product gives you a better one.
