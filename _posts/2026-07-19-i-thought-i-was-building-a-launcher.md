---
title: "I Thought I Was Building a Launcher"
description: "Living Room TV began as a better launcher for a Windows PC. It became a lesson in controller-first interaction, trust boundaries, and the engineering work around the code."
date: 2026-07-19
category: building
tags: [controller-navigation, windows, interaction-design, architecture, engineering-practice]
repository: https://github.com/rioscesar/Living-Room-TV
published: true
---

I thought I was building a launcher.

The first version looked like one: rows of cards, keyboard navigation, a layout
shaped like a Smart TV interface. It was a browser page intended to make a
Windows PC in the living room feel less like a Windows PC.

That description was accurate, but it was not yet the problem.

The actual goal was simpler to describe and harder to build: turn on the TV,
pick up an Xbox controller, and use the computer without reaching for a mouse
or keyboard. Browse the web. Open a streaming service. Launch a game. Turn the
machine off. Do it naturally.

Windows is built around a keyboard and mouse. Steam Big Picture is built around
games. Playnite is built around game libraries. Each one solved an adjacent
problem. None of them gave me the household interface I was trying to make.

The difference mattered more than I expected.

## A convincing first answer

The early prototype was enough to create momentum. There were rows, cards,
keyboard navigation, and the beginning of a living-room layout. It looked
promising.

Then I did what is easy to do when an interface starts to look plausible: I
started paying attention to the parts that were most visible.

I built a large cinematic hero. I experimented with dynamic backgrounds. I
spent time chasing a more premium appearance. I assumed visual polish was the
largest remaining problem, that existing launchers were almost good enough,
and that controller navigation would be straightforward once the screen looked
right.

Those assumptions were not unreasonable. They were just incomplete.

The first controller tests made that obvious. Navigation felt inconsistent.
The page would scroll when it should not. Focus would jump. Moving vertically
could shift the layout. The interface was full of small moments where the
system appeared to have made a choice on the user’s behalf.

None of those failures needed a dramatic crash to be damaging. In a
controller-first interface, people experience one button press at a time.

That is where quality lives.

The hero did not matter much if pressing right sometimes changed more than the
selected item. A polished card did not help if moving down lost the user’s
place. The interface was not judged as a composition. It was judged as a
sequence of decisions.

Navigation had quietly become the product.

## Making the rules visible

The navigation rewrite changed the project more than the visual iterations had.

Rows became independent. Horizontal and vertical state became explicit.
Scrolling followed focus instead of whatever behavior the browser happened to
choose. Returning to a row could restore the last selected item instead of
making the user find it again. Focus memory and row behavior stopped being
side effects of layout and became things the interface could reason about.

This was not an argument against visual design. Visual hierarchy still helps
people understand where they are and what they can do. But it put visual design
in its proper place: it supports interaction. It does not substitute for it.

I had started with the idea that controller support was another input method.
The project pushed me toward a different model: design for controllers first.
Everything else is secondary.

That is a more demanding constraint than it sounds. It changes how rows behave.
It changes how state is preserved, what scrolling means, and the cost of a
small inconsistency.

It also made the work more interesting. The problem was no longer how to make
a launcher look finished. It was how to make a small interaction system
predictable enough that people could stop thinking about the system.

## Letting Steam own the problem it already owns

Controller input exposed another assumption.

I initially expected browser Gamepad APIs to be sufficient. They were not
reliably sufficient across the machines I tested. That made the browser a poor
place to own the most important part of the experience.

Steam already had a better answer: Desktop Layout can translate controller
input into keyboard events. I made Steam the single translation layer and kept
the launcher keyboard-only internally.

This was a tradeoff. The experience now depends on Steam. In return, the
launcher has a much smaller input problem. It does not need to interpret every
controller variation itself. It can operate against a simpler, more stable
contract.

The change was not clever. It was an admission that the browser was not the
best abstraction for this job.

That is often a useful engineering move. The question is not whether an
abstraction can be made to work. The question is whether it should own the
responsibility at all.

## Where the browser stops

The same question appeared again when the interface needed to cross into
Windows.

Steam launch worked through a protocol. Other cases did not line up so neatly.
EA launch and power actions needed native Windows functionality. It would have
been possible to treat the browser as a remote shell and let it ask for
arbitrary commands.

That would have been the wrong boundary.

Instead, the project gained a PowerShell helper with named, allowlisted
capabilities. The browser can request an action. The helper decides whether
that action is one it is permitted to perform.

The difference is small in the interface and large in the model.

Arbitrary command execution turns a UI request into an open-ended authority
problem. Named capabilities make the allowed surface explicit. They add some
infrastructure, but they create a boundary that is easier to inspect, test,
and trust.

This was another place where the project stopped being a launcher in my head.
It was becoming a local-first system with a few carefully chosen boundaries:
the browser renders and navigates, Steam translates controller input, and the
helper owns the small set of Windows actions that should not belong to a web
page.

Plain HTML, CSS, JavaScript, and PowerShell were enough. There was no server,
no account system, and no reason to add a heavier runtime just to make the
architecture look more substantial.

Simple systems are not automatically easy. They are often easier to evolve
because the places where responsibility changes hands are visible.

## The work around the code

At the beginning, the workflow was familiar: prompt, generate code, repeat.

That can produce a convincing prototype quickly. It is less reliable when the
problem is still moving.

As the project changed, the process changed with it. The repository gained a
roadmap, backlog, changelog, decisions, principles, architecture and security
material, release work, regression tests, and CI. Documentation was no longer
something waiting at the end of implementation. It started influencing
implementation while there was still time to make better decisions. A roadmap
gave the next change somewhere to land; decision records made the tradeoffs
behind it easier to revisit.

That phrase can sound performative, so it is worth being precise about what
changed. There was a release process. There were regression tests. There was a
public-readiness audit. There was a security review, contributor documentation,
and a checklist for release. Preparing to make the work public exposed real
engineering problems: history, configuration, documentation, and the gap
between something that works locally and something another person can
understand.

Preparing for open source made the software better before it made the
repository public.

AI was part of this evolution, but it was not the subject of it.

Implementation became cheaper. That did not make the difficult decisions go
away. It made them easier to postpone if I was not careful.

The valuable work became deciding what the system should own, documenting the
decisions, testing the behavior that actually mattered, reviewing changes, and
being disciplined about release. AI could accelerate code production. It could
not decide whether browser input was the right boundary, whether a helper
should expose commands or capabilities, or whether navigation felt trustworthy
after repeated use.

The project changed how I think about side projects for the same reason. A
personal project does not become serious because it has more code. It becomes
serious when its assumptions can be examined, its tradeoffs can be named, and
its next change has somewhere to land besides the latest idea.

I began by trying to make a Windows PC feel less like a PC.

I ended up spending most of my time learning what a controller interface needs
to remember, who should own the translation between input and intent, and how
much of a system has to be made explicit before it feels simple.

This project made me more interested in the work around implementation: the
planning, review, validation, and release discipline that become more important
when code is cheap to produce.
