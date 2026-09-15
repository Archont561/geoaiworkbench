---
id: KB-13-week5-orchestration
title: "Week 5: Orchestration + Tasks"
category: roadmap
subcategory: weekly
tags: [roadmap, week5,orchestration, tdd]
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
  primary_purpose: "Week 5: Orchestration + Tasks — daily TDD breakdown"
  key_facts:
    - "Focus: CLI, MLflow, agent configs, 50 task JSONs, adversarial tasks"
    - "Deliverable: 182 tests passing"
  common_questions:
    - "What do I do this week?"
    - "What are the daily tasks?"
---

# Week 5: Orchestration + Tasks

## Focus

CLI, MLflow, agent configs, 50 task JSONs, adversarial tasks

## Daily Breakdown

### Monday
Day 1: Implement benchmark.py Typer CLI (run, analyse, status) with Rich progress bars; test --dry-run mode

### Tuesday
Day 2: Create 50 GeoAnalystBench task JSON files (adapted from ArcPy); assign difficulty tiers and minimum_tier; create 5 ADV task JSONs

### Wednesday
Day 3: Generate reference outputs for all 55 tasks via scripts/generate_reference_outputs.py; validate with OutputVerifier

### Thursday
Day 4: Create 12 agent config files (4 agents × 3 conditions); set up MLflow tracking; implement metrics.py and statistics.py analysis pipeline

### Friday
Day 5: Dry-run full benchmark (--dry-run) to verify 1,800 run keys generated correctly; verify agent configs; verify reference outputs; document implementation (.knowledge/ Batch 7)

## Week Deliverable

182 tests passing

## Success Criteria

CLI works; 55 task JSONs valid; 12 agent configs tested; MLflow connected; analysis pipeline produces metrics

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
