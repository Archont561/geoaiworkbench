---
id: KB-14-all-decisions-summary
title: "Master Decision Log — All Decisions"
category: decisions-log
subcategory: master
tags: [decisions, master, summary, log, all]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-CHANGELOG
  - KB-02-design-evolution
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Master table of all major decisions with rationale and status"
  key_facts:
    - "20+ major decisions documented"
    - "Each has: context, options, choice, rationale, impact"
    - "Decisions span architecture, tooling, methodology, scope"
    - "All decisions traceable to evidence"
  common_questions:
    - "What decisions were made?"
    - "Why was X chosen over Y?"
    - "What is the decision history?"
---

# Master Decision Log — All Decisions

## Decision Registry

| # | Decision | Category | Choice | Date | Evidence | File |
|---|---|---|---|---|---|---|
| D1 | MCP SDK version | Architecture | FastMCP 4.0.3 standalone | 2026-09 | MCP SDK v2 breaking changes | [KB-14-mcp-sdk](decision-mcp-sdk.md) |
| D2 | Server architecture | Architecture | Separate MCP process + TCP bridge | 2026-09 | asyncio+Qt conflict | [KB-14-architecture](decision-architecture.md) |
| D3 | Package manager | Tooling | Pixi 0.80.0 | 2026-09 | QGIS native deps | [KB-14-pixi](decision-pixi.md) |
| D4 | Agent pool | Methodology | 4 primary + 2 backup CLI agents | 2026-09 | MCP support matrix | [KB-14-agent-pool](decision-agent-pool.md) |
| D5 | Metrics additions | Methodology | PEA, SHR, ITS, RR | 2026-09 | Round 1 literature | [KB-14-metrics](decision-metrics-additions.md) |
| D6 | Security dimension | Scope | PB5 + Layer 7 + 5 ADV tasks | 2026-09 | Hou et al. TOSEM | [KB-14-security](decision-security-dim.md) |
| D7 | Adversarial tasks | Methodology | ADV-01 to ADV-05 | 2026-09 | Hou + Maloyan + MSB | [KB-14-adversarial](decision-adversarial-tasks.md) |
| D8 | 3-condition experiment | Methodology | MCP-5 + MCP-15 + CodeGen | 2026-09 | Mo et al. + Song et al. | [KB-14-tool-count](decision-tool-count-expansion.md) |
| D9 | Infrastructure libs | Tooling | diskcache, tenacity, structlog, filelock | 2026-09 | Don't reinvent | [KB-14-infra-libs](decision-infrastructure-libs.md) |
| D10 | Thesis framing | Scope | Protocol-level evaluation | 2026-09 | Round 2 literature | [KB-14-framing](decision-thesis-framing.md) |
| D11 | QGIS version | Architecture | 3.44.x via conda-forge | 2026-09 | Pixi availability | [KB-08-qgis-version-3.44](../08-technology-decisions/qgis-version-3.44.md) |
| D12 | Protocol stack | Architecture | MCP≠ACP≠A2A clarified | 2026-09 | Ehtesham et al. | [KB-08-protocol-stack](../08-technology-decisions/protocol-stack-clarification.md) |
| D13 | Black box agents | Methodology | No agent instrumentation | 2026-09 | Fairness + reproducibility | [KB-08-black-box](../08-technology-decisions/black-box-vs-instrumented.md) |
| D14 | Pydantic v2 | Architecture | Pydantic v2, no dataclasses | 2026-09 | FastMCP requirement | [KB-08-pydantic](../08-technology-decisions/pydantic-v2-choice.md) |
| D15 | Polars over pandas | Tooling | Polars + DuckDB | 2026-09 | Speed + JSONL native | [KB-08-polars](../08-technology-decisions/polars-vs-pandas.md) |
| D16 | DuckDB over SQLite | Tooling | DuckDB | 2026-09 | Direct JSONL queries | [KB-08-duckdb](../08-technology-decisions/duckdb-vs-sqlite.md) |
| D17 | GeoAnalystBench source | Methodology | 50 tasks, ArcPy→PyQGIS | 2026-09 | Zhang et al. 2025 | [KB-12-geoanalystbench](../12-tasks-benchmark/geoanalystbench-overview.md) |
| D18 | DSRM methodology | Methodology | Peffers et al. 2007 | 2026-09 | Artifact + evaluation | [KB-02-methodology-dsrm](../02-research-design/methodology-dsrm.md) |
| D19 | Paradigm boundary | Architecture | Assertion + test enforcement | 2026-09 | qgis-mcp contamination | [KB-04-paradigm-boundary](../04-architecture/paradigm-boundary.md) |
| D20 | CodeGen evaluation | Architecture | 4-layer pipeline | 2026-09 | Web search results | [KB-02-final-research-design](../02-research-design/final-research-design.md) |

## Decision Categories

| Category | Count | Decisions |
|---|---|---|
| Architecture | 6 | D1, D2, D11, D12, D14, D19 |
| Methodology | 7 | D4, D5, D7, D8, D13, D17, D18 |
| Tooling | 4 | D3, D9, D15, D16 |
| Scope | 3 | D6, D10, D20 |

## Decision Evolution Timeline

```
2026-09-10  D18 DSRM → D17 GeoAnalystBench → D13 Black box → D19 Boundary
            D11 QGIS → D1 MCP SDK → D2 Architecture → D3 Pixi
            D14 Pydantic → D12 Protocols

2026-09-11  D4 Agents → D5 Metrics → D6 Security → D7 Adversarial
            D8 Tool count → D9 Infra libs → D10 Framing
            D15 Polars → D16 DuckDB → D20 CodeGen eval
```

## How to Use This Log

1. **Finding a decision:** Search by keyword or browse the table
2. **Understanding rationale:** Follow the link to the detailed decision file
3. **Tracing evidence:** Each decision cites specific literature or technical findings
4. **Challenging a decision:** Check the "Reversibility" section in each file

## Related Files

- [KB-CHANGELOG](../CHANGELOG.md) — Chronological evolution
- [KB-02-design-evolution](../02-research-design/design-evolution.md) — Research design stages
- Individual decision files in this directory
