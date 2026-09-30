---
id: KB-02-design-evolution
title: "Research Design Evolution"
category: research-design
subcategory: history
tags: [design, evolution, stages, decisions, history]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [2, 15]
related:
  - KB-02-final-research-design
  - KB-CHANGELOG
  - backlog-decision-register
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Chronological evolution of the research design from initial idea to final 3-condition experiment"
  key_facts:
    - "5 stages of idea evolution"
    - "Initial idea rejected (already done by Luo et al.)"
    - "MCP + ACP angle identified as novel"
    - "Real CLI agents chosen over custom"
    - "QGIS chosen as execution environment"
    - "Custom GeoMCP plugin chosen over existing qgis-mcp"
    - "Tool count expansion (MCP-5 → MCP-5 + MCP-15)"
  common_questions:
    - "How did the design evolve?"
    - "Why was the initial idea rejected?"
    - "Why build custom GeoMCP?"
---

# Research Design Evolution

Chronological evolution of the GeoAIWorkbench research design from initial idea to final 3-condition experiment.

## Stage 1: Initial Idea — Rejected

**Proposed:** Compare function calling vs code generation for GIS tasks.

**Rejected because:** Luo et al. (2026) already did this with GeoJSON Agents (97.14% vs 85.71%). Would not be novel without differentiation.

**Four differentiation angles suggested:**
1. Broader data type coverage (not just GeoJSON)
2. Multi-model comparison (not just GPT-4o)
3. Dynamic execution evaluation (not just static CodeBLEU)
4. ED/CF theoretical framing from Strickland et al. (2026)

## Stage 2: Adding MCP and ACP Protocols — Novel Angle

**Proposed:** Include MCP and ACP as the integration layer.

**Accepted because:** No GIS paper had empirically studied MCP-based tool integration vs code generation. Genuinely novel.

**Important protocol update discovered:**
- ACP merged into A2A in August 2025
- Both now governed by AAIF
- Three-layer stack: MCP (tools), A2A (agents), Streamable HTTP (transport)
- OpenCode's `opencode acp` uses Agent Client Protocol (editor-agent), NOT A2A

## Stage 3: Using Real CLI Agents — Practical Grounding

**Proposed:** Test production CLI agents instead of building custom architectures.

**Accepted because:**
- More realistic than custom agents
- Reproducible (anyone can install same CLI)
- Black-box evaluation is fairer
- Avoids architecture confounds

**Agent ecosystem identified:**
- Claude Code, Codex CLI, Goose (Block, Apache 2.0), Gemini CLI, OpenCode
- Important constraint: Claude Code and Codex do not support BYOM

## Stage 4: QGIS as Execution Environment

**Proposed:** Use QGIS as unified execution environment.

**Accepted because:**
- Most widely used open-source GIS
- QGISToolMCP already exists (proves demand)
- PyQGIS handles code generation condition
- Real-world relevance

**Key challenge identified:** Existing qgis-mcp servers expose `execute_code` tool which contaminates paradigm comparison.

## Stage 5: Custom GeoMCP Plugin as Artifact — Core Decision

**Proposed:** Build custom QGIS MCP plugin that deliberately excludes code execution tools.

**Accepted because:** This is the most important design decision:
- Existing servers blur paradigm boundary via `execute_code`
- Building own plugin gives full experimental control
- Produces reusable community artifact
- Satisfies Peffers et al. DSRM
- Differentiates clearly from GIS Copilot (code gen only)

## Stage 6: Tool Count Expansion (2026-09-11)

**Proposed:** Add MCP-15 as second experimental condition alongside MCP-5.

**Accepted because:**
- Literature evidence from Mo et al. (2025), Song et al. (2025) supports tool count as experimental variable
- Turns "5 tools is unrealistically limited" from limitation to research contribution
- Tests inverted-U hypothesis in GIS context for the first time
- Feasible via `GEOMCP_TIER` environment variable (no code duplication)

**Result:** 2-condition → 3-condition experiment (MCP-5, MCP-15, CodeGen)

## Final Design Summary

| Aspect | Final Decision |
|---|---|
| Paradigms | 3 (MCP-5, MCP-15, CodeGen) |
| Agents | 4 CLI (OpenCode, Claude Code, Codex, Goose) |
| Tasks | 50 GeoAnalystBench + 5 adversarial |
| Repetitions | 3 per condition |
| Total runs | 1,800 |
| Environment | QGIS 3.44.x via Pixi |
| MCP server | Custom GeoMCP (FastMCP 4.0.3) |
| Architecture | Standalone MCP process + TCP bridge |
| Evaluation | 7-layer metrics framework |
| Methodology | DSRM (Peffers et al., 2007) |

## Related Files

- [KB-02-final-research-design](final-research-design.md) — Complete design specification
- [KB-CHANGELOG](../CHANGELOG.md) — Detailed decision log
- the backlog decision register (`backlog decision list`) — Decision table
