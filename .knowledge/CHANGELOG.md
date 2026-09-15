---
id: KB-CHANGELOG
title: "Decision Evolution Log"
category: meta
subcategory: history
tags: [changelog, decisions, evolution, history]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-README
  - KB-14-all-decisions-summary
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Chronological log of major decision changes over the project lifecycle"
  key_facts:
    - "Tracks when decisions were made and superseded"
    - "Explains WHY decisions changed, not just WHAT"
    - "Cross-references decision log files"
    - "Major update 2026-09-11: added MCP-15 as second experimental condition"
  common_questions:
    - "When did we decide to use Pixi over uv?"
    - "Why did the architecture change to separate MCP process?"
    - "What triggered the addition of security dimension?"
    - "Why was MCP-15 added?"
---

# Decision Evolution Log

Chronological log of major decisions and their evolution during the GeoAIWorkbench project.

## 2026-09-11 — Tool Count Expansion (Major Update)

- **Added** MCP-15 as second experimental condition alongside MCP-5 and CodeGen
- **Added** PB7 research question on tool count effect
- **Added** Tier system for GeoMCP tools (Tier 1-5)
- **Added** `GEOMCP_TIER` environment variable for runtime tier control
- **Added** 10 new tool specifications: dissolve, intersection, difference, union, spatial_join, select_by_location, centroid, simplify, merge_layers, calculate_field
- **Updated** experimental structure from 2×4×50×3 = 1,200 runs to 3×4×50×3 = 1,800 runs
- **Rationale:** Literature evidence from Mo et al. (2025), Song et al. (2025), Fan et al. (2026) supports making tool count an experimental variable. Turns "5 tools is unrealistically limited" from a limitation into a research contribution.

## 2026-09-11 — CodeGen Evaluation Architecture (Major Update)

- **Added** 4-layer CodeGen evaluation pipeline (Static / Semantic / Runtime / Artifact)
- **Added** Tree-sitter + Parso for error-recovery parsing of LLM-generated code
- **Added** QGIS Workflow IR for structured code analysis
- **Added** `checkParameterValues()` from QGIS Processing registry for semantic validation
- **Added** Docker QGIS containerization for runtime execution isolation
- **Added** `processing.run()` monkeypatching for runtime tracing
- **Rationale:** Search revealed GeoAnalystBench uses ArcPy (not PyQGIS). GeoAIWorkbench must build QGIS-native evaluation pipeline. Naive `ast` + `subprocess.run()` insufficient for fair MCP vs CodeGen comparison.

## 2026-09-10 — Batch 1: Foundation

- **Created** knowledge base structure with 16 top-level directories
- **Established** YAML frontmatter schema for all files
- **Defined** file ID convention: `KB-NN-slug`

## Design Evolution (Retrospective Log)

### Stage 1 — Initial Research Idea
- **Initial:** Compare function calling vs code generation
- **Superseded by:** Luo et al. (2026) had already done this; needed differentiation
- **Resolution:** Added QGIS environment, protocol focus, security dimension

### Stage 2 — Protocol Selection
- **Initial:** MCP + ACP as integration layers
- **Refined:** ACP merged into A2A in August 2025; clarified MCP = tools, A2A = agents
- **Resolution:** Focus on MCP for tools; A2A deferred to future work
- **Further clarification:** OpenCode's `opencode acp` uses ACP (editor-agent), not A2A

### Stage 3 — Agent Selection
- **Initial:** Build custom agents
- **Superseded by:** Use production CLI agents as black boxes
- **Final:** 4 primary agents (OpenCode, Claude Code, Codex, Goose) + 2 backup (Gemini, Cline)

### Stage 4 — Execution Environment
- **Initial:** Cloud-based agents
- **Superseded by:** QGIS as unified environment (real-world relevance)
- **Final:** Standalone MCP server + TCP bridge to QGIS plugin (avoids asyncio+Qt conflicts)

### Stage 5 — MCP Server Architecture
- **Initial:** Use existing qgis-mcp server
- **Blocked by:** qgis-mcp exposes `execute_code`, contaminating paradigm boundary
- **Resolution:** Build custom GeoMCP plugin with hard paradigm boundary

### Stage 6 — MCP SDK Choice
- **Initial:** Use `mcp.server.fastmcp.FastMCP` (v1 API)
- **Blocked by:** MCP SDK v2 released July 2026 with breaking changes; FastMCP became separate package
- **Resolution:** Use standalone `fastmcp` package v4.0.3 with `@mcp.tool` decorator (no parens)

