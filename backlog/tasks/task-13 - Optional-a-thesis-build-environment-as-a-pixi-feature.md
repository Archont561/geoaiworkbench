---
id: TASK-13
title: 'Optional: a thesis build environment as a pixi feature'
status: To Do
assignee: []
created_date: '2026-09-30 21:44'
labels:
  - tooling
dependencies: []
documentation:
  - .knowledge/11-thesis/latex-setup.md
  - .knowledge/11-thesis/visualization-prompts.md
priority: low
ordinal: 13000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The thesis has a LaTeX setup and a figure pipeline recorded in the knowledge base. If it is built from this repository, it needs its own pixi feature — a third environment, since a TeX distribution has no business in the QGIS solve and none in the bun one. This task exists to force the question rather than to assume the answer: if the thesis is built elsewhere, close it as wont-do and say so, because an undecided seam is how a 2 GB TeX Live ends up in the default environment.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 A decision is recorded: the thesis is built from this repository, or it is not
- [ ] #2 If it is, a thesis feature and environment exist and a build task produces the PDF without touching default or bun
- [ ] #3 If it is not, the knowledge files say where it is built and this task is closed as wont-do
<!-- AC:END -->
