---
id: KB-00-project-overview
title: "Project Overview"
category: meta
subcategory: overview
tags: [overview, description, artifact, thesis, mcp-5, mcp-15, codegen]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [1, 2, 5, 10, 15]
related:
  - KB-README
  - KB-00-research-questions
  - KB-00-contribution-summary
  - KB-00-scope-and-limitations
  - KB-02-final-research-design
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "High-level description of what GeoAIWorkbench is and what it does"
  key_facts:
    - "Master's thesis project at WIT PWr"
    - "Compares MCP tool calling vs code generation in QGIS"
    - "3 conditions: MCP-5 (5 tools), MCP-15 (15 tools), CodeGen (unlimited)"
    - "Uses 4 CLI agents × 3 conditions × 50 tasks × 3 reps = 1800 runs"
    - "Dual contribution: empirical study + open-source GeoMCP plugin"
  common_questions:
    - "What is GeoAIWorkbench?"
    - "What are the three paradigms being compared?"
    - "Why QGIS?"
    - "Why is this novel?"
    - "Why compare MCP-5 vs MCP-15?"
---

# Project Overview

## What Is GeoAIWorkbench?

**GeoAIWorkbench** is a master's thesis project that empirically compares **three paradigms** for LLM-driven GIS automation:

1. **MCP-5** — Constrained MCP tool calling with exactly 5 tools (paradigm-clean baseline)
2. **MCP-15** — Expanded MCP tool calling with 15 tools organized in 5 tiers (realistic GIS toolkit)
3. **CodeGen** — Direct PyQGIS code generation with unlimited flexibility

The comparison is conducted inside a real QGIS environment using production CLI agents (OpenCode, Claude Code, Codex CLI, Goose) as black boxes, evaluated on 50 GeoAnalystBench tasks stratified by difficulty.

## Why Three Conditions?

The 3-condition design tests two independent questions:

1. **MCP vs CodeGen** (Conditions A/B vs C) — Does tool-calling structure beat free-form code?
2. **MCP tool count effect** (Condition A vs B) — Does adding more tools help or hurt?

Literature evidence supports an **inverted-U curve** between tool count and performance:
- Too few tools → insufficient capability
- Too many tools → tool selection degradation (Mo et al., 2025)
- Sweet spot around 15-30 tools (Wang et al., 2025)

No prior work has empirically tested this in GIS context.

## Dual Contribution

The project produces two artifacts of equal importance:

### Artifact 1: GeoMCP Plugin (Tiered)

A custom QGIS plugin that exposes GIS tools via MCP with runtime tier control:

**Tier 1 — Inspection (2 tools):**
- `layer_info` — inspect layer metadata
- `layer_statistics` — compute field statistics

**Tier 2 — Core Geoprocessing (3 tools):**
- `buffer` — create buffer geometries
- `clip` — clip vector by overlay
- `reproject` — transform coordinate reference systems

**Tier 3 — Extended Geoprocessing (6 tools) — MCP-15 only:**
- `dissolve` — merge features by attribute
- `intersection` — overlay intersection
- `difference` — subtract overlay
- `union` — combine layers preserving all boundaries
- `spatial_join` — join attributes by spatial relationship
- `select_by_location` — select by spatial predicate

**Tier 4 — Geometry Operations (2 tools) — MCP-15 only:**
- `centroid` — compute feature centroids
- `simplify` — reduce geometry complexity

**Tier 5 — Data Management (2 tools) — MCP-15 only:**
- `merge_layers` — combine multiple layers
- `calculate_field` — compute new attributes

Controlled via `GEOMCP_TIER=5` or `GEOMCP_TIER=15` environment variable. The plugin **deliberately excludes** `execute_code` and any general-purpose Python execution at all tiers, enforcing a hard paradigm boundary that enables meaningful evaluation.

### Artifact 2: Empirical Study

A controlled factorial experiment with:

- **3 conditions** — MCP-5, MCP-15, CodeGen
- **4 CLI agents** — OpenCode, Claude Code, Codex CLI, Goose (all as black boxes)
- **50 tasks** — from GeoAnalystBench, stratified by difficulty and required tool tier
- **3 repetitions** — to measure execution determinism
- **1,800 total runs**

Evaluated on a 7-layer metrics framework covering task success, workflow quality, spatial output validity, execution behavior, complex task handling, composite scores, and security posture.

## Why QGIS?

- Most widely used open-source GIS
- Rich Processing framework with hundreds of native algorithms
- Real-world relevance (used by professional GIS analysts)
- Existing MCP integration attempts (qgis-mcp) demonstrate demand
- PyQGIS provides clean Python API for both paradigms

## Why This Is Novel

No prior work has:

1. Compared MCP tool calling vs code generation with a **paradigm-clean** MCP server (existing qgis-mcp includes `execute_code`, contaminating the comparison)
2. Tested the **tool count effect** in a GIS MCP server (MCP-5 vs MCP-15)
3. Evaluated **production CLI agents** as black boxes on GIS tasks (prior work builds custom agents)
4. Applied the **ED/CF Pareto framework** from Strickland et al. (2026) to GIS
5. Included a **security dimension** as a first-class evaluation axis (following Hou et al. ACM TOSEM 2025)
6. Provided a **decision framework** for practitioners: when to use MCP-5, MCP-15, or CodeGen for GIS automation

## Methodology

Framed as Design Science Research (Peffers et al., 2007):

1. **Problem identification** — GIS analysts need reliable LLM-driven automation; three paradigms exist, no rigorous comparison
2. **Objectives** — 7 research questions (PB1-PB7) covering success, difficulty moderation, agent interaction, execution behavior, security, information fidelity, tool count effect
3. **Design & Development** — GeoMCP plugin as artifact (with tier control)
4. **Demonstration** — 1,800-run benchmark
5. **Evaluation** — 7-layer metrics framework with statistical rigor (bootstrap CIs, Cliff's delta, Bonferroni correction)
6. **Communication** — Master's thesis + open-source release + potential journal article

## Technical Stack

- **Environment:** Pixi 0.80.0 (Conda + PyPI unified)
- **GIS:** QGIS 3.44.x, PyQGIS, Processing framework
- **MCP:** FastMCP 4.0.3 (standalone package)
- **Language:** Python 3.12
- **Testing:** pytest 8, pytest-qgis, pytest-xdist
- **Analysis:** Polars, DuckDB, scipy, statsmodels
- **Infrastructure:** structlog, diskcache, tenacity, filelock
- **CLI:** Typer + Rich
- **CodeGen Evaluation:** Tree-sitter, Parso, asttokens, coverage.py, VizTracer
- **Documentation:** LaTeX (wnozigp.sty), BibLaTeX

## Institution and Context

- **Institution:** WIT PWr (Wrocław University of Science and Technology, Faculty of Information and Communication Technology)
- **Level:** Master's thesis
- **Language:** Polish (main thesis) + English (abstract and potential journal article)
- **Timeline:** ~2 months from foundation to defense

## Repository Structure

```
GeoAIWorkbench/
├── pyproject.toml       # Pixi + Python config
├── pixi.lock            # Frozen environment
├── src/
│   ├── qgis_utils/      # Headless QGIS helpers
│   ├── geoaiworkbench/  # MCP server (tiered) + bridge + plugin
│   └── geoaibenchmark/  # Experiment runner
├── tasks/               # 50 GeoAnalystBench tasks + 5 adversarial
├── tests/               # 202+ tests (including MCP-15), TDD
├── benchmark.py         # Typer CLI entry point
├── thesis/              # LaTeX source
└── .knowledge/          # This knowledge base
```
