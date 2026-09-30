---
id: TASK-12
title: Publish the glossary and research design to the docs site
status: To Do
assignee: []
created_date: '2026-09-30 21:44'
updated_date: '2026-09-30 21:45'
labels:
  - docs
milestone: m-0
dependencies: []
documentation:
  - .knowledge/GLOSSARY.md
  - .knowledge/02-research-design/final-research-design.md
  - .knowledge/02-research-design/hypotheses.md
priority: low
ordinal: 12000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The docs site exists now, and the .knowledge base is 216 files that no reader outside the project will ever open. The glossary and the research-design pages are the two parts a supervisor, a reviewer or a new contributor actually needs, and they are stable enough to publish. The knowledge base stays the source; the site is the reading surface, so this must be a transformation with a stated direction rather than a copy that will drift.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 The glossary and the research-design pages (hypotheses, dimensions, task stratification) are reachable from the docs sidebar
- [ ] #2 The direction of truth is stated on the pages: .knowledge is the source, the site is generated or summarised from it
- [ ] #3 astro check passes and pixi run gates stays green
- [ ] #4 A stale-content check or a documented review step exists, so the site cannot quietly contradict .knowledge
<!-- AC:END -->
