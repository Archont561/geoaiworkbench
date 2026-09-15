---
id: KB-11-narrative-arc
title: "Thesis Narrative Arc — 6 Scenes"
category: thesis
subcategory: narrative
tags: [thesis, narrative, story, scenes, arc]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [6]
related:
  - KB-11-thesis-structure
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "6-scene narrative arc for thesis storytelling"
  key_facts:
    - "Scene 1: Problem (GIS analyst needs LLM help)"
    - "Scene 2: Gap (nobody studied this properly)"
    - "Scene 3: Plan (build GeoMCP for fair comparison)"
    - "Scene 4: Surprise (answer depends on difficulty)"
    - "Scene 5: So What (decision table for practitioners)"
    - "Scene 6: Future (open door for more research)"
  common_questions:
    - "What is the thesis story?"
    - "How do chapters connect?"
---

# Thesis Narrative Arc — 6 Scenes

## Scene 1: The Problem (Wstęp + Ch I)

**Hook:** A GIS analyst needs to buffer roads, clip to a study area, and calculate population statistics. They ask an LLM agent for help. Two approaches exist: the agent can call structured tools (MCP) or write Python code (CodeGen). Which works better?

**Tension:** Both approaches seem plausible. Tool calling is structured and safe. Code generation is flexible and powerful. No one knows which is better for real GIS work.

## Scene 2: The Gap (Ch II-III)

**Revelation:** The literature shows many GIS agent systems, but only one comparison study (Luo et al., 2026) — and it used only GeoJSON, only GPT-4o, and a custom framework. Nobody has tested real MCP protocol against code generation in a real GIS environment. Nobody has measured security. Nobody has studied tool count effects.

**Stakes:** Without this comparison, practitioners are choosing blindly.

## Scene 3: The Plan (Ch IV-V)

**Action:** Build GeoMCP — a paradigm-clean MCP server for QGIS with exactly 5 or 15 tools. Design a 1,800-run experiment comparing MCP-5, MCP-15, and CodeGen across 4 agents and 50 tasks. Implement a 7-layer evaluation framework including security.

**Innovation:** First GIS-specific MCP evaluation. First tool count experiment. First security dimension.

## Scene 4: The Surprise (Ch VI)

**Results:** The answer is "it depends." MCP-5 wins on simple structured tasks. CodeGen wins on complex creative tasks. MCP-15 bridges the gap. Security favors MCP. Tool count has measurable effects even at 15 tools.

**Key finding:** The inverted-U curve from Mo et al. (2025) is confirmed in GIS context.

## Scene 5: So What? (Ch VII)

**Practical impact:** A decision table tells practitioners exactly when to use MCP-5, MCP-15, or CodeGen. 8 design principles guide future GIS MCP server development. Security is non-negotiable.

**Theoretical impact:** Protocol-level evaluation framework applicable beyond GIS.

## Scene 6: The Open Door (Wnioski + Ch VII.4)

**Future:** Multi-agent coordination (A2A). Raster operations. Remote sensing. Larger tool counts. User studies. The field is just beginning.

**Final thought:** GeoAIWorkbench provides the foundation. The community builds on it.

## Chapter-to-Scene Mapping

| Chapter | Scene | Emotional Beat |
|---|---|---|
| Wstęp | 1 | Curiosity |
| Ch I | 1 | Context |
| Ch II | 2 | Frustration (gap) |
| Ch III | 2 | Urgency |
| Ch IV | 3 | Confidence |
| Ch V | 3 | Pride (artifact) |
| Ch VI | 4 | Surprise |
| Ch VII | 5-6 | Satisfaction + Hope |

## Related Files

- [KB-11-thesis-structure](thesis-structure.md)
