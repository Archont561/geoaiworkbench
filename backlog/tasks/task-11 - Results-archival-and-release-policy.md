---
id: TASK-11
title: Results archival and release policy
status: To Do
assignee: []
created_date: '2026-09-30 21:44'
labels:
  - orchestration
  - release
milestone: m-4
dependencies: []
documentation:
  - .knowledge/07-tooling/phase7-archival.md
  - .knowledge/04-architecture/crash-safe-persistence.md
priority: low
ordinal: 11000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The archival phase expects a published artefact: the result stream, the environment that produced it, and something citable. This repository already owns the publishing surface — publish-plan, publish-dist and the sandbox transport — so the policy for what a released run looks like belongs here rather than being improvised in week 8 under deadline.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 The shape of a published run is defined: results.jsonl, completed.json, the commit sha, pixi.lock and the agent versions, in one documented layout
- [ ] #2 A task produces that bundle from a completed run directory and refuses to produce a partial one
- [ ] #3 The policy states what is archived externally (DOI, dataset host) versus what is committed, and why
- [ ] #4 Crash-safe persistence assumptions from KB-04 are honoured: append-only JSONL, resumable via completed.json
<!-- AC:END -->
