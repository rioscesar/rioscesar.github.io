---
title: "Can We Trust Autonomous Systems?"
description: "Trust Is Becoming Infrastructure"
date: 2026-08-23
category: systems
tags: [autonomous-systems, architecture, governance]
repository: https://github.com/rioscesar/trustclaw
mermaid: true
published: true
---

An agent can draft an email. It can inspect a repository. It can rotate a secret or change infrastructure. None of those actions feel especially mysterious anymore.

The moment an agent is close to doing one of them, though, the question changes. Before the button is pressed, what should an operator be able to say with confidence?

Is the action allowed? Who approved this exact request? Which identity will execute it? Which policy made the decision? And if someone asks six months later, can the system produce evidence rather than a story?

I started TrustClaw with a much broader question: what happens when software stops being a tool and starts making decisions? That framing pulled me toward capability. If agents were going to act in the world, I assumed the interesting engineering problem was making them capable enough—and perhaps surrounding them with serious infrastructure such as distributed consensus or immutable records.

That turned out to be the wrong place to begin.

The project became more useful when I treated an agent action as an operational boundary. The question was no longer whether an agent could perform a useful task. It was what had to be true before a consequential task could execute.

## The button is the boundary

There is a meaningful difference between an assistant suggesting an email and a system sending it. The same difference appears when an agent proposes a Terraform change versus applying it, or identifies a secret versus rotating it.

Those are not just more capable versions of the same interaction. They create a boundary where intent becomes an externally meaningful action. An output can be inspected and ignored. An executed action has an identity, a scope, a time, and a consequence.

My background in observability and reliability made that distinction feel familiar. In a distributed system, we do not rely on the fact that a service probably did the right thing. We care about boundaries, attribution, and evidence. We want to know what happened, where it happened, and how to reason about it after the fact.

Agent runtimes make the same needs more visible. They can decide, then act, in a path that may cross email, files, infrastructure, and business systems. Capability is valuable. It just does not answer the operator’s questions.

## Subtracting until the question showed itself

The first useful move in TrustClaw was not adding more infrastructure. It was removing it.

I cut blockchain, distributed-ledger ideas, OPA, PostgreSQL, OpenTelemetry, and a dashboard from the first milestone. Those choices were not declarations that any of those tools are unhelpful. They were a way to stop using components as a substitute for a precise question.

What remained was smaller: policy, approval, execution, and evidence.

That scope reduction changed the project’s shape. Instead of attempting to build a generalized governance platform, I could ask whether a vertical slice could demonstrate the decision boundary. Could a system accept an action request, make a deterministic policy decision, require an approval that referred to that exact request, simulate execution, and leave behind an evidence chain?

An in-memory implementation was enough to test that idea. It reduced realism, but it also kept the first milestone focused on the semantics I needed to understand. Adding a production Gmail integration or an OAuth flow would have made the system more concrete while making the core question harder to see.

That tradeoff is easy to miss when implementation is cheap. More code can make a project feel like it is moving forward. In this case, removing code and dependencies made the design legible enough to challenge.

## OpenClaw defined an adapter boundary

I initially treated a real OpenClaw integration as the natural first milestone. It was a sensible instinct: start where the agent action originates.

But that made the runtime look like the architecture. Once I tried to express the problem in contracts, the better boundary became clear. OpenClaw could be the first adapter; TrustClaw’s core should describe the request, policy decision, approval, execution, and audit evidence without assuming a particular agent runtime. The first executable slice uses a simulated OpenClaw-like proposal while the real adapter remains deferred.

The runtime-neutral contracts were then exercised against five unrelated scenarios: a GitHub merge, Terraform, Kubernetes, secret rotation, and repository inspection. That did not prove the contracts are universally correct. It did provide a practical pressure test: the same control-plane concepts could describe actions with different consequences and integrations.

The abstraction costs something. Runtime-neutral interfaces require more care than a Gmail-specific or OpenClaw-first path. They leave more questions open at the edges. I would still make that choice again, because the point of the first milestone was not to optimize a single integration. It was to find the stable questions beneath one.

## A gate is more than a policy check

The policy engine is deliberately deterministic TypeScript rather than an AI policy layer. That choice is less flexible, but it is explainable and testable. If a consequential action is allowed or denied, an operator should not need to interpret a probabilistic explanation to understand the governing rule.

