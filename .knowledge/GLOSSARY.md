---
id: KB-GLOSSARY
title: "Glossary of Acronyms and Terms"
category: meta
subcategory: reference
tags: [glossary, acronyms, terminology, reference]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-README
  - KB-00-glossary-terms
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Quick reference for all acronyms and technical terms used in the project"
  key_facts:
    - "Organized alphabetically"
    - "Includes definition, context, and cross-references"
    - "Distinguishes MCP, ACP, and A2A protocols carefully"
    - "MCP-5 and MCP-15 refer to tool count variants"
  common_questions:
    - "What does PEA stand for?"
    - "What is the difference between ACP and A2A?"
    - "What is CF vs ED?"
    - "What is MCP-15?"
---

# Glossary

Quick reference for all acronyms and technical terms used in GeoAIWorkbench.

## A

**A2A** — Agent-to-Agent Protocol. Standardized horizontal communication between autonomous agents. Formerly separate from ACP; ACP merged into A2A in August 2025, both now governed by AAIF. Distinct from MCP (which is agent-to-tools). See [KB-00-glossary-terms](00-meta/glossary-terms.md).

**AAIF** — Agent-to-Agent Interoperability Foundation. Governance body for the A2A protocol post-merger.

**ACP** — Agent Client Protocol. JSON-RPC over stdio for editor ↔ coding-agent communication (e.g., `opencode acp`, VS Code ↔ Cline). **Not the same as A2A.** Confusion between ACP and A2A is a known source of errors.

**ADV-01 to ADV-05** — Adversarial task series designed to test MCP server resistance to prompt injection, malicious inputs, and data exfiltration attempts.

## B

**Black box constraint** — Agents are treated as replaceable black boxes. Only MCP server logs and GIS output files are observed. No agent internals are instrumented. Ensures fair, reproducible, vendor-neutral evaluation.

**BYOM** — Bring Your Own Model. Ability to configure an agent to use a user-supplied LLM (e.g., local Ollama, Azure OpenAI). Goose supports BYOM broadly; Claude Code and Codex do not.

## C

**CF** — Conversational Flexibility. Metric from Strickland et al. (2026) measuring an agent's ability to handle open-ended, multi-turn dialogue. Trades off against ED.

**CLI Agent** — Command-line LLM agent (OpenCode, Claude Code, Codex CLI, Goose, Gemini CLI). Used as black boxes in GeoAIWorkbench evaluation.

**CodeGen** — Code generation paradigm. Agent writes and executes PyQGIS code directly, with no MCP tools available. Third experimental condition in the 3-condition design.

**Completion Rate** — Metric: fraction of tasks where the agent produced some output (even if incorrect).

## D

**DeepEval** — Python evaluation framework (v4.2.2) with native MCP metrics: MCP Use, MCP Task Completion, Tool Correctness, Argument Correctness.

**DSRM** — Design Science Research Methodology (Peffers et al., 2007). Six-step methodology: problem identification → objectives → design → demonstration → evaluation → communication. Framework for the GeoMCP artifact.

**DuckDB** — In-process SQL engine used to query JSONL benchmark results directly without a separate database.

## E

**ED** — Execution Determinism. Metric from Strickland et al. (2026) measuring consistency of agent behavior across repeated runs. Trades off against CF.

**EPSG** — European Petroleum Survey Group. Numeric identifier for coordinate reference systems (e.g., EPSG:4326 = WGS 84).

## F

**FastMCP** — Python framework for building MCP servers. Standalone package `fastmcp` (v4.0.3), separate from the official `mcp` SDK v2. Uses `@mcp.tool` decorator (no parens).

## G

**GeoAgentBench** — Dynamic execution benchmark (Yu et al., 2026) with 117 atomic GIS tools, 53 tasks, PEA metric, Plan-and-React architecture.

**GeoAnalystBench** — Static code-quality benchmark (Zhang et al., 2025) with 50 expert-validated Python geoprocessing tasks. Primary task source for GeoAIWorkbench. **Note:** Uses ArcPy, not PyQGIS — GeoAIWorkbench adapts tasks to QGIS.

**GEOMCP_TIER** — Environment variable controlling which MCP tools are exposed. `GEOMCP_TIER=5` exposes MCP-5 (Tier 1-2). `GEOMCP_TIER=15` exposes MCP-15 (Tier 1-5).

**GeoMCP** — The custom QGIS MCP plugin built as the GeoAIWorkbench artifact. Exposes 5 tools (MCP-5) or 15 tools (MCP-15) organized in tiers. Paradigm boundary enforced (no `execute_code`).

**GISclaw** — Open-source full-stack GIS agent (Han et al., 2026) with Dual Agent architecture.

## H

**HeadlessIface** — No-op `QgisInterface` stub in `qgis_utils` package. Enables running QGIS operations without GUI.

## I

**ITS** — Iterations to Success. Metric: number of execution attempts until first passing output (∞ if never passes).

**Inverted-U curve** — Observed relationship between MCP tool count and performance. Too few tools = insufficient capability. Too many tools = tool selection degradation (Mo et al., 2025). Sweet spot around 15-30 tools.

## J

**JSONL** — JSON Lines. Newline-delimited JSON format used for crash-safe result persistence. Every trajectory event and task result written as one line.

## L

**LCP** — Longest Correct Prefix. Metric: length of the correct initial sequence of steps in a workflow before the first error.

**LLM-Geo** — Prototype autonomous GIS system from Li & Ning (2023), built on GPT-4. Foundational paper for the field.

## M

