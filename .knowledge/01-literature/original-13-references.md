---
id: KB-01-original-13-references
title: "Round 0: Original 13 References"
category: literature
subcategory: round-zero
tags: [round0, bibliography, foundational, references]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1]
related:
  - KB-01-bibliography-overview
  - KB-01-round1-additions
  - KB-01-round2-additions
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Complete listing of the 13 initial bibliography references"
  key_facts:
    - "13 references from manual literature review"
    - "Categories: foundational, systems, benchmarks, protocols, methodology"
    - "Provided as starting point for the thesis"
  common_questions:
    - "What were the initial references?"
    - "Which papers came from Round 0?"
    - "What is the manual review baseline?"
---

# Round 0: Original 13 References

These 13 references were provided at the start of the project as the initial bibliography for GeoAIWorkbench.

## Category Breakdown

| # | Category | Count | References |
|---|---|---|---|
| 1 | Foundational | 2 | Li & Ning (2023), Li et al. (2025) |
| 2 | GIS Agent Systems | 4 | Han et al. (2026), Akinboyewa et al. (2025), Wu et al. (2025), Ning et al. (2025) |
| 3 | Comparison Study | 1 | Luo et al. (2026) |
| 4 | Benchmarks | 2 | Zhang et al. (2025), Yu et al. (2026) |
| 5 | Methodology | 1 | Peffers et al. (2007) |
| 6 | Protocols | 2 | MCP spec, ACP spec |
| 7 | Theoretical Framework | 1 | Strickland et al. (2026) |

## Complete Listing

### 1. Li, Z., & Ning, H. (2023)
**Title:** Autonomous GIS: the next-generation AI-powered GIS
**Type:** Foundational paper
**Key contribution:** Introduced concept of Autonomous GIS with 5 autonomy goals (self-generating, self-organizing, self-verifying, self-executing, self-growing). Prototype: LLM-Geo built on GPT-4.
**File:** [KB-01-li-ning-2023](papers/li-ning-2023.md)

### 2. Li, Z., et al. (2025)
**Title:** Autonomous GIS: research agenda for the next decade
**Type:** Research agenda
**Key contribution:** Full agenda with 5 autonomy levels, 5 core functions, 3 operational scales. Raised societal responsibility concerns.
**File:** [KB-01-li-et-al-2025](papers/li-et-al-2025.md)

### 3. Han, J., et al. (2026)
**Title:** GISclaw: Open-source LLM Agent for Realistic Multi-Step Geospatial Analysis
**Type:** GIS agent system
**Key contribution:** Open-source full-stack GIS agent. Dual Agent architecture degrades strong models. 6 LLM backends tested. Up to 96% task success on GeoAnalystBench.
**File:** [KB-01-han-et-al-2026](papers/han-et-al-2026.md)

### 4. Akinboyewa, T., et al. (2025)
**Title:** GIS Copilot: towards an autonomous GIS agent for spatial analysis
**Type:** GIS agent system
**Key contribution:** LLM reasoning embedded in QGIS. High success on basic/intermediate tasks, challenges with advanced tasks. Code generation only.
**File:** [KB-01-akinboyewa-et-al-2025](papers/akinboyewa-et-al-2025.md)

### 5. Wu, H., et al. (2025)
**Title:** GeoColab: LLM-based multi-agent collaborative framework for geospatial code generation
**Type:** GIS agent system
**Key contribution:** Multi-agent framework with RAG using 8,729 function syntax documents. Improves code quality 7.59%-26.09%.
**File:** [KB-01-wu-et-al-2025](papers/wu-et-al-2025.md)

### 6. Luo, Q., et al. (2026)
**Title:** GeoJSON agents: multi-agent LLM architecture for geospatial analysis — function calling vs. code generation
**Type:** Comparison study ⭐ **KEY PRIOR WORK**
**Key contribution:** ONLY prior systematic comparison of function calling (85.71%) vs code generation (97.14%). Only GPT-4o, only GeoJSON.
**File:** [KB-01-luo-et-al-2026](papers/luo-et-al-2026.md)

### 7. Ning, H., et al. (2025)
**Title:** Autonomous GIS agent for geospatial data retrieval
**Type:** GIS agent system
**Key contribution:** Framework for autonomous data retrieval from OpenStreetMap, US Census Bureau, OpenTopography.
**File:** [KB-01-ning-et-al-2025](papers/ning-et-al-2025.md)

### 8. Zhang, Q., et al. (2025)
**Title:** GeoAnalystBench: A GeoAI Benchmark for Assessing LLMs for Spatial Analysis Workflow and Code Generation
**Type:** Benchmark ⭐ **PRIMARY TASK SOURCE**
**Key contribution:** 50 Python-based expert-validated tasks. Workflow validity, structural alignment, semantic similarity, CodeBLEU metrics. Note: uses ArcPy, not PyQGIS.
**File:** [KB-01-zhang-et-al-2025](papers/zhang-et-al-2025.md)

### 9. Yu, B., et al. (2026)
**Title:** GeoAgentBench: A Dynamic Execution Benchmark for Tool-Augmented Agents in Spatial Analysis
**Type:** Benchmark
**Key contribution:** 117 atomic GIS tools, 53 tasks, PEA metric (used by GeoAIWorkbench), Plan-and-React architecture.
**File:** [KB-01-yu-et-al-2026](papers/yu-et-al-2026.md)

### 10. Peffers, K., et al. (2007)
**Title:** A Design Science Research Methodology for Information Systems Research
**Type:** Methodology
**Key contribution:** 6-step DSRM: problem identification → objectives → design → demonstration → evaluation → communication. Framework for GeoMCP artifact.
**File:** [KB-01-peffers-et-al-2007](papers/peffers-et-al-2007.md)

### 11. Model Context Protocol Specification (Anthropic)
**Type:** Protocol documentation
**Key contribution:** Open JSON-RPC 2.0 standard for LLM-tool integration.
**File:** [KB-01-mcp-spec](papers/mcp-spec.md)

### 12. Agent Client Protocol Specification
**Type:** Protocol documentation
**Key contribution:** JSON-RPC over stdio for editor↔agent communication. NOTE: Distinct from A2A.
**File:** [KB-01-acp-spec](papers/acp-spec.md)

### 13. Strickland, K., et al. (2026)
**Title:** Execution Determinism vs Conversational Flexibility Pareto Front
**Type:** Theoretical framework
**Key contribution:** Empirical Pareto front between ED and CF. No reviewed system achieves both. Proposes schema-gated orchestration.
**File:** [KB-01-strickland-et-al-2026](papers/strickland-et-al-2026.md)

## Gap Analysis (Round 0)

From these 13 references, 10 research gaps were identified. See [KB-01-research-gaps](research-gaps.md).

## Why More References Were Added

Round 0 revealed:
- Only 1 comparison of MCP tool calling vs code generation (Luo et al. 2026), and it was limited to GeoJSON
- No paper measured MCP-specific security threats in GIS
- No paper studied MCP tool count effects
- Need for more benchmarks to validate methodology

This motivated Rounds 1 and 2 via Consensus AI search. See [KB-01-round1-additions](round1-additions.md) and [KB-01-round2-additions](round2-additions.md).
