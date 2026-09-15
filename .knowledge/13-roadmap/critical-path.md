---
id: KB-13-critical-path
title: "Critical Path and Milestones"
category: roadmap
subcategory: critical-path
tags: [roadmap, critical-path, milestones, dependencies, risks]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-13-two-month-roadmap
  - KB-02-final-research-design
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Critical path dependencies and 5 major milestones"
  key_facts:
    - "Critical path: qgis_utils → geo_mcp → bridge → harness → orchestrator → experiment"
    - "5 milestones with go/no-go criteria"
    - "Week 7 is the bottleneck (1,800 runs)"
    - "Parallel tracks: thesis writing can start Week 4"
  common_questions:
    - "What is the critical path?"
    - "What are the milestones?"
    - "What can be parallelized?"
---

# Critical Path and Milestones

## Critical Path

The longest dependency chain that determines minimum project duration:

```
Week 1          Week 2          Week 3          Week 4          Week 5          Week 6          Week 7          Week 8
qgis_utils ──► geo_mcp.py ──► bridge.py ──► harness.py ──► orchestrator ──► pilot runs ──► 1,800 runs ──► analysis
   │              │              │              │              │              │              │              │
   ▼              ▼              ▼              ▼              ▼              ▼              ▼              ▼
  26 tests      48 tests      32 tests      40 tests      36 tests      validation      data collect    thesis
  M1 ✅         M2 ✅         M3 ✅         M3 ✅         ready         M4 ✅         M5 ✅         defense
```

### Critical Dependencies

| Task | Depends On | Blocks |
|---|---|---|
| qgis_utils | Pixi install | Everything |
| geo_mcp.py | qgis_utils, fastmcp | bridge, harness |
| bridge.py | geo_mcp, QGIS plugin | harness MCP condition |
| code_analyzer.py | tree-sitter, parso | harness CodeGen condition |
| harness.py | bridge, monitors, verifier | orchestrator |
| orchestrator.py | harness, JSONL | pilot runs |
| pilot runs | orchestrator, agents, tasks | full experiment |
| full experiment | pilot validated | analysis |
| analysis | full experiment data | thesis Chapter VI |

## 5 Major Milestones

### M1: Environment Ready (End of Week 1)

**Go/No-Go Criteria:**
- [ ] `pixi install` succeeds
- [ ] QGIS 3.44 confirmed via `pixi list | grep qgis`
- [ ] `pixi run test` passes 26 qgis_utils tests
- [ ] GitHub Actions CI green
- [ ] .knowledge/ Batches 1-3 complete

**If failed:** Debug Pixi/QGIS compatibility. May need Docker fallback.

### M2: MCP Server Complete (End of Week 2)

**Go/No-Go Criteria:**
- [ ] 15 tools registered in FastMCP
- [ ] `GEOMCP_TIER=5` → exactly 5 tools
- [ ] `GEOMCP_TIER=15` → exactly 15 tools
- [ ] `test_no_execute_code_tool_exposed` passes
- [ ] MCP Inspector shows all tools with correct schemas
- [ ] 74 tests passing (26 + 48)

**If failed:** Debug FastMCP version compatibility. May need to pin older version.

### M3: Full Pipeline (End of Week 4)

**Go/No-Go Criteria:**
- [ ] Single task runs end-to-end in MCP-5 condition
- [ ] Single task runs end-to-end in MCP-15 condition
- [ ] Single task runs end-to-end in CodeGen condition
- [ ] JSONL output contains valid TaskResult
- [ ] OQS, PEA, TSR computed correctly
- [ ] 120+ tests passing

**If failed:** Most likely bridge threading issue or CodeGen Docker problem. Allocate Week 5 buffer.

### M4: Pilot Validated (End of Week 6)

**Go/No-Go Criteria:**
- [ ] 60-240 pilot runs completed
- [ ] TSR in expected range (40-90%)
- [ ] OQS distributions reasonable
- [ ] No systematic crashes or timeouts
- [ ] Crash recovery tested and working
- [ ] Statistical tests produce sensible results on pilot data

**If failed:** Identify and fix systematic issues. May need to reduce task count or extend timeline.

### M5: Experiment Complete (End of Week 7)

**Go/No-Go Criteria:**
- [ ] 1,800 run keys in completed.json
- [ ] results.jsonl has 1,800 lines
- [ ] No missing data (all paradigm × agent × task × rep combinations)
- [ ] JSONL integrity verified (all lines valid JSON)
- [ ] 202 tests still passing (no regressions)

**If failed:** Re-run missing combinations. May extend into Week 8.

## Parallel Tracks

Not everything is on the critical path. These can run in parallel:

| Track | When | Parallel With |
|---|---|---|
| Thesis Chapters I-III | Weeks 2-4 | Implementation |
| .knowledge/ batches | Weeks 1-5 | Everything |
| Agent config setup | Week 4-5 | Harness development |
| Task JSON creation | Week 4-5 | Harness development |
| Reference output generation | Week 5 | Orchestrator setup |
| Thesis Chapters IV-V | Weeks 5-6 | Pilot runs |
| Thesis Chapter VI | Week 8 | Analysis |
| Defense slides | Week 8 | Thesis polishing |

## Risk Assessment

| Risk | Probability | Impact | Mitigation |
|---|---|---|---|
| QGIS/Pixi incompatibility | Medium | High | Docker fallback |
| Agent API rate limits | High | Medium | Stagger runs, use BYOM (Goose) |
| 1,800 runs take too long | Medium | High | Run overnight/weekend; parallel agents |
| CodeGen Docker overhead | High | Medium | Reuse containers; batch execution |
| Reference outputs wrong | Low | High | Cross-validate with manual checks |
| Thesis deadline pressure | Medium | High | Start writing Week 4; use .knowledge/ |
| Paradigm boundary leak | Low | Critical | CI test on every commit |

## Timeline Visualization

```
Week:  1    2    3    4    5    6    7    8
       ├────┼────┼────┼────┼────┼────┼────┤
Impl:  ████ ████ ████ ████ ████
Pilot:                         ████
Exper:                              ██████
Write:      ░░░░ ░░░░ ░░░░ ░░░░ ░░░░ ████
       M1   M2        M3        M4   M5

█ = Critical path    ░ = Parallel track
```

## Related Files

- [KB-13-two-month-roadmap](two-month-roadmap.md)
- [KB-02-final-research-design](../02-research-design/final-research-design.md)
- [KB-09-testing-strategy](../09-testing/testing-strategy.md)
