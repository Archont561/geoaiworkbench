---
id: TASK-9
title: 'Benchmark data layout: task JSON, reference outputs and a storage policy'
status: To Do
assignee: []
created_date: '2026-09-30 21:44'
updated_date: '2026-09-30 21:45'
labels:
  - orchestration
  - data
milestone: m-2
dependencies: []
documentation:
  - .knowledge/12-tasks-benchmark/task-schema.md
  - .knowledge/12-tasks-benchmark/reference-outputs.md
  - .knowledge/12-tasks-benchmark/geoanalystbench-overview.md
priority: medium
ordinal: 9000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Fifty GeoAnalystBench tasks plus their reference outputs are inputs to every run, and reference rasters and vectors are exactly the kind of file that ends up committed once and regretted for the life of the repository. The task schema is already specified as a Pydantic model and the file organisation is sketched; what is missing is the decision about where the bytes live and how a run proves it used the right ones.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 The BenchmarkTask schema and the on-disk layout for tasks/ and reference outputs are fixed and documented
- [ ] #2 A storage policy is decided and recorded: what may be committed, what goes to external storage or LFS, and how .gitattributes expresses it
- [ ] #3 Reference outputs are content-addressed or checksummed, so a run records which fixture version produced its numbers
- [ ] #4 A validation task checks every task JSON against the schema, and it runs in the gate
<!-- AC:END -->
