---
id: KB-13-two-month-roadmap
title: "Two-Month TDD Roadmap Overview"
category: roadmap
subcategory: overview
tags: [roadmap, timeline, 8-weeks, tdd, milestones]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-13-critical-path
  - KB-09-testing-strategy
  - KB-02-final-research-design
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "8-week TDD roadmap from foundation to thesis defense"
  key_facts:
    - "8 weeks total"
    - "Weeks 1-5: Implementation (TDD)"
    - "Week 6: Pilot runs (50 runs)"
    - "Week 7: Full experiment (1,800 runs)"
    - "Week 8: Analysis + thesis writing"
    - "5 major milestones"
  common_questions:
    - "What is the timeline?"
    - "How long is the project?"
    - "When is the experiment?"
---

# Two-Month TDD Roadmap Overview

## Timeline Summary

| Week | Phase | Key Deliverable | Days |
|---|---|---|---|
| **1** | Foundation | Pixi env, TDD skeleton, qgis_utils | 5 |
| **2** | MCP Server | FastMCP 4.0.3, 15 tools, tier control | 5 |
| **3** | Bridge + QGIS | TCP bridge, QGIS plugin, CodeGen pipeline | 5 |
| **4** | Benchmark Harness | Monitors, verifier, harness, 4-layer eval | 5 |
| **5** | Orchestration | CLI, MLflow, agent configs, 50 task JSONs | 5 |
| **6** | Pilot Runs | 50 pilot runs, bug fixes, metric validation | 5 |
| **7** | Full Experiment | 1,800 runs, crash recovery, data collection | 7 |
| **8** | Analysis + Writing | Statistics, figures, thesis draft, defense prep | 7 |
| **Total** | | | **~44 working days** |

## Weekly Breakdown

| Week | Focus | Tests Written | Code Written |
|---|---|---|---|
| 1 | Environment + qgis_utils | 26 | 3 modules |
| 2 | GeoMCP server + models | 48 | 5 modules |
| 3 | Bridge + plugin + CodeGen | 32 | 6 modules |
| 4 | Monitors + verifier + harness | 40 | 8 modules |
| 5 | Orchestrator + CLI + tasks | 36 | 5 modules |
| 6 | Integration + pilot | 20 | Fixes |
| 7 | Experiment execution | 0 | Configs |
| 8 | Analysis + thesis | 0 | Scripts |
| **Total** | | **~202** | **~27 modules** |

## 5 Major Milestones

| # | Milestone | Target | Criteria |
|---|---|---|---|
| M1 | Environment Ready | End of Week 1 | `pixi run test` passes 26 tests |
| M2 | MCP Server Complete | End of Week 2 | 15 tools registered, paradigm boundary passes |
| M3 | Full Pipeline | End of Week 4 | Single task runs end-to-end for all 3 conditions |
| M4 | Pilot Validated | End of Week 6 | 50 pilot runs, metrics make sense |
| M5 | Experiment Complete | End of Week 7 | 1,800 runs in results.jsonl |

## Risk Buffer

- **Week 6** includes 2 days buffer for bug fixes
- **Week 7** includes weekend runs (1,800 runs ≈ 50-100 hours)
- **Week 8** has 2 days buffer for thesis polishing

## Prerequisites

Before Week 1 starts:
- [ ] WIT PWr enrollment confirmed
- [ ] Supervisor approval of research design
- [ ] Linux machine with 16GB+ RAM, 100GB+ disk
- [ ] API keys for at least 2 LLM providers
- [ ] GeoAnalystBench data downloaded

## Related Files

- [KB-13-week1-foundation](week1-foundation.md) through [KB-13-week8-analysis-writing](week8-analysis-writing.md)
- [KB-13-critical-path](critical-path.md)
