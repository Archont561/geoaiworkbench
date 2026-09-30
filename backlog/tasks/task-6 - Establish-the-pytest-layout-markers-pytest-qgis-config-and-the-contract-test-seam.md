---
id: TASK-6
title: >-
  Establish the pytest layout: markers, pytest-qgis config, and the
  contract-test seam
status: To Do
assignee: []
created_date: '2026-09-30 21:44'
updated_date: '2026-09-30 21:45'
labels:
  - orchestration
  - testing
milestone: m-0
dependencies: []
documentation:
  - .knowledge/09-testing/testing-strategy.md
  - .knowledge/09-testing/test-inventory.md
  - .knowledge/09-testing/contract-tests.md
  - .knowledge/09-testing/critical-tests.md
priority: high
ordinal: 6000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The test inventory specifies 202 tests across three packages, split into unit, integration, contract and adversarial groups, several of which need a QGIS application and several of which must never start one. The three packages currently have one version test each and no way to express that distinction, so the first real test will invent a convention and the second will invent a different one. The marker taxonomy and the pytest-qgis configuration are root-level config, which is this repository.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 pyproject.toml (or the shared pytest config) registers markers for unit, integration, contract and adversarial, and --strict-markers is on so a typo fails
- [ ] #2 pytest-qgis is configured once, and the .qgis-settings artefact it writes stays ignored
- [ ] #3 pixi run test still fans out across all three packages, and a marker can select a subset without naming paths
- [ ] #4 One contract test exists as the worked example of the seam, and it runs in the gate
<!-- AC:END -->
