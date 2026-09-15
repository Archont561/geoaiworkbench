---
id: KB-13-week4-benchmark-harness
title: "Week 4: Benchmark Harness"
category: roadmap
subcategory: weekly
tags: [roadmap, week4,benchmark,harness, tdd]
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
  primary_purpose: "Week 4: Benchmark Harness — daily TDD breakdown"
  key_facts:
    - "Focus: Monitors, OutputVerifier, StepTracker, BenchmarkHarness"
    - "Deliverable: 120 tests passing"
  common_questions:
    - "What do I do this week?"
    - "What are the daily tasks?"
---

# Week 4: Benchmark Harness

## Focus

Monitors, OutputVerifier, StepTracker, BenchmarkHarness

## Daily Breakdown

### Monday
Day 1: Implement MCPMonitor (hook injection); ACPMonitor; verify MonitorEvent schema; write monitor tests

### Tuesday
Day 2: Implement OutputVerifier (5 OQS sub-metrics); test with identical files (OQS=1.0), CRS mismatch, invalid geometry; write verifier tests

### Wednesday
Day 3: Implement StepTracker (step count, PEA, TSA, order); implement BenchmarkHarness with paradigm dispatch (_run_mcp vs _run_codegen); write harness tests

### Thursday
Day 4: Implement crash-safe persistence (JSONL + completed.json + filelock); implement BenchmarkOrchestrator skeleton with run key generation; write orchestrator tests

### Friday
Day 5: Full integration test: harness runs single task end-to-end for all 3 conditions; verify JSONL output; verify metrics computation; MILESTONE M3

## Week Deliverable

120 tests passing

## Success Criteria

Harness runs tasks; JSONL populated; OQS, PEA, TSR computed correctly

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