### Stage 7 — Package Manager
- **Initial:** uv with system QGIS
- **Superseded by:** Pixi (Conda + PyPI unified) — solves QGIS/GDAL/GEOS/PROJ reproducibility
- **Resolution:** Pixi 0.80.0 as primary package manager, conda-forge for native deps

### Stage 8 — Research Questions
- **Initial:** 5 research questions (PB1-PB5) focused on comparison
- **Enhanced:** Added security dimension (PB5 became security-focused) after Hou et al. (ACM TOSEM) evidence
- **Optional addition:** PB6 on information fidelity after Fan et al. (AAMAS 2026)
- **Second enhancement (2026-09-11):** Added PB7 on tool count effect

### Stage 9 — Metrics Framework
- **Initial:** 6 layers (task, workflow, output, execution, complex, composite)
- **Enhanced Round 1:** Added PEA, SHR, ITS, RR metrics
- **Enhanced Round 2:** Added Layer 7 (Security) with attack surface + injection resistance
- **Enhanced Round 3 (2026-09-11):** Added tool count metrics: Tool Selection Degradation, Context Window Utilization
- **Final:** 7 layers, ~28 metrics total

### Stage 10 — Infrastructure Libraries
- **Initial:** Roll-your-own for cache, retry, logging
- **Refined:** Use mature libraries: diskcache, tenacity, structlog, filelock, platformdirs
- **Rationale:** "GeoAIWorkbench should contain the genuinely novel QGIS/MCP/benchmark logic; commodity infrastructure should come from mature libraries"

### Stage 11 — Bibliography Evolution
- **Round 0:** 13 initial references
- **Round 1 (Consensus):** +11 references (MCP-Bench, LiveMCP-101, GeoBenchX, ThinkGeo, etc.)
- **Round 2 (Consensus):** +9 references (Hou et al. TOSEM, Fan et al. AAMAS, Ehtesham et al., MSB, etc.)
- **Total:** 33+ references

### Stage 12 — Thesis Framing
- **Initial:** "Is MCP better than code generation?"
- **Refined:** "How does MCP as a protocol affect interoperability, planning, parameterization, output validity, and security?"
- **Enhanced (2026-09-11):** "How does MCP tool count affect the tradeoff between capability and tool selection accuracy?"
- **Rationale:** Protocol-level evaluation is more defensible and matches ACM TOSEM / AAMAS venue standards

### Stage 13 — Experimental Design Expansion
- **Initial (2026-09-10):** 2 conditions (MCP-5 vs CodeGen), 1,200 runs
- **Enhanced (2026-09-11):** 3 conditions (MCP-5 vs MCP-15 vs CodeGen), 1,800 runs
- **Rationale:** Tool count as experimental variable directly tests Mo et al., Song et al., Fan et al. hypotheses in GIS context — first such study

## Key Reversals

| Original | Revised | Reason |
|---|---|---|
| MCP embedded in QGIS QThread | Standalone MCP process + TCP bridge | asyncio + Qt event loop conflicts |
| `mcp.server.fastmcp` v1 | `fastmcp` v4.0.3 standalone | MCP SDK v2 breaking changes |
| uv package manager | Pixi | Native QGIS/GDAL dependencies |
| pandas for analysis | Polars + DuckDB | Speed + JSONL native queries |
| ACP as A2A | ACP ≠ A2A (distinct protocols) | Ehtesham et al. protocol survey |
| Security as afterthought | PB5 first-class dimension | Hou et al. ACM TOSEM |
| Custom logging | structlog JSON events | Trajectory analysis needs structure |
| 5 tools only | 5 or 15 tools (tiered) | Tool count as experimental variable |
| 2 conditions | 3 conditions (MCP-5, MCP-15, CodeGen) | Test tool count effect |
| GeoAnalystBench = PyQGIS | GeoAnalystBench = ArcPy (adapt to QGIS) | Verified in Round 2 web search |
| Naive `ast` + subprocess | 4-layer CodeGen pipeline | QGIS-native evaluation needed |

## Future Anticipated Changes

- Task suite may expand from 50 to 55 tasks (adding ADV-01 to ADV-05)
- Optional third experimental condition (MCP-only / MCP+descriptions / MCP+instructions) if time permits
- MLflow may be replaced with plain SQLite if MLflow proves overkill
- Potential MCP-25 or MCP-30 tier if MCP-15 doesn't show expected degradation
