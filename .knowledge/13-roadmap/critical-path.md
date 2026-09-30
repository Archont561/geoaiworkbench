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

The milestones and their go/no-go criteria are **backlog objects**, not prose in
this file — they have status, and tasks hang off them:

```
pixi run backlog -- milestone list
```

| Milestone | Gate | End of |
|---|---|---|
| `m-0` | M1 Environment ready | Week 1 |
| `m-1` | M2 MCP server complete | Week 2 |
| `m-2` | M3 Full pipeline | Week 4 |
| `m-3` | M4 Pilot validated | Week 6 |
| `m-4` | M5 Experiment complete | Week 7 |

Each backlog milestone carries the checklist that used to live here plus the
fallback to take if the gate does not open.


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
- Milestones and their criteria: `pixi run backlog -- milestone list`
