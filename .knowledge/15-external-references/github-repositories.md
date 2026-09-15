---
id: KB-15-github-repositories
title: "All Relevant GitHub Repositories"
category: external-references
subcategory: repositories
tags: [github, repositories, urls, related-work]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [4, 7]
related:
  - KB-15-mcp-official-docs
  - KB-15-cli-agent-docs
  - KB-15-fastmcp-docs
  - KB-15-pixi-docs
  - KB-15-qgis-pyqgis-docs
authoritative: false
implementation_status: specified
llm_hints:
  primary_purpose: "Master list of all GitHub repositories relevant to GeoAIWorkbench"
  key_facts:
    - "Organized by category: MCP, agents, GIS, tooling, benchmarks"
    - "Every repo has verification status and last-checked date"
    - "Includes both direct dependencies and related projects"
    - "New tools for CodeGen evaluation: Tree-sitter, Parso, VizTracer, coverage.py"
  common_questions:
    - "Where is qgis-mcp?"
    - "Where is GeoAnalystBench?"
    - "Where is the MCP-Bench code?"
    - "What are the current CLI agent repos?"
    - "What Python libraries are used for CodeGen analysis?"
---

# GitHub Repositories — Master List

All GitHub repositories relevant to GeoAIWorkbench, organized by category. Last verified September 2026.

## MCP Ecosystem

### Official
- **MCP Specification:** https://github.com/modelcontextprotocol/specification
- **Python SDK:** https://github.com/modelcontextprotocol/python-sdk (v2.2.0)
- **TypeScript SDK:** https://github.com/modelcontextprotocol/typescript-sdk
- **Servers (reference implementations):** https://github.com/modelcontextprotocol/servers
- **Inspector (debugging tool):** https://github.com/modelcontextprotocol/inspector

### FastMCP
- **Standalone FastMCP:** https://github.com/jlowin/fastmcp (v4.0.3, Apache-2.0)

### MCP Benchmarks
- **MCP-Bench:** https://github.com/Accenture/mcp-bench (Wang et al., 2025)
- **MCPToolBench++:** Search "MCPToolBench" (Fan et al., 2025)
- **LiveMCP-101:** Search "LiveMCP-101" (Yin et al., 2025)
- **LiveMCPBench:** (Mo et al., 2025, KDD) — SUPPORTS PB7
- **MCP-Atlas:** (Bandi et al., 2026)
- **MCP-Universe:** (Luo et al., 2025)
- **MCP Security Bench (MSB):** (Zhang et al., 2025)

### MCP Security
- **Prompt injection studies:** Various in Maloyan & Namiot (2026), Hou et al. (2025)

## CLI Agents

### OpenCode
- **Repo:** https://github.com/opencode-ai/opencode
- **Docs:** https://opencode.ai
- **License:** Open source

### Claude Code
- **Docs (no public repo):** https://docs.anthropic.com/en/docs/claude-code
- **License:** Proprietary

### Codex CLI
- **Repo:** https://github.com/openai/codex
- **Version:** 0.153.3
- **License:** Open source

### Goose
- **Repo:** https://github.com/block/goose
- **Docs:** https://block.github.io/goose/
- **License:** Open source

### Gemini CLI
- **Repo:** https://github.com/google-gemini/gemini-cli
- **Version:** 0.59.0
- **License:** Open source

### Cline
- **Repo:** https://github.com/cline/cline
- **Version:** 3.0.24
- **License:** Apache-2.0

### Aider
- **Repo:** https://github.com/Aider-AI/aider
- **Version:** 0.86.0
- **License:** Apache-2.0
- **Note:** No native MCP; excluded from benchmark

## QGIS Ecosystem

### QGIS Core
- **Main repo:** https://github.com/qgis/QGIS
- **Documentation:** https://github.com/qgis/QGIS-Documentation
- **PyQGIS docs:** https://github.com/qgis/pyqgis

### QGIS Plugins Related to MCP
- **qgis-mcp (nkarasiak):** https://github.com/nkarasiak/qgis-mcp (v0.3.1, 118 tools, GPL-2.0)
  - ⚠️ Exposes `execute_code` — contaminates paradigm boundary
  - Reference implementation for TCP bridge pattern
