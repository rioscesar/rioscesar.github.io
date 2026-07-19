# Project state

## Current

Engineering-lifecycle alignment is in progress on the branch
codex/align-engineering-lifecycle. The implementation adds a deterministic
safety scan, its controlled self-test, and a continuity record without changing
the public site.

## Done

- Rebuilt the legacy Jekyll Now site on feat/rebuild-engineering-blog.
- Added GitHub Pages validation and deployment workflows.
- Audited the rebuild against the canonical engineering lifecycle at D:\AGENTS.md.

## Next

Run the safety-scan controls, validate the changed-file scope and Jekyll
workflow, then open a stacked draft PR against feat/rebuild-engineering-blog.

## Decisions

- The canonical AGENTS.md and AI Workflow Kit are maintained outside this
  repository; this file is the repository-local continuity record they require.
- The safety scan uses high-signal patterns only. It is intentionally small and
  supplements, rather than replaces, GitHub secret scanning and human review.
