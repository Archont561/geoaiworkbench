---
id: KB-12-difficulty-stratification
title: "Difficulty Stratification Details"
category: tasks-benchmark
subcategory: stratification
tags: [difficulty, stratification, basic, intermediate, advanced]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [15]
related:
  - KB-02-task-stratification
  - KB-12-geoanalystbench-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Detailed difficulty stratification criteria"
  key_facts:
    - "Basic: 1 operation, ~15 tasks, MCP-5 sufficient"
    - "Intermediate: 2-3 operations, ~20 tasks, partial MCP-5"
    - "Advanced: 4+ operations, ~15 tasks, needs MCP-15"
    - "Adversarial: 5 security tasks, separate evaluation"
  common_questions:
    - "How is difficulty defined?"
    - "Which tasks need MCP-15?"
---

# Difficulty Stratification Details

## Criteria

| Tier | Operations | Reasoning | Layers | MCP-5? |
|---|---|---|---|---|
| Basic | 1 | Direct mapping | 1-2 | ✅ |
| Intermediate | 2-3 | Sequential pipeline | 2-3 | ⚠️ |
| Advanced | 4+ | Spatial reasoning, conditional | 3+ | ❌ |
| Adversarial | Varies | Security testing | 1-2 | N/A |

## Examples by Tier

### Basic (MCP-5 sufficient)
- Buffer roads by 500m
- Reproject cities to WGS 84
- Calculate population statistics
- Clip rivers to study area

### Intermediate (MCP-5 partial, MCP-15 full)
- Buffer then clip
- Reproject then buffer
- Buffer then dissolve (needs MCP-15)
- Clip then calculate statistics

### Advanced (MCP-15 required)
- Spatial join + buffer + clip + statistics
- Intersection + difference + union pipeline
- Multi-layer merge + reproject + buffer
- Select by location + dissolve + calculate field

## Related Files

- [KB-02-task-stratification](../02-research-design/task-stratification.md)
- [KB-02-hypotheses](../02-research-design/hypotheses.md)
