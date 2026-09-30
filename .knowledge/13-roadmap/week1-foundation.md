---
id: KB-13-week1-foundation
title: "Week 1: Foundation"
category: roadmap
subcategory: weekly
tags: [roadmap, week1,foundation, tdd]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-13-two-month-roadmap
  - KB-13-critical-path
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Week 1: Foundation — daily TDD breakdown"
  key_facts:
    - "Focus: Environment setup, TDD skeleton, qgis_utils package"
    - "Deliverable: 26 tests passing"
  common_questions:
    - "What do I do this week?"
    - "What are the daily tasks?"
---

# Week 1: Foundation

## Focus

Environment setup, TDD skeleton, qgis_utils package

## Daily Breakdown

### Monday
Day 1: Install Pixi 0.80, create pyproject.toml, pixi install, verify QGIS 3.44 via conda-forge; git init, .gitignore, CI workflow

### Tuesday
Day 2: Write 26 failing tests for qgis_utils (RED); implement HeadlessIface, qgis_app context manager (GREEN); refactor (REFACTOR)

### Wednesday
Day 3: Implement resolve_qgis_paths, init_processing; verify pytest-qgis fixtures work; test on Docker qgis/qgis:3.44

### Thursday
Day 4: Set up VS Code + Pylance + Ruff + mypy; configure pixi tasks (test, lint, format, typecheck); first CI run on GitHub Actions

### Friday
Day 5: Write project README; document .knowledge/ Batch 1-3; verify all 26 tests pass; MILESTONE M1

## Week Deliverable

26 tests passing

## Success Criteria

This week closes backlog milestone `m-0` (M1 Environment ready). The criteria are the
milestone's, so they are kept there rather than restated here:

```
pixi run backlog -- milestone list
```

## TDD Cycle

Each day follows RED → GREEN → REFACTOR:
1. **RED:** Write failing test for the day's feature
2. **GREEN:** Implement minimum code to pass
3. **REFACTOR:** Clean up, run full test suite

## Risks This Week

- Delays cascade to subsequent weeks
- QGIS/PyQGIS compatibility issues may require debugging
- Agent API rate limits may slow pilot runs

## Related Files

- KB-13-two-month-roadmap
- KB-13-critical-path
