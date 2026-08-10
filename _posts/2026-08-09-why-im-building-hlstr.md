---
title: "Why I'm Building HLSTR"
description: "HLSTR began as a career-assessment startup idea. Its first milestone showed me that validation and trust—not more software—were the next constraints."
date: 2026-08-09
category: building
tags: [product-validation, privacy, ai-assisted-development, engineering-practice]
published: true
---

I came back to HLSTR with an old idea and a dangerous amount of confidence.

The idea was simple to describe: a place where professionals could publish resumes and make career paths more legible to each other. What does a Google Staff Engineer's experience actually look like? How did someone move from Microsoft to Netflix? What distinguishes a Senior engineer's evidence from someone ready for Staff?

For years, that kind of product carried an obvious technical price tag. Resume ingestion, structured profiles, comparisons, and eventually a network all implied a lot of software before anyone could learn whether the idea mattered. Returning to it in 2026, that constraint felt weaker. A modern web stack was familiar. AI-assisted development made the initial implementation feel cheaper. It was tempting to read that as permission to finally build the whole thing.

That was the first assumption HLSTR had to survive: if software had become cheap enough, perhaps the product was now obvious.

It wasn't.

The question I needed to answer was not whether I could build a resume platform. It was whether engineers who were uncertain about their next level would value a structured assessment of their engineering evidence. That is a much narrower question, and it immediately made most of the imagined product irrelevant.

So Milestone 0 became deliberately small: could a qualified engineer understand the offer and request an assessment?

That question removed accounts, public profiles, social features, payments, recruiter ideas, and a database. It also removed the parts that would have made HLSTR look most like a contemporary AI product: resume upload, parsing, and AI assessment.

At first that can sound like postponing the real work. For this stage, it was the real work.

## The first architecture decision was what not to store

The initial product was a landing page, a synthetic example of an evidence map, and a minimal intake path. The implementation used React, TypeScript, Vite, Netlify, and Netlify Forms—not because that stack was particularly novel, but because it kept the experiment small and reversible.

The conspicuous absence was more important than the stack. No resume upload meant no PDF or DOCX processing, no object storage, and a much smaller privacy surface. No database meant no persistence system to design and operate before demand existed. No AI assessment meant I did not automate a methodology that I had not yet proved was useful.

Netlify Forms was a useful constraint here. It allowed someone to request an assessment without creating a custom backend or authentication model. That creates manual work for me, and it creates a vendor dependency. Both are real tradeoffs. But manual was not a temporary embarrassment to hide behind a more impressive architecture. It was the shortest path to seeing whether the assessment itself had value.

The more precise version of “validate before you build” is uncomfortable for engineers: some of the features that are easiest and most satisfying to build can be the least useful experiments. A parser would have been an achievement. It would not have told me whether the assessment was worth receiving.

## A small validation surface still has to deserve trust

Removing product scope did not remove engineering responsibility. Once a stranger could send information through the site, the project stopped being only a local experiment.

HLSTR needed a real domain, a production deployment, HTTPS, a working <a href="mailto:privacy&#64;hlstr.app">privacy&#64;hlstr.app</a> inbox, retention and deletion behavior, and a way to verify that the intake flow behaved as intended. None of that made an assessment smarter. It made the experiment responsible enough to put in front of someone else.

This was the second correction to my mental model. I had treated operational work as something that could wait until there was more product to operate. In practice, operations became part of the smallest credible product.

The work was not glamorous. Outbound email worked while inbound mail did not, and the domain resolved before a certificate existed. Those failures involved related but independent systems. The correct response to the TLS issue was to verify the provisioning state and wait, rather than mutate configuration until something happened to turn green.

Those are ordinary production details. Their significance was not the configuration itself. They exposed the difference between a page that exists and a service that can be trusted with a real person's request.

The same distinction shaped form verification. It was not enough that the HTML contained a form. I needed to know that the platform detected it, that the expected schema arrived, that the honeypot behaved correctly, that a synthetic production submission succeeded, and that the synthetic record could be deleted. A privacy inbox is not a trust signal if no one has demonstrated that a request can be handled.

Privacy changed the architecture before resumes ever entered the system.

## Production-ready is not market-ready

By the end of Milestone 0, the production facts were encouraging. The domain resolved, TLS and redirects worked, the privacy inbox worked in both directions, Netlify Forms detected the intake, and a synthetic submission and deletion workflow had been verified. The desktop and mobile surface were clean enough to put in front of people.

But none of those facts answer the biggest remaining question: is the assessment valuable?

They do not establish product-market fit. They do not show that the assessment produces useful insight, that an engineer would pay for it, that the methodology is sound, or that it should be automated. A deployed application can still represent zero meaningful product validation.

That distinction is why I had to stop engineering.

There are many plausible systems I could build next: a parser, AI analysis, accounts, scoring, evidence extraction, a comparison engine, or the beginnings of a network. Each would add capability. None would reduce the uncertainty that matters most right now.

The assessment is the product. The software is currently just its delivery mechanism.

That realization changed what “next” means. The next artifact is an assessment methodology: what counts as engineering evidence, how to distinguish missing evidence from weakly communicated evidence, where confidence belongs, and what a useful result should actually tell someone. The next milestone is to deliver manual assessments to a small cohort, listen for what surprises people, and find out whether anyone values the result enough to pay for it.

There is a version of startup advice that says, “talk to users before you build.” That advice is correct and easy to repeat. What I found harder was admitting that technically excellent work could become a way to avoid the only conversation that could answer whether HLSTR should exist.

AI makes software cheaper to produce. For someone who likes building systems, that is not automatically liberating. It makes overbuilding easier to justify. The question that began HLSTR was, “What can I finally build?” The question I am left with is better: “What uncertainty should I remove next?”

For now, the software is ready enough.

The startup is not validated.

And that is why the most useful thing I can do next is stop writing code.
