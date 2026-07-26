# Project state

## Current

The public site foundation and dark theme are merged. A draft implementation PR
now establishes a boundary between the public repository and private editorial
article development.

## Done

- Rebuilt the legacy Jekyll Now site on feat/rebuild-engineering-blog.
- Added GitHub Pages validation and deployment workflows.
- Audited the rebuild against the canonical engineering lifecycle at D:\AGENTS.md.
- Added and verified the lifecycle safety scan and its positive/negative controls.
- Merged the rebuilt site, lifecycle alignment, and dark editorial theme through
  PR #7.
- Kept durable public editorial standards in `notes/` while moving article
  development artifacts to the private editorial workspace.

## Next

Review the editorial-workspace boundary draft PR. Keep future evidence, drafts,
and review material private until a human approves a manual promotion into
`_posts/`. Do not merge automatically.

## Decisions

- The canonical AGENTS.md and AI Workflow Kit are maintained outside this
  repository; this file is the repository-local continuity record they require.
- The safety scan uses high-signal patterns only. It is intentionally small and
  supplements, rather than replaces, GitHub secret scanning and human review.
- The GitHub integration can push branches but cannot create pull requests.
  GitHub CLI works after gh auth login --hostname github.com --git-protocol https
  --web; use it for future PR creation and verify with gh auth status.
- A dark default with a system light-mode fallback delivers the requested
  developer-friendly appearance without JavaScript or a persistent theme setting.
- Safety-scan control tests must explicitly exit successfully after asserting an
  expected failing child process; otherwise that child exit code can fail CI.
- Article development uses a one-way manual promotion flow: private workspace to
  approved public post, never automatic synchronization or publishing.