**MCP** — Model Context Protocol. Open JSON-RPC 2.0 standard from Anthropic for LLM-tool integration. Standardizes tool discovery, invocation, and schema. Distinct from ACP and A2A.

**MCP-5** — First experimental condition. GeoMCP exposes exactly 5 tools (Tier 1-2): `layer_info`, `layer_statistics`, `buffer`, `clip`, `reproject`. Paradigm-clean baseline.

**MCP-15** — Second experimental condition. GeoMCP exposes 15 tools (Tier 1-5) adding: `dissolve`, `intersection`, `difference`, `union`, `spatial_join`, `select_by_location`, `centroid`, `simplify`, `merge_layers`, `calculate_field`. Realistic GIS toolkit.

**MCP Inspector** — Official Anthropic debugging tool for MCP servers. Run via `npx @modelcontextprotocol/inspector`.

**McNemar test** — Statistical test for paired binary outcomes. Used in GeoAIWorkbench for paradigm comparison on Task Success Rate (PB1).

**MLflow** — Experiment tracking framework. Self-hosted, used for benchmark run metadata (not agent tracing).

**MonitorEvent** — Unified Pydantic schema for MCP tool calls and ACP agent requests. Captures timestamp, tool name, parameters, result, duration, error type.

## O

**OQS** — Output Quality Score. Composite metric combining geometry validity, feature count match, CRS match, extent IoU, and attribute preservation.

## P

**Paradigm Boundary** — Hard invariant that MCP conditions expose only Tier 1-5 tools and no code execution capability. Enforced by assertion at decoration time and dedicated test.

**Pass@1 / Pass@3** — Metrics: fraction of tasks passed on first attempt / at least one of three attempts.

**PB1-PB7** — Research questions (Polish: "Pytanie Badawcze"). PB1 = success rate, PB2 = difficulty moderation, PB3 = agent-paradigm interaction, PB4 = execution behavior, PB5 = security, PB6 = information fidelity (optional), PB7 = tool count effect (MCP-5 vs MCP-15).

**PCS** — Partial Credit Score. Weighted metric for complex tasks. Weights: data_loading=1.0, data_preparation=1.5, spatial_analysis=3.0, spatial_reasoning=4.0, output=2.0.

**PEA** — Parameter Execution Accuracy. Metric from Yu et al. (2026): (correctly inferred parameters) / (total required parameters).

**Pixi** — Package manager (Rust-based, v0.80.0) that unifies Conda + PyPI dependencies in one lockfile. Replaces uv for GeoAIWorkbench because it handles native QGIS/GDAL/GEOS/PROJ dependencies.

**Polars** — Rust-based dataframe library. Used instead of pandas for benchmark analysis.

**PyQGIS** — Python bindings for QGIS. Used inside the MCP server to execute Processing algorithms.

## Q

**QGIS** — Open-source Geographic Information System. Version 3.44.x used. Provides the Processing framework and PyQGIS.

**QGIS Workflow IR** — Intermediate representation of parsed PyQGIS code. Structured dataclass containing algorithm sequence, parameters, layer operations. Used for CodeGen static analysis.

**QGISToolMCP** — Existing community MCP server for QGIS (nkarasiak/qgis-mcp, v0.3.1, 118 tools). **Contaminated** by `execute_code` tool — cannot be used as clean tool-only baseline.

**qgis_process** — QGIS CLI tool for headless Processing algorithm execution.

## R

**RR** — Rejection Rate. Metric: fraction of tasks where agent refused or declared unsolvable.

## S

**SCR** — Step Completion Rate. Metric: fraction of required task steps that were successfully completed.

**SHR** — Self-Healing Ratio. Metric: (tasks that failed on first attempt but succeeded after retry) / (tasks that failed on first attempt).

**SSIM** — Structural Similarity Index Measure. Metric for cartographic output quality comparison.

**structlog** — Structured logging library. Emits JSON events for benchmark trajectories.

## T

**TCP Bridge** — Localhost socket connection between the standalone MCP server process and the QGIS plugin. Enables the "separate process" architecture that avoids asyncio-vs-Qt event loop conflicts.

**tenacity** — Retry library. Used for agent startup, bridge connections, transient errors.

**Tier 1-5** — MCP tool organization:
- Tier 1: Inspection (2 tools)
- Tier 2: Core Geoprocessing (3 tools)
- Tier 3: Extended Geoprocessing (6 tools)
- Tier 4: Geometry Operations (2 tools)
- Tier 5: Data Management (2 tools)

MCP-5 = Tier 1-2 (5 tools). MCP-15 = Tier 1-5 (15 tools).

**Tool Selection Accuracy** — Metric: fraction of times the agent selected the correct tool for the operation. Expected to degrade from MCP-5 to MCP-15 based on Mo et al. (2025).

**Tree-sitter** — Multi-language incremental parser. Used for error-recovery parsing of LLM-generated Python code in CodeGen evaluation.

**TSR** — Task Success Rate. Primary metric: fraction of tasks passed. Same as Pass@1 for single-attempt evaluation.

**Typer** — Modern CLI framework built on Click. Used for `benchmark.py`.

## U

**uv** — Rust-based Python package manager. **Not used** in GeoAIWorkbench — replaced by Pixi because uv cannot install QGIS/GDAL natively.

## V

**VizTracer** — Python execution tracer used for CodeGen runtime instrumentation. Captures function calls, arguments, execution order.

## W

**wnozigp.sty** — LaTeX style package for WIT PWr thesis format. Times New Roman, 1.5 line spacing, 3.5cm left margin.

**Workflow Validity** — Metric: whether the sequence of operations produces a semantically valid geoprocessing workflow.
