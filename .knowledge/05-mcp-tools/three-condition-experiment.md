---
id: KB-05-three-condition-experiment
title: "Three-Condition Experiment Design for Tool Specs"
category: mcp-tools
subcategory: experiment
tags: [experiment, mcp-5, mcp-15, codegen, conditions, tool-count]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [15]
related:
  - KB-05-tool-spec-overview
  - KB-02-final-research-design
  - KB-00-research-questions
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "How the 3 experimental conditions relate to tool specifications"
  key_facts:
    - "MCP-5: 5 tools, maximum paradigm contrast"
    - "MCP-15: 15 tools, realistic GIS toolkit"
    - "CodeGen: unlimited, upper bound"
    - "Same server code, different GEOMCP_TIER"
    - "Tests inverted-U hypothesis (PB7)"
  common_questions:
    - "How do the 3 conditions differ in tools?"
    - "Why 5 and 15 specifically?"
    - "What does CodeGen have that MCP doesn't?"
---

# Three-Condition Experiment Design for Tool Specs

## Condition Comparison

| Aspect | MCP-5 | MCP-15 | CodeGen |
|---|---|---|---|
| Tool count | 5 | 15 | ∞ |
| Tiers | 1-2 | 1-5 | N/A |
| Schema tokens | ~400 | ~1200 | 0 |
| Parameter validation | Pydantic | Pydantic | None (runtime only) |
| Tool selection | Constrained | Moderate | Free-form |
| Algorithm access | 5 specific | 15 specific | All Processing |
| Code execution | ❌ | ❌ | ✅ |
| Error feedback | MCP error codes | MCP error codes | stderr |
| Self-healing | Retry tool call | Retry tool call | Fix code + re-run |

## Why 5 and 15?

### MCP-5 (Tier 1-2)
- **Minimum viable GIS toolkit** — buffer, clip, reproject cover most basic tasks
- **Maximum paradigm contrast** with CodeGen
- **Below Mo et al. degradation threshold** (~50 tools)
- **Minimal context overhead** (~550 tokens)
- **Hypothesis:** Highest ED, lowest flexibility

### MCP-15 (Tier 1-5)
- **Realistic GIS toolkit** — covers most GeoAnalystBench tasks
- **Still below degradation threshold** but tests early effects
- **Includes overlay operations** needed for advanced tasks
- **Moderate context overhead** (~1450 tokens)
- **Hypothesis:** Better on advanced tasks, slight ED decrease

### CodeGen (Unlimited)
- **Upper bound** — agent can use any QGIS Processing algorithm
- **Maximum flexibility** — can write custom logic
- **No schema overhead** — full context for reasoning
- **Hypothesis:** Best on complex tasks, lowest ED, highest SHR

## Inverted-U Prediction

```
Performance
    │
    │         MCP-15
    │        ╱      ╲
    │  MCP-5╱        ╲ CodeGen
    │      ╱          ╲  (flexibility
    │     ╱            ╲  but errors)
    │    ╱              ╲
    └──────────────────────────
     5    15    50   100   ∞
              Tool Count
```

**PB7 tests the left side of this curve** (5 vs 15).

## Task-Tier Mapping

| Task Difficulty | MCP-5 Sufficient? | MCP-15 Sufficient? | CodeGen Advantage? |
|---|---|---|---|
| Basic (buffer, clip) | ✅ Yes | ✅ Yes | Minimal |
| Intermediate (buffer+clip) | ⚠️ Partial | ✅ Yes | Small |
| Advanced (overlay+join) | ❌ No | ✅ Yes | Moderate |
| Complex (custom logic) | ❌ No | ⚠️ Partial | Large |

## Related Files

- [KB-02-final-research-design](../02-research-design/final-research-design.md) — Full factorial
- [KB-02-hypotheses](../02-research-design/hypotheses.md) — H7a-H7e
- [KB-01-mo-et-al-2025](../01-literature/papers/mo-et-al-2025.md) — Degradation evidence
