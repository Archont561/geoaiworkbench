---
id: KB-04-package-geoaibenchmark
title: "Package: geoaibenchmark"
category: architecture
subcategory: package
tags: [package, geoaibenchmark, monitors, verifier, harness, analysis]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 7, 15]
related:
  - KB-04-system-architecture
  - KB-04-hook-injection-pattern
  - KB-03-metrics-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Experiment runner package: monitors, verifier, harness, analysis"
  key_facts:
    - "No compile-time dependency on geoaiworkbench"
    - "Uses Protocol-based hook injection"
    - "3 monitors: MCP, ACP, CodeGen"
    - "4-layer CodeGen evaluation pipeline"
    - "76 tests (62 unit + 14 integration)"
  common_questions:
    - "What is in geoaibenchmark?"
    - "How does it connect to geoaiworkbench?"
    - "What monitors exist?"
---

# Package: geoaibenchmark

## Purpose

Experiment runner, evaluation pipeline, and analysis toolkit. Completely decoupled from `geoaiworkbench` at compile time.

## Key Design Principle

**No compile-time dependency on `geoaiworkbench`.** Uses Python structural `Protocol` for hook injection. This means:
- `geoaibenchmark` can be tested independently
- Monitors can be swapped without modifying `geoaiworkbench`
- Clean separation of concerns

## Components

### monitors/ — Trajectory Capture

| Monitor | Condition | Captures |
|---|---|---|
| `MCPMonitor` | MCP-5, MCP-15 | Tool calls via hook injection |
| `ACPMonitor` | ACP automation | Agent session events |
| `CodeGenMonitor` | CodeGen | Subprocess executions, stderr |

All monitors produce `MonitorEvent` objects (unified schema).

**See:** [KB-06-monitor-implementation](../06-implementation/monitor-implementation.md)

### benchmark/ — Evaluation Pipeline

| Component | Purpose |
|---|---|
| `task_schema.py` | `BenchmarkTask` Pydantic model |
| `verifier.py` | `OutputVerifier` — spatial output comparison |
| `step_tracker.py` | `StepTracker` — MCP step metrics |
| `code_analyzer.py` | `QGISIRBuilder` — AST-based code analysis |
| `qgis_validator.py` | `QGISValidator` — Processing registry validation |
| `code_extractor.py` | `CodeExtractor` — LLM output → Python code |
| `runtime_tracer.py` | `RuntimeTracer` — Docker execution + monkeypatch |
| `harness.py` | `BenchmarkHarness` — orchestrates single task run |

**See:** [KB-06-harness-implementation](../06-implementation/harness-implementation.md)

### runner/ — Experiment Orchestration

| Component | Purpose |
|---|---|
| `orchestrator.py` | `BenchmarkOrchestrator` — 1,800-run loop |
| `aggregator.py` | Result aggregation across conditions |

**See:** [KB-06-orchestrator-implementation](../06-implementation/orchestrator-implementation.md)

### analysis/ — Metrics and Statistics

| Component | Purpose |
|---|---|
| `metrics.py` | Compute all 7-layer metrics from JSONL |
| `statistics.py` | Statistical tests (ANOVA, McNemar, etc.) |
| `reports.py` | Generate tables and figures |

**See:** [KB-06-metrics-implementation](../06-implementation/metrics-implementation.md)

## File Structure

```
geoaibenchmark/
├── __init__.py
├── monitors/
│   ├── __init__.py
│   ├── protocol.py         # MonitorHook, ACPHook protocols
│   ├── mcp_monitor.py      # MCPMonitor
│   ├── acp_monitor.py      # ACPMonitor
│   └── codegen_monitor.py  # CodeGenMonitor
├── benchmark/
│   ├── __init__.py
│   ├── task_schema.py      # BenchmarkTask
│   ├── verifier.py         # OutputVerifier
│   ├── step_tracker.py     # StepTracker
│   ├── code_analyzer.py    # QGISIRBuilder
│   ├── qgis_validator.py   # QGISValidator
│   ├── code_extractor.py   # CodeExtractor
│   ├── runtime_tracer.py   # RuntimeTracer
│   └── harness.py          # BenchmarkHarness
├── runner/
│   ├── __init__.py
│   ├── orchestrator.py     # BenchmarkOrchestrator
│   └── aggregator.py       # ResultAggregator
└── analysis/
    ├── __init__.py
    ├── metrics.py          # compute_metrics
    ├── statistics.py       # statistical tests
    └── reports.py          # save_results, print_summary
```

## Dependencies

```
geoaibenchmark → pydantic >= 2.0
geoaibenchmark → structlog (logging)
geoaibenchmark → polars (data analysis)
geoaibenchmark → scipy (statistics)
geoaibenchmark → shapely (geometry)
geoaibenchmark → geopandas (vector comparison)
geoaibenchmark → rasterio (raster comparison)
geoaibenchmark → tenacity (retries)
geoaibenchmark → filelock (concurrency)
geoaibenchmark → tree-sitter-python (code parsing)
geoaibenchmark → parso (error recovery parsing)
```

**NOT dependent on:** `geoaiworkbench`, `qgis_utils`, `fastmcp`

## Testing

76 tests (62 unit + 14 integration):
- Monitor event creation
- OutputVerifier accuracy
- StepTracker metrics
- CodeAnalyzer IR extraction
- Statistical test correctness
- Orchestrator crash recovery

## Related Files

- [KB-04-hook-injection-pattern](hook-injection-pattern.md) — Protocol coupling
- [KB-03-metrics-overview](../03-metrics/metrics-overview.md) — Metrics computed
- [KB-02-final-research-design](../02-research-design/final-research-design.md) — Experiment design