- **QGIS2OllamaMCP:** Search GitHub "QGIS2OllamaMCP"
  - Smaller tool set; also exposes `execute_code`

### QGIS Plugin Tooling
- **qgis-plugin-ci:** https://github.com/opengisch/qgis-plugin-ci (v2.10.0)
- **pytest-qgis:** https://github.com/GispoCoding/pytest-qgis
- **Plugin Builder 3:** In QGIS Plugin Repository

## Package Management

### Pixi
- **Repo:** https://github.com/prefix-dev/pixi (v0.80.0)
- **setup-pixi (GitHub Action):** https://github.com/prefix-dev/setup-pixi
- **pixi-pack:** https://github.com/Quantco/pixi-pack

### Related
- **uv (not used but referenced):** https://github.com/astral-sh/uv
- **rattler (Pixi's Conda solver):** https://github.com/mamba-org/rattler
- **conda-forge:** https://github.com/conda-forge

## GIS Benchmarks

### GeoAnalystBench
- **Repo:** https://github.com/GeoDS/GeoAnalystBench (Zhang et al., 2025)
- **Primary task source for GeoAIWorkbench**
- **Format:** JSON tasks + Google Drive supplementary data
- ⚠️ **Uses ArcPy, not PyQGIS** — GeoAIWorkbench adapts tasks

### GeoAgentBench
- **Repo:** Search "GeoAgentBench" (Yu et al., 2026)
- **Provides:** PEA metric implementation (if publicly available)

### GeoBenchX
- **Repo:** Search "GeoBenchX" (Krechetova & Kochedykov, 2025)

### ThinkGeo
- **Repo:** Search "ThinkGeo" (Shabbir et al., 2025) — remote sensing focus

### GeoNatureAgent
- **Repo:** Search "GeoNatureAgent" (Díaz-Ireland et al., 2026)

## GIS Agent Systems

### GIS Copilot
- **Repo:** Search "GIS Copilot" (Akinboyewa et al., 2025)
- **QGIS plugin:** May be published on QGIS Plugin Repository

### GISclaw
- **Repo:** Search "GISclaw" (Han et al., 2026)
- **License:** Open source per paper

### GeoColab
- **Repo:** Search "GeoColab" (Wu et al., 2025)
- **Includes:** 8,729 function syntax documents RAG corpus

### GeoJSON Agents
- **Repo:** Search "GeoJSON Agents" (Luo et al., 2026)
- **Key prior work:** Compared function calling vs code generation

### GeoAgent
- **Repo:** Search "GeoAgent" (Chen et al., 2024)

### GeoAgentic-RAG
- **Repo:** Search "GeoAgentic-RAG" (Liang et al., 2026)

## A2A Protocol

### Official
- **Python SDK:** `pip install a2a-sdk`
- **Repos:**
  - https://github.com/google/A2A
  - https://a2aproject.github.io/A2A/

## Python Infrastructure Libraries

Used by GeoAIWorkbench for commodity infrastructure:

### Core
- **Pydantic:** https://github.com/pydantic/pydantic (v2.x)
- **Typer:** https://github.com/tiangolo/typer (v0.12+)
- **Rich:** https://github.com/Textualize/rich (v13+)

### Reliability
- **tenacity:** https://github.com/jd/tenacity (retries)
- **filelock:** https://github.com/tox-dev/filelock

### Caching
- **diskcache:** https://github.com/grantjenks/python-diskcache
- **cachetools:** https://github.com/tkem/cachetools

### Utilities
- **platformdirs:** https://github.com/platformdirs/platformdirs
- **structlog:** https://github.com/hynek/structlog (v26.1)
- **httpx:** https://github.com/encode/httpx

### Data
- **Polars:** https://github.com/pola-rs/polars (v1+)
- **DuckDB:** https://github.com/duckdb/duckdb (v1.1+)

## CodeGen Evaluation Libraries (NEW)

### Code Parsing
- **Tree-sitter:** https://github.com/tree-sitter/tree-sitter
- **tree-sitter-python:** https://github.com/tree-sitter/tree-sitter-python (v0.25)
- **Parso:** https://github.com/davidhalter/parso (v0.8.7)
- **asttokens:** https://github.com/gristlabs/asttokens
- **astroid:** https://github.com/pylint-dev/astroid (v4.3.0)
- **LibCST:** https://github.com/Instagram/LibCST (v1.9.0)

### Runtime Tracing
- **VizTracer:** https://github.com/gaogaotiantian/viztracer (v1.1.1)
- **coverage.py:** https://github.com/nedbat/coveragepy (v7.16.0)

### Code Similarity
- **codebleu:** https://github.com/k4black/codebleu (v0.7.0)

## Evaluation Tooling

### DeepEval
- **Repo:** https://github.com/confident-ai/deepeval (v4.2.2)
- **Includes native MCP metrics**

### Promptfoo
- **Repo:** https://github.com/promptfoo/promptfoo
- **MCP evaluation support**

### MLflow
- **Repo:** https://github.com/mlflow/mlflow (v2.16+)
- **Self-hosted experiment tracking**

## Testing

### pytest ecosystem
- **pytest:** https://github.com/pytest-dev/pytest (v8+)
- **pytest-xdist:** https://github.com/pytest-dev/pytest-xdist
- **pytest-qgis:** https://github.com/GispoCoding/pytest-qgis

## Code Quality

- **Ruff:** https://github.com/astral-sh/ruff (v0.6+)
- **mypy:** https://github.com/python/mypy (v1.11+)

## Spatial Libraries

- **Shapely:** https://github.com/shapely/shapely (v2+)
- **GeoPandas:** https://github.com/geopandas/geopandas (v1+)
- **rasterio:** https://github.com/rasterio/rasterio (v1.4+)
- **pyproj:** https://github.com/pyproj4/pyproj (v3.6+)
- **scikit-image:** https://github.com/scikit-image/scikit-image (v0.24+)

## Statistical

- **scipy:** https://github.com/scipy/scipy (v1.14+)
- **statsmodels:** https://github.com/statsmodels/statsmodels (v0.14+)

## Sandboxing (for CodeGen Runtime)

- **Docker:** https://github.com/docker (primary)
- **nsjail:** https://github.com/google/nsjail (Linux alternative)
- **bubblewrap:** https://github.com/containers/bubblewrap (unprivileged)
- **landlock:** https://github.com/landlock-lsm/python-landlock (defense in depth)

## LaTeX / Thesis

- **wnozigp.sty:** Provided by WIT PWr (not on GitHub)
- **TeX Live:** https://www.tug.org/texlive/ (not GitHub, but reference)

## Repository Health Checks

Before depending on any repo, verify:

1. **Last commit date** — Active within 6 months?
2. **Stars/forks** — Community adoption?
3. **Open issues** — Critical bugs?
4. **License** — Compatible with MIT (GeoAIWorkbench)?
5. **CI status** — Tests passing?
6. **Documentation** — Sufficient for use?

## GeoAIWorkbench Repository

- **Target:** `github.com/<username>/GeoAIWorkbench` (to be created)
- **License:** MIT
- **Contents:**
  - Source code (src/, tests/, benchmark.py)
  - Task suite (tasks/)
  - Reference outputs (data/reference_outputs/)
  - LaTeX thesis (thesis/)
  - Knowledge base (.knowledge/)
  - CI/CD (.github/workflows/)
- **Zenodo archive:** Create with DOI after thesis defense

## Archived / Superseded

- **PydanticAI** — Considered but not used (Pydantic v2 sufficient)
- **LangChain / LangGraph** — Not used (agents are black boxes)
- **Weights & Biases** — Not used (MLflow self-hosted sufficient)
- **RestrictedPython** — Considered for sandboxing but rejected (wrong security boundary for PyQGIS)
- **astor** — Considered for code transformation but rejected (dead project, ast.unparse() replaces it)
- **hunter** — Considered for runtime tracing but rejected (stale since 2022, VizTracer is better)
