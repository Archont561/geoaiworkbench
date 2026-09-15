---
id: KB-04-system-architecture
title: "System Architecture Overview"
category: architecture
subcategory: overview
tags: [architecture, overview, packages, components, design]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 7, 15]
related:
  - KB-04-package-qgis-utils
  - KB-04-package-geoaiworkbench
  - KB-04-package-geoaibenchmark
  - KB-04-separate-process-architecture
  - KB-06-file-structure
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "High-level system architecture with 3 packages + benchmark.py + separate MCP process"
  key_facts:
    - "3 Python packages: qgis_utils, geoaiworkbench, geoaibenchmark"
    - "Top-level benchmark.py CLI entry point"
    - "MCP server runs as SEPARATE PROCESS from QGIS"
    - "TCP bridge connects MCP server to QGIS plugin"
    - "Pixi manages all environments"
  common_questions:
    - "What is the overall architecture?"
    - "How many packages?"
    - "Why is the MCP server separate?"
    - "How do components communicate?"
---

# System Architecture Overview

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│  Pixi Environment: "benchmark"                                  │
│  conda-forge: QGIS 3.44, GDAL, GEOS, PROJ, Qt, Python 3.12    │
│  PyPI: FastMCP 4.0.3, Pydantic 2, DeepEval 4.2, Polars        │
│  Lockfile: pixi.lock (committed to Git)                         │
└───────────────────────────┬─────────────────────────────────────┘
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
          ▼                 ▼                 ▼
   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
   │  CLI Agent   │  │  CLI Agent   │  │  CLI Agent   │
   │  OpenCode    │  │  Claude Code │  │  Goose       │
   │  (Codex)     │  │             │  │              │
   └──────┬───────┘  └──────┬───────┘  └──────┬───────┘
          │ stdio           │ stdio           │ stdio
          │ MCP             │ MCP             │ MCP
          ▼                 ▼                 ▼
   ┌─────────────────────────────────────────────────┐
   │  GeoAIWorkbench MCP Server (FastMCP 4.0.3)      │
   │  STANDALONE PROCESS: pixi run mcp-server        │
   │  GEOMCP_TIER=5 or GEOMCP_TIER=15               │
   │  5 or 15 tools, Pydantic v2 validation          │
   │  NO execute_code (paradigm boundary)            │
   │  MCPMonitor hook (benchmark injection)          │
   └────────────────────┬────────────────────────────┘
                        │ TCP localhost:9876
                        │ JSON-RPC bridge protocol
   ┌────────────────────▼────────────────────────────┐
   │  QGIS Bridge Plugin (Qt main thread)            │
   │  pixi run qgis-bridge                           │
   │  Receives validated tool requests               │
   │  Executes via PyQGIS / Processing               │
   │  Returns structured JSON results                │
   │  Workspace scoped to data/ directory            │
   └─────────────────────────────────────────────────┘
```

## Three Packages

### Package 1: `qgis_utils`

**Purpose:** Headless QGIS lifecycle management. No dependency on other packages.

**Key components:**
- `HeadlessIface` — No-op `QgisInterface` stub
- `qgis_app` — Context manager for `QgsApplication` lifecycle
- `resolve_qgis_paths` — Find QGIS installation
- `init_processing` — Initialize Processing framework
- `loaded_plugin` — Context manager for plugin loading

**Dependencies:** PyQGIS only (system QGIS Python)

**See:** [KB-04-package-qgis-utils](package-qgis-utils.md)

### Package 2: `geoaiworkbench`

**Purpose:** QGIS plugin + MCP server + TCP bridge.

**Key components:**
- `models.py` — All Pydantic v2 input/output schemas
- `geo_mcp.py` — FastMCP 4.0.3 server with 5/15 tools
- `bridge.py` — TCP socket bridge to QGIS
- `plugin.py` — QGIS plugin (thin bridge host)
- `acp_client.py` — HookableACPClient (optional)

**Dependencies:** `qgis_utils`, `fastmcp`, `pydantic`

**See:** [KB-04-package-geoaiworkbench](package-geoaiworkbench.md)

### Package 3: `geoaibenchmark`

**Purpose:** Experiment runner, monitors, verifier, analysis.

**Key components:**
- `monitors/` — MCPMonitor, ACPMonitor, CodeGenMonitor
- `benchmark/` — Task schema, OutputVerifier, StepTracker, CodeAnalyzer, QGISIRBuilder
- `runner/` — BenchmarkOrchestrator, ResultStore
- `analysis/` — Metrics computation, statistical tests, reports

**Dependencies:** `pydantic`, `structlog`, `polars`, `scipy`, `shapely`

**No compile-time dependency on `geoaiworkbench`** (uses Protocol-based hook injection)

**See:** [KB-04-package-geoaibenchmark](package-geoaibenchmark.md)

### Entry Point: `benchmark.py`

**Purpose:** Typer CLI with Rich UI.

**Commands:**
- `benchmark.py run` — Execute benchmark
- `benchmark.py analyse` — Compute metrics from JSONL
- `benchmark.py status` — Show progress

**See:** [KB-06-cli-benchmark-py](../06-implementation/cli-benchmark-py.md)

## Communication Patterns

| Connection | Protocol | Transport | Direction |
|---|---|---|---|
| CLI Agent ↔ MCP Server | MCP (JSON-RPC 2.0) | stdio | Bidirectional |
| MCP Server ↔ QGIS Bridge | Custom JSON-RPC | TCP localhost:9876 | Bidirectional |
| Benchmark ↔ MCP Server | Hook injection | In-process (Protocol) | Unidirectional |
| Benchmark ↔ Agent | ACP / subprocess | stdio | Unidirectional |
| Benchmark ↔ Results | JSONL | File system | Append-only |

## Key Architectural Decisions

| Decision | Choice | Rationale | File |
|---|---|---|---|
| MCP server location | Separate process | Avoid asyncio+Qt conflicts | [KB-04-separate-process](separate-process-architecture.md) |
| Bridge protocol | TCP JSON-RPC | Proven by qgis-mcp | [KB-04-bridge-tcp](bridge-tcp-protocol.md) |
| Monitor coupling | Structural Protocol | No compile-time dependency | [KB-04-hook-injection](hook-injection-pattern.md) |
| QGIS threading | QObject + moveToThread | Qt recommended pattern | [KB-04-qt-worker](qt-worker-pattern.md) |
| Result persistence | JSONL + completed.json | Crash-safe, append-only | [KB-04-crash-safe](crash-safe-persistence.md) |
| Paradigm boundary | Assertion + test | Hard invariant | [KB-04-paradigm-boundary](paradigm-boundary.md) |

## Related Files

- [KB-06-file-structure](../06-implementation/file-structure.md) — Complete file tree
- [KB-04-data-flow-diagram](data-flow-diagram.md) — Single task run flow
- [KB-06-pyproject-toml](../06-implementation/pyproject-toml.md) — Pixi config
