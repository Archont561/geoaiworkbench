---
id: KB-07-tools-to-avoid
title: "Tools Explicitly Avoided"
category: tooling
subcategory: exclusions
tags: [tools, avoid, exclusions, rationale]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-07-toolchain-overview
  - KB-07-dependencies-rationale
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Tools considered and rejected with rationale"
  key_facts:
    - "uv: can't install QGIS natively"
    - "LangChain: agents are black boxes"
    - "RestrictedPython: wrong security boundary"
    - "pandas: Polars is faster for JSONL"
    - "W&B: MLflow self-hosted sufficient"
  common_questions:
    - "Why not use uv?"
    - "Why not LangChain?"
    - "Why not pandas?"
---

# Tools Explicitly Avoided

| Tool | Considered For | Rejected Because | Replacement |
|---|---|---|---|
| **uv** | Package management | Cannot install QGIS/GDAL/GEOS/PROJ natively | Pixi (Conda + PyPI) |
| **LangChain / LlamaIndex** | Agent framework | Agents are black boxes; we don't build agent internals | None needed |
| **Weights & Biases** | Experiment tracking | Requires cloud account; overkill for 1,800 runs | MLflow (self-hosted) |
| **DVC** | Data versioning | Overkill for 50 task files; Git LFS simpler | Git LFS |
| **Jupyter** | Interactive analysis | Benchmark is CLI pipeline, not notebook | Typer CLI |
| **Sphinx / MkDocs** | API documentation | No public API; README.md sufficient | None |
| **Airflow / Prefect** | Workflow orchestration | 1,800 runs is a loop, not a DAG | Typer + JSONL |
| **Terraform / Ansible** | Infrastructure | Single-machine benchmark | None |
| **Kubernetes** | Container orchestration | See above | Docker (single) |
| **RestrictedPython** | Code sandboxing | Wrong security boundary for PyQGIS C++ extensions | Docker + seccomp |
| **astor** | Code transformation | Dead project (last release 2019) | ast.unparse() |
| **hunter** | Runtime tracing | Stale (last release 2022) | VizTracer |
| **loguru** | Logging | Less structured than structlog for JSONL | structlog |
| **astroid** | Code inference | PyQGIS inference unreliable (C++ extensions) | ast + tree-sitter |
| **libcst** | Concrete syntax tree | Not designed for error recovery | tree-sitter + parso |
| **firejail** | Sandboxing | SUID mode less secure than containers | Docker |
| **PydanticAI** | Agent framework | Pydantic v2 sufficient for schemas | Pydantic v2 |
| **orjson** | Fast JSON | stdlib json adequate until profiling says otherwise | stdlib json |
| **msgspec** | Serialization | Premature optimization | Pydantic v2 |
| **SQLAlchemy** | Database ORM | DuckDB queries JSONL directly | DuckDB |

## Related Files

- [KB-07-toolchain-overview](toolchain-overview.md)
- [KB-07-dependencies-rationale](dependencies-rationale.md)
