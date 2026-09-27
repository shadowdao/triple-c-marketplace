---
name: example-skill
description: Summarises the repository's recent git history. Use when the user asks what changed recently or wants a changelog draft.
---

# Recent changes summary

1. Run `git log --oneline -20`.
2. Group the commits by theme (features, fixes, chores).
3. Write a short bulleted summary per group, newest first.
4. Mention any commit that looks like a revert or a hotfix.
