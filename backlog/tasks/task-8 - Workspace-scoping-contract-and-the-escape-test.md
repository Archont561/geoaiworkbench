---
id: TASK-8
title: Workspace scoping contract and the escape test
status: To Do
assignee: []
created_date: '2026-09-30 21:44'
updated_date: '2026-09-30 21:45'
labels:
  - security
  - orchestration
milestone: m-1
dependencies: []
documentation:
  - .knowledge/10-security/workspace-scoping.md
  - .knowledge/10-security/input-validation.md
  - .knowledge/10-security/auth-strategy.md
priority: medium
ordinal: 8000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Layer 7 counts data exfiltration risk per condition, and the mitigation recorded for it is workspace scoping: every path a tool touches resolves inside one declared workspace root. That is an environment contract — an activation variable and a resolution rule — before it is server code, and an unscoped run can write outside the workspace on a developer machine long before any adversarial task is written.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 A single environment variable (GEOAI_WORKSPACE or the name KB-10-workspace-scoping uses) is declared in pixi.toml activation with a documented default
- [ ] #2 A shared resolver rejects absolute paths, .. traversal and symlinks that leave the root, and it is the only path entry point the packages use
- [ ] #3 Tests cover the traversal, absolute-path and symlink cases and run in the gate
- [ ] #4 The variable and its default are documented on the docs site alongside the security dimension
<!-- AC:END -->
