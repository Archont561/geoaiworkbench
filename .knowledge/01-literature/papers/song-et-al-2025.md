---
id: KB-01-song-et-al-2025
title: "Song et al. (2025) — Help or Hurdle?"
category: literature
subcategory: paper-summary
tags: [song, mcp, help-or-hurdle, critical-analysis, tool-underuse, KEY-PB7]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14, 15]
related:
  - KB-01-round2-additions
  - KB-00-research-questions
  - KB-01-mo-et-al-2025
authoritative: false
implementation_status: specified
references:
  - song2025helpor
llm_hints:
  primary_purpose: "Critical analysis showing MCP can HURT performance — key theoretical support for PB7"
  key_facts:
    - "MCP does not automatically improve performance"
    - "Models often underuse tools"
    - "Context pollution from tool schemas"
    - "Token overhead per tool call"
    - "Directly supports PB7 hypothesis"
  common_questions:
    - "Does MCP always help?"
    - "What is 'context pollution'?"
    - "Why do models underuse tools?"
---

# Song et al. (2025) — Help or Hurdle? ⭐ SUPPORTS PB7

## Full Citation

Song, W., Zhong, H., Ding, Z., Xue, J., & Li, Y. (2025). Help or Hurdle? Rethinking Model Context Protocol-Augmented Large Language Models. *ArXiv, abs/2508.12566*.

## What This Paper Says

**Critical analysis of MCP** — challenges assumption that MCP automatically improves LLM performance. Identifies specific ways MCP can HURT.

### Four Ways MCP Can Hurt

1. **Tool Underuse**
   - Agent ignores available tools
   - Writes code anyway
   - Wastes MCP infrastructure

2. **Context Pollution**
   - Tool schemas consume context window
   - Displaces task reasoning
   - More tools → less thinking space

3. **Token Overhead**
   - JSON-RPC framing adds ~200-500 tokens per call
   - Adds up over multi-step workflows
   - Cost implications

4. **Over-reliance**
   - Agent calls tools for trivial operations
   - Slower than inline code
   - "When you have a hammer..."

## Key Findings

- MCP is NOT universally beneficial
- Task type dramatically affects whether MCP helps
- Structured tasks benefit; open-ended tasks may not
- Cost-benefit varies by scenario

## Why This Paper Matters ⭐

- **Challenges dominant narrative** that MCP is universally good
- **Provides mechanism explanation** — WHY MCP might hurt
- **Motivates PB7 in GIS context** — is MCP always helpful for GIS?

## Relevance to GeoAIWorkbench

**Very high relevance for PB7 theoretical framing.**

### PB7 Justification

Song et al. + Mo et al. together:
- Mo et al. (2025): Empirical evidence of tool count effect
- **Song et al. (2025): Theoretical explanation of why**

Together they provide complete PB7 motivation.

### Design Implications

Song et al. findings inform GeoMCP design:

1. **Tool Underuse mitigation:** Paradigm boundary (no `execute_code`) forces MCP usage
2. **Context Pollution mitigation:** MCP-5 has minimal schemas; MCP-15 tests threshold
3. **Token Overhead measurement:** Layer 4 tracks Context Window Utilization
4. **Over-reliance measurement:** Compare MCP-15 vs CodeGen on simple tasks

### Hypothesis H7b

**H7b:** MCP-15 < MCP-5 on simple tasks (tool selection overhead).

Song et al. directly supports this — tool schemas consume context, reducing capability for simple tasks.

## Where to Cite

| Chapter | Section | Purpose |
|---|---|---|
| Chapter III | Section 3.6 | **"Help or Hurdle" critical analysis** |
| Chapter III | Section 3.4 | Context pollution mechanism |
| Chapter IV | Section 4.6 | **PB7 theoretical basis** |
| Chapter IV | Section 4.5 | Hypothesis H7b justification |
| Chapter VI | Section 6.6 | PB7 results discussion |
| Chapter VII | Section 7.1 | Decision matrix (when MCP hurts) |

## Related Papers

- Mo et al. (2025) — Empirical complement
- Fan et al. (2026) AAMAS — Formal degradation model

## Key Quote

*"MCP is not universally beneficial: models often underuse tools, misuse retrieved context, or incur substantial token overhead. The paradigm's benefit depends critically on task type and tool design."* — Song et al. (2025)

## BibTeX Key

`song2025helpor`