Policy alone is not the whole gate. One of the sharper discoveries in the project was that approval without request binding is theater. A person may have approved an intention—“send the customer update”—without approving the exact action that later executes. If the request can change between approval and execution, the approval does not mean what it appears to mean.

TrustClaw therefore treats approval as bound to a request digest. It also gives approvals an expiration and supports multiple approvers. These are small constraints, but they change the question from “did someone approve?” to “did the required people approve this action, within its valid window?”

Time matters here. A valid approval is not a permanent capability. Delayed execution can change context, risk, and intent.

<div class="mermaid">
flowchart LR
    A["Agent runtime<br/>(simulated OpenClaw-like proposal)"] --> B["Runtime-neutral<br/>authorization request"]
    B --> C["TrustClaw gateway"]

    C --> D["Deterministic<br/>policy engine"]
    D --> E{"Approvals<br/>required?"}
    E -- "yes" --> F["Request-bound,<br/>expiring approval"]
    F --> G["Simulated<br/>tool handler"]
    E -- "no" --> G

    C --> H[("Tamper-evident<br/>audit chain")]
    D --> H
    F --> H
    G --> H

    H --> I["Later verification"]

    B -. "raw arguments only" .-> G
</div>

Execution remains simulated in the first vertical slice. That limits the realism of the system, but it avoids presenting an unfinished integration boundary as if it were settled. The simulated path lets the project test the control sequence without claiming production identity, external APIs, or operational readiness.

## Logs did not close the gap

I originally wondered whether observability could carry more of this burden. Logs are useful evidence, and I care deeply about them. But logs mostly explain what happened. They do not, by themselves, establish what was allowed, who authorized it, which request was approved, or whether a later record still corresponds to the earlier decision.

That distinction changed the audit model. The chain is not simply a collection of execution logs. It connects a request to a policy decision, an approval, execution, and an outcome. The implementation uses a tamper-evident hash chain—not an immutable ledger—to explore whether evidence can be linked and later verified.

That is a deliberately modest claim. Tamper evidence is not the same as solving trust. It is one primitive in an evidence model. The more interesting result is that the audit design pushed the project toward provenance and attribution as first-class concerns instead of afterthoughts attached to logs.

The architecture has evolved from a direct path—agent to execution—into a sequence with explicit policy, approval, execution, evidence, and verification. Each added stage creates more friction. It also makes the decision boundary visible.

That friction is not accidental overhead. It is the cost of being able to answer the questions that matter when an action is consequential.

## The constraints became the product

TrustClaw is not trying to build smarter agents. It is an experiment in whether identity, policy, approval, observability, and auditability can become a trust plane for autonomous actions.

That wording is narrower than where I started, and I prefer it. It leaves room for the system to be useful without pretending to answer every question about AI or human trust. There are no production integrations in this milestone. There is no production identity model, multi-tenancy, dashboard, or claim that a small in-memory hash chain is sufficient infrastructure for every environment.

What exists today is a runtime-neutral vertical slice with deterministic policy, request-bound approvals, simulated execution, and tamper-evident audit records. At the Milestone 1 snapshot, the project metadata records 34 passing tests and passing CI; those are signs that the current slice is behaving as specified, not evidence that the broader problem is finished.

The work also changed how I use AI in the engineering process. The useful shift was not from engineering to automation. It was from asking for implementation to asking for architectural pressure. Design reviews surfaced mutation risk, boundary issues, and approval weaknesses. That is where judgment became more valuable: implementation became less expensive, so being precise about the thing being implemented mattered more.

## What I am still trying to learn

The next questions are more concrete than the original one. What evidence do operators actually need? Which read-only scenarios deserve the same controls as mutating ones? How early should human validation shape the workflow? And once those answers are clearer, what description best explains what TrustClaw is?

I would also define evidence semantics sooner next time. The need was present before the audit model was fully articulated. Starting from the records an auditor would need to inspect may be an even better way to test the architecture.

I do not know yet whether distributed-systems primitives are sufficient for autonomous systems. I do think they provide a better starting point than asking abstractly whether humans can trust AI.

Agents can take action. Operators still need evidence.

Before an agent pushes the button, the system should be able to explain why it is allowed to do so—and preserve enough of that explanation for someone else to verify it later.
