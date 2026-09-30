---
id: TASK-1
title: Split the pixi environments so QGIS and bun stop sharing one icu solve
status: To Do
assignee: []
created_date: '2026-09-30 19:52'
labels:
  - orchestration
dependencies: []
priority: high
ordinal: 1000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
pixi.toml has a single default environment because the current QGIS build pins icu75.1 while any newer QGIS pins icu78.3, and bun pins icu75. Split into default (QGIS) and bun. Raising the QGIS floor is blocked on this.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 pixi.toml declares two environments,default (qgis) and bun (javascript tooling),No task in pixi.toml or lefthook.yml hardcodes -e, so both environments resolve from one command set,pixi run gates passes in both,airlock.yml proves both restore offline
<!-- AC:END -->
