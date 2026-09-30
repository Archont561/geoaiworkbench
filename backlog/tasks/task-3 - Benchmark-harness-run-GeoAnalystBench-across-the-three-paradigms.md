---
id: TASK-3
title: 'Benchmark harness: run GeoAnalystBench across the three paradigms'
status: To Do
assignee: []
created_date: '2026-09-30 19:52'
updated_date: '2026-09-30 21:45'
labels:
  - feature
milestone: m-4
dependencies:
  - TASK-9
  - TASK-10
documentation:
  - .knowledge/04-architecture/crash-safe-persistence.md
  - .knowledge/12-tasks-benchmark/task-execution-flow.md
  - .knowledge/03-metrics/metrics-overview.md
priority: high
ordinal: 3000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
geoai-bench is a Typer/Rich scaffold whose only command reports its own state. The harness internals — the Qt worker, the hook injection, the metric computations for layers 1-7 — belong to the feature repository and are specified across .knowledge/04-architecture/ and .knowledge/03-metrics/.

What this task owns is the property that makes the 1,800 runs a study rather than a log: a run is identified, its provenance is recorded, the stream survives a crash, and the same input reproduces the same numbers. Those are properties of the environment and the result format, which is what this repository is for.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 A run is identified by a key of agent, condition, task and repetition, and the same key is never executed twice in one campaign
- [ ] #2 Every result line records the provenance of the run: commit sha, pixi.lock hash, agent version and GEOMCP_TIER
- [ ] #3 Results are written append-only as JSONL with a completed.json index, so an interrupted campaign resumes without duplicating or losing runs
- [ ] #4 A rerun of the same key against the same fixtures reproduces the same metric values for the deterministic metrics
- [ ] #5 The harness runs one task end to end in each of the three conditions before any campaign is attempted
<!-- AC:END -->
