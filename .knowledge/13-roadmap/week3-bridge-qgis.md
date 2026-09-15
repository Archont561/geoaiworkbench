---
id: KB-13-week3-bridge-qgis
title: "Week 3: Bridge + QGIS + CodeGen"
category: roadmap
subcategory: weekly
tags: [roadmap, week3,bridge,qgis, tdd]
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
  primary_purpose: "Week 3: Bridge + QGIS + CodeGen — daily TDD breakdown"
  key_facts:
    - "Focus: TCP bridge, QGIS plugin, CodeGen evaluation pipeline"
    - "Deliverable: 80 tests passing"
  common_questions:
    - "What do I do this week?"
    - "What are the daily tasks?"
---

# Week 3: Bridge + QGIS + CodeGen

## Focus

TCP bridge, QGIS plugin, CodeGen evaluation pipeline

## Daily Breakdown

### Monday
Day 1: Implement bridge.py TCP client; implement plugin.py TCP server with Qt main thread dispatch; write bridge protocol tests

### Tuesday
Day 2: Test bridge with real QGIS Processing (buffer, clip, reproject); verify PyQGIS runs on main thread; fix threading issues

### Wednesday
Day 3: Implement CodeGen pipeline: code_extractor.py (file-first + markdown + tree-sitter); code_analyzer.py (QGISIRBuilder AST parsing); write tests

### Thursday
Day 4: Implement qgis_validator.py (checkParameterValues); runtime_tracer.py (Docker + processing.run monkeypatch); codegen_monitor.py; write tests

### Friday
Day 5: End-to-end test: run single task in all 3 conditions manually; verify outputs; document architecture (.knowledge/ Batch 5); MILESTONE M3 (early)

## Week Deliverable

80 tests passing

## Success Criteria

Bridge round-trip works; CodeGen 4-layer pipeline produces scores; single task runs in MCP-5, MCP-15, CodeGen

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
