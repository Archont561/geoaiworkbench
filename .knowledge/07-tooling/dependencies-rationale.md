---
id: KB-07-dependencies-rationale
title: "Dependencies Rationale"
category: tooling
subcategory: rationale
tags: [dependencies, rationale, why, packages]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-07-toolchain-overview
  - KB-06-pyproject-toml
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Why each dependency was chosen"
  key_facts:
    - "Novel GIS/MCP/benchmark logic in our code"
    - "Commodity infrastructure from mature libraries"
    - "Every package solves a specific problem"
    - "No premature optimization"
  common_questions:
    - "Why this package?"
    - "What problem does X solve?"
---

# Dependencies Rationale

## Core Principle

> "GeoAIWorkbench should contain the genuinely novel QGIS/MCP/benchmark logic; commodity infrastructure should come from mature libraries."

## Package Rationale Table

| Package | Problem Solved | Why Not Alternative |
|---|---|---|
| **fastmcp** | MCP server framework | mcp SDK v2 changed API; fastmcp stable |
| **pydantic** | Data validation + schemas | dataclasses lack validation; Pydantic v2 is 10x faster |
| **structlog** | Structured JSON logging | stdlib logging lacks JSON; loguru less structured |
| **diskcache** | Persistent caching | Custom cache.py = reinventing wheel |
| **platformdirs** | App directory paths | Hardcoded paths break cross-platform |
| **tenacity** | Retry with backoff | Custom for loops = fragile |
| **filelock** | File locking | Custom lock files = race conditions |
| **httpx** | HTTP client (sync+async) | requests lacks async; aiohttp is async-only |
| **polars** | DataFrame analysis | pandas slower, no native JSONL |
| **duckdb** | SQL queries on JSONL | SQLite requires import step |
| **tree-sitter** | Error-recovery parsing | ast.parse fails on broken code |
| **parso** | Python error recovery | Complements tree-sitter |
| **typer** | CLI framework | argparse verbose; click heavier |
| **rich** | Terminal UI | print() insufficient for 1,800 runs |
| **scipy** | Statistical tests | Standard scientific Python |
| **statsmodels** | ANOVA, regression | scipy lacks full ANOVA |
| **deepeval** | MCP evaluation metrics | Has native MCP Use metric |
| **coverage** | Line execution tracking | Standard Python coverage |
| **viztracer** | Execution tracing | hunter stale since 2022 |

## What We Don't Include

See [KB-07-tools-to-avoid](tools-to-avoid.md) for detailed exclusion rationale.

## Related Files

- [KB-07-tools-to-avoid](tools-to-avoid.md)
- [KB-06-pyproject-toml](../06-implementation/pyproject-toml.md)
