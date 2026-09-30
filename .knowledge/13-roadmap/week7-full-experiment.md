---
id: KB-13-week7-full-experiment
title: "Week 7: Full Experiment"
category: roadmap
subcategory: weekly
tags: [roadmap, week7,full,experiment, tdd]
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
  primary_purpose: "Week 7: Full Experiment — daily TDD breakdown"
  key_facts:
    - "Focus: 1,800 runs across all conditions"
    - "Deliverable: Day 6-7: Buffer days for re-runs, crash recovery, data validation; MILESTONE M5"
  common_questions:
    - "What do I do this week?"
    - "What are the daily tasks?"
---

# Week 7: Full Experiment

## Focus

1,800 runs across all conditions

## Daily Breakdown

### Monday
Day 1: Start full benchmark (MCP-5 condition first: 4 agents × 50 tasks × 3 reps = 600 runs); monitor overnight

### Tuesday
Day 2: Check MCP-5 results; start MCP-15 condition (600 runs); monitor for issues

### Wednesday
Day 3: Check MCP-15 results; start CodeGen condition (600 runs); this is slowest (Docker per task)

### Thursday
Day 4: Monitor CodeGen runs; handle timeouts and crashes; resume as needed

### Friday
Day 5: Complete remaining runs; verify all 1,800 run keys in completed.json; check JSONL integrity

## Week Deliverable

Day 6-7: Buffer days for re-runs, crash recovery, data validation; MILESTONE M5

## Success Criteria

This week closes backlog milestone `m-4` (M5 Experiment complete). The criteria are the
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
