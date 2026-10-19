---
title: "From Markdown Files to an Engineering System"
description: "How a reliable AI engineering workflow moved out of repeated prompts and into an installed capability."
date: 2026-10-19
category: systems
tags: [ai, engineering, architecture, verification]
published: true
---

I used to think better AI-assisted engineering mostly came from better instructions.

When a coding agent missed context, I added context. When it made an assumption, I added a constraint. When it skipped verification, I added acceptance criteria and a test section. Loose prompts became structured Engineering Briefs, and those briefs became quite good.

They described the objective, the boundaries, the expected behavior, the evidence required at the end, and the decisions that still belonged to me. The model had enough room to work, but not enough room to quietly redefine the job.

That was a meaningful improvement. It also led me toward the wrong abstraction.

The more often I repeated the same engineering rules, the more obvious it became that they did not belong in each task. I pulled the common behavior into a canonical `AGENTS.md` and, eventually, an AI-Workflow-Kit. The task brief could describe the current mission while the shared files described how engineering work should proceed.

The workflow had stages for understanding, planning, implementation, verification, human review, delivery, and learning. It emphasized scope discipline, deterministic safety checks, implementation-only pull requests, no self-merge, and escalation when a real product decision appeared. Repository state and Git history helped work survive across sessions.

It felt like I had moved from prompting to a system.

I had not. I had built a system with a manual ignition switch.

## The magic phrase

For the workflow to run, I still needed to tell the agent something equivalent to:

> Use this `AGENTS.md` file to start your work.

Sometimes I included that instruction in the brief. Sometimes I added it separately. Sometimes I forgot it.

Forgetting it should have produced an obvious failure. Instead, the model often did reasonable work. The briefs had become strong enough that an agent could inspect a repository, make a bounded change, run tests, and summarize the result without loading the canonical workflow at all.

That looked like success, but it created an uncomfortable ambiguity. Had the system worked, or had the task prompt merely been good enough to compensate for the system not running?

Good output did not prove the intended process happened.

The workflow was deterministic after entry. Entry itself was not deterministic.

Once I saw that distinction, adding another reminder to the brief felt absurd. Human memory was already the unreliable dependency. Asking the human to remember a more emphatic reminder did not remove it from the architecture.

The problem was no longer how to write a better `AGENTS.md`. The problem was that a readable file is not the same thing as a discoverable capability.

## Three kinds of context

The work had gradually mixed together three concerns that looked similar because they were all written in Markdown.

The first was the engineering constitution: the durable rules for how work should be understood, bounded, verified, reviewed, and delivered.

The second was repository memory: code, tests, decisions, project state, and Git history. This is where the project remembers what is true now and how it got there.

The third was the task mission: what needs to change today, why it matters, what is out of scope, and how we will know it worked.

Engineering Briefs were still useful. In fact, they were more useful after this separation. A brief should carry the mission, not reprint the constitution. Repository memory should not be reconstructed from the conversation. And the engineering constitution should not depend on whether I remembered to paste or reference it.

This also changed how I thought about lifecycle stages. A request to review finished work should not replay planning and implementation to satisfy a diagram. A verification request should verify. Existing intent is state, not an inconvenience to reset.

The better rule became: continue from intent.

## Installing behavior

That mental model led to a-sdlc, an installed engineering capability built around a small set of skills: start, plan, review, verify, and ship. Shared guidance moved with the capability instead of being copied into every repository.

Packaging the workflow forced several useful decisions.

Ordinary engineering would remain lightweight and skills-first. More demanding evidence would stay available when justified, without becoming compulsory ceremony for every change. The amount of process should follow the uncertainty and risk of the work.

The capability also needed a distribution mechanism. I put a-sdlc into a private, multi-plugin marketplace called `ai-systems`. The name mattered less than the boundary: a-sdlc was one reusable capability, not the identity of the whole distribution system. Register the marketplace once, then install capabilities across repositories without copying the workflow into each one.

The decisive test was outside the source repository.

I used an unrelated repository with no local `AGENTS.md`, no AI-Workflow-Kit, no copy of a-sdlc, and no magic bootstrap phrase. The installed package exposed five skills. Its shared guidance resolved from the installed plugin, and the optional evidence runtime was available.

That proved installation and discovery. It did not prove that every ordinary prompt would automatically route itself to the correct skill. Distribution and routing are separate engineering problems, and conflating them would recreate the same kind of false confidence I was trying to remove.

The narrower result was still important: the repository-local `AGENTS.md` bootstrap dependency was gone.

## What actually changed

I started this work trying to make an AI follow a better process. Over time, the harder questions became less about code generation and more about uncertainty, authority, continuity, evidence, and escalation.

The agent should make routine engineering decisions without asking me to select every implementation detail. It should stop when a choice changes product behavior, architecture, cost, or risk. Automated verification should answer whether the implementation satisfies known assertions. Human review should ask whether those are still the right assertions and whether the solution remains worth its complexity.

Git became part of the memory architecture because committed state survived agent and harness transitions better than conversation or a dirty working tree. Plugin discovery and automatic routing became separate measurements because one can succeed while the other fails.

None of this makes structured prompting irrelevant. The Engineering Brief remains the right place to state the mission. What changed is what I expect a prompt to carry.

I no longer want each task to teach the agent how to behave as an engineer. I want the task to say what needs to happen, while the system supplies the durable operating model and the repository supplies memory.

There are still open questions. Automatic routing needs to be measured independently from discovery; explicit skill invocation remains intentional. Stronger assurance needs to stay available without taxing ordinary work. State documentation can become stale, while uncommitted state remains fragile. Installed capabilities inherit the behavior and constraints of their host.

A mature engineering workflow should require less repeated instruction over time, not less intent. A task still needs to state its mission, and an explicit skill invocation is sometimes the right decision. The original solution was a workflow the AI could read after I pointed at it. The better solution was an installed workflow it could discover without repository-local bootstrap instructions.

The end state is not a better prompt.

It is fewer repeated instructions.
