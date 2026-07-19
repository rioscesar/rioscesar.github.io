# Project state

## Current

The engineering lifecycle is represented by draft PRs and is ready for human
review. The rebuild is PR #3; its stacked lifecycle alignment is PR #4.

## Done

- Rebuilt the legacy Jekyll Now site on feat/rebuild-engineering-blog.
- Added GitHub Pages validation and deployment workflows.
- Audited the rebuild against the canonical engineering lifecycle at D:\AGENTS.md.
- Added and verified the lifecycle safety scan and its positive/negative controls.
- Opened rebuild draft PR #3 and stacked lifecycle draft PR #4.

## Next

Review and approve the rebuild draft PR first, then review the stacked lifecycle
draft PR. Do not merge automatically.

## Decisions

- The canonical AGENTS.md and AI Workflow Kit are maintained outside this
  repository; this file is the repository-local continuity record they require.
- The safety scan uses high-signal patterns only. It is intentionally small and
  supplements, rather than replaces, GitHub secret scanning and human review.
- The GitHub integration can push branches but cannot create pull requests.
  GitHub CLI works after gh auth login --hostname github.com --git-protocol https
  --web; use it for future PR creation and verify with gh auth status.
