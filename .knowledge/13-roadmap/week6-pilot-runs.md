---
id: KB-13-week6-pilot-runs
title: "Week 6: Pilot Runs"
category: roadmap
subcategory: weekly
tags: [roadmap, week6,pilot,runs, tdd]
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
  primary_purpose: "Week 6: Pilot Runs — daily TDD breakdown"
  key_facts:
    - "Focus: Small-scale validation, bug fixes, metric sanity checks"
    - "Deliverable: 202 tests passing"
  common_questions:
    - "What do I do this week?"
    - "What are the daily tasks?"
---

# Week 6: Pilot Runs

## Focus

Small-scale validation, bug fixes, metric sanity checks

## Daily Breakdown

### Monday
Day 1: Run pilot: 5 tasks × 4 agents × 3 conditions × 1 rep = 60 runs; monitor for crashes, timeouts, config issues

### Tuesday
Day 2: Analyze pilot results; check metric distributions (TSR, OQS, PEA); verify metrics make sense; fix any computation bugs

### Wednesday
Day 3: Fix bugs discovered in pilot; re-run failed tasks; verify CodeGen Docker sandbox works; verify MCP-15 tier exposes correct tools

### Thursday
Day 4: Run extended pilot: 10 tasks × 4 agents × 3 conditions × 2 reps = 240 runs; test crash recovery (kill process mid-run, resume)

### Friday
Day 5: Final pilot analysis; validate statistical tests on pilot data; verify Bonferroni correction; prepare for full run; MILESTONE M4

## Week Deliverable

202 tests passing

## Success Criteria

60-240 pilot runs complete; metrics validated; crash recovery tested; no critical bugs

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
