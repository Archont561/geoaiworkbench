---
id: KB-07-toolchain-overview
title: "Complete Toolchain Overview"
category: tooling
subcategory: overview
tags: [toolchain, tools, overview, phases, stack]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-07-phase0-environment
  - KB-06-pyproject-toml
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Master list of all tools organized by project phase"
  key_facts:
    - "8 phases: environment, development, plugin, execution, analysis, writing, visualization, archival"
    - "~40 tools total"
    - "Pixi as central package manager"
    - "No LangChain, no W&B, no uv"
  common_questions:
    - "What tools does the project use?"
    - "What is used for phase X?"
    - "Why not tool Y?"
---

# Complete Toolchain Overview

## Tool Summary by Category

| Category | Tools | Count |
|---|---|---|
| Environment | Pixi, conda-forge, Docker, Git | 4 |
| Language | Python 3.12 | 1 |
| GIS | QGIS 3.44, PyQGIS, Processing | 3 |
| MCP | FastMCP 4.0.3, MCP Inspector | 2 |
| Agents | OpenCode, Claude Code, Codex, Goose | 4 |
| Validation | Pydantic 2, Shapely, GeoPandas, rasterio, pyproj | 5 |
| Caching | diskcache, cachetools, platformdirs | 3 |
| Reliability | tenacity, filelock | 2 |
| Logging | structlog | 1 |
| HTTP | httpx | 1 |
| Testing | pytest, pytest-qgis, pytest-xdist | 3 |
| Quality | Ruff, mypy | 2 |
| Evaluation | DeepEval, scikit-image | 2 |
| CLI | Typer, Rich | 2 |
| Code Analysis | tree-sitter, parso, asttokens, coverage, viztracer | 5 |
| Data | Polars, DuckDB | 2 |
| Statistics | scipy, statsmodels | 2 |
| Plotting | matplotlib, seaborn, TikZ, pgfplots | 4 |
| Tracking | JSONL, MLflow | 2 |
| Writing | LaTeX, BibLaTeX, JabRef, Zotero | 4 |
| CI/CD | GitHub Actions, setup-pixi | 2 |
| Archival | Zenodo, pixi pack, Git LFS | 3 |

## Phase Mapping

| Phase | Primary Tools | Files |
|---|---|---|
| 0. Environment | Pixi, conda-forge, Docker | [KB-07-phase0](phase0-environment.md) |
| 1. Development | VS Code, Ruff, mypy, pytest | [KB-07-phase1](phase1-development.md) |
| 2. QGIS Plugin | Plugin Builder, MCP Inspector | [KB-07-phase2](phase2-qgis-plugin.md) |
| 3. Execution | CLI agents, DeepEval | [KB-07-phase3](phase3-execution.md) |
| 4. Analysis | Polars, DuckDB, scipy | [KB-07-phase4](phase4-analysis.md) |
| 5. Writing | LaTeX, BibLaTeX, JabRef | [KB-07-phase5](phase5-writing.md) |
| 6. Visualization | TikZ, draw.io, Beamer | [KB-07-phase6](phase6-visualization.md) |
| 7. Archival | Zenodo, pixi pack, Git LFS | [KB-07-phase7](phase7-archival.md) |

## Tools Explicitly NOT Used

| Tool | Why Not |
|---|---|
| uv | Replaced by Pixi (can't install QGIS) |
| LangChain / LlamaIndex | Agents are black boxes |
| Weights & Biases | MLflow self-hosted sufficient |
| DVC | Git LFS simpler for this scale |
| Airflow / Prefect | 1,800 runs is a loop, not a DAG |
| RestrictedPython | Wrong security boundary for PyQGIS |
| pandas | Polars faster + native JSONL |

## Related Files

- [KB-07-dependencies-rationale](dependencies-rationale.md) — Why each package
- [KB-07-tools-to-avoid](tools-to-avoid.md) — Detailed exclusion rationale
- [KB-06-pyproject-toml](../06-implementation/pyproject-toml.md) — Config
