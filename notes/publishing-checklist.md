# Publishing checklist

- [ ] The article has a real problem and narrative tension.
- [ ] Initial assumptions are stated.
- [ ] Alternatives are explained.
- [ ] Tradeoffs are explicit.
- [ ] Technical claims are accurate and appropriately scoped.
- [ ] Evidence and artifacts support the important claims.
- [ ] Repository links are correct and useful.
- [ ] Every meaningful image has accurate alt text.
- [ ] Internal and external links are not broken.
- [ ] The article has had a confidentiality review.
- [ ] Microsoft attribution and disclosure are appropriate; no confidential information is included.
- [ ] AI supports the story instead of becoming the story.
- [ ] The local build passes.
- [ ] CI passes.
- [ ] A human has signed off on the final draft.

## Promote an approved article

1. Keep evidence, working outlines, drafts, review notes, and unapproved assets
   in the private editorial workspace.
2. After human approval, manually create the public article in `_posts/` using
   the approved publication copy.
3. Transfer only approved, public-safe assets into the site's tracked asset
   directories; do not link or synchronize private workspace folders.
4. Run the public repository's validation and safety checks, then open a draft
   implementation PR for human review.
5. Publishing remains a manual, human-approved step. No script or configuration
   automatically publishes editorial workspace material.

## Corrections after publication

Correct meaningful errors promptly. Add a brief, dated correction note when a change affects the article's conclusion, evidence, or recommendation; use a quiet edit for spelling and clarity fixes.
