---
id: KB-02-final-research-design
title: "Final Research Design — 3-Condition Factorial Experiment"
category: research-design
subcategory: specification
tags: [design, factorial, 3-condition, mcp-5, mcp-15, codegen, 1800-runs]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [2, 3, 15]
related:
  - KB-02-design-evolution
  - KB-00-research-questions
  - KB-02-evaluation-dimensions
  - KB-02-hypotheses
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Complete specification of the 3-condition factorial experiment"
  key_facts:
    - "3 paradigms × 4 agents × 50 tasks × 3 reps = 1,800 runs"
    - "MCP-5: 5 tools (Tier 1-2)"
    - "MCP-15: 15 tools (Tier 1-5)"
    - "CodeGen: unlimited PyQGIS"
    - "Black box agents, 2 observation points"
    - "7-layer metrics framework"
  common_questions:
    - "What is the experimental design?"
    - "How many runs total?"
    - "What are the three conditions?"
    - "Why 3 repetitions?"
---

# Final Research Design

## Overview

A controlled factorial experiment comparing three paradigms for LLM-driven GIS automation inside QGIS, using production CLI agents as black boxes.

## Factorial Structure

```
3 paradigms × 4 agents × 50 tasks × 3 repetitions = 1,800 total runs
```

### Independent Variables

| Variable | Levels | Type |
|---|---|---|
| **Paradigm** | MCP-5, MCP-15, CodeGen | Between-subjects |
| **Agent** | OpenCode, Claude Code, Codex CLI, Goose | Between-subjects |
| **Task** | 50 GeoAnalystBench tasks | Within-subjects |
| **Repetition** | 1, 2, 3 | Within-subjects |

### Dependent Variables

7-layer metrics framework (see [KB-03-metrics-overview](../03-metrics/metrics-overview.md)):

| Layer | Primary Metrics |
|---|---|
| 1. Task Success | TSR, Pass@1, Pass@3, Completion Rate, RR |
| 2. Workflow | Step Count, PEA, Tool Selection Accuracy, Workflow Validity |
| 3. Output Quality | OQS (geometry, CRS, IoU, features, attributes) |
| 4. Execution | ED, Error Rate, ITS, Tokens, Wall Clock Time |
| 5. Complex Tasks | PCS, SCR, LCP, SHR, Recovery |
| 6. Composite | Weighted Score, Difficulty-Adjusted, Cost-Performance |
| 7. Security | Attack Surface, Injection Resistance, Validation Coverage |

## Three Conditions

### Condition A: MCP-5 (Constrained Tool Calling)

- **Tools:** 5 (Tier 1-2 only)
  - `layer_info`, `layer_statistics`, `buffer`, `clip`, `reproject`
- **Agent config:** MCP server enabled, `GEOMCP_TIER=5`
- **System prompt:** "Use the provided GIS tools to complete the task"
- **Observation:** MCPMonitor logs every tool call
- **Purpose:** Paradigm-clean baseline, maximum contrast with CodeGen

### Condition B: MCP-15 (Expanded Tool Calling)

- **Tools:** 15 (Tier 1-5)
  - Tier 1-2 (5 tools) + `dissolve`, `intersection`, `difference`, `union`, `spatial_join`, `select_by_location`, `centroid`, `simplify`, `merge_layers`, `calculate_field`
- **Agent config:** MCP server enabled, `GEOMCP_TIER=15`
- **System prompt:** "Use the provided GIS tools to complete the task"
- **Observation:** MCPMonitor logs every tool call
- **Purpose:** Realistic GIS toolkit, tests tool count effect (PB7)

### Condition C: CodeGen (Direct Code Generation)

- **Tools:** None (unlimited PyQGIS access via shell)
- **Agent config:** No MCP server, PyQGIS available
- **System prompt:** "Write and execute PyQGIS code to complete the task"
- **Observation:** CodeGenMonitor + CodeAnalyzer + RuntimeTracer
- **Purpose:** Upper bound flexibility, contrast with MCP constraints

## Task Suite

### Source

50 tasks from GeoAnalystBench (Zhang et al., 2025), adapted from ArcPy to PyQGIS.

### Difficulty Stratification

| Tier | Count | Description | MCP-5 Sufficient? |
|---|---|---|---|
| Basic | ~15 | Single operation (buffer, clip, reproject) | ✅ Yes |
| Intermediate | ~20 | 2-3 operations, simple pipeline | ⚠️ Partially |
| Advanced | ~15 | 4+ operations, spatial reasoning | ❌ Needs MCP-15 |

### Adversarial Tasks (Security)

5 additional tasks (ADV-01 to ADV-05) for PB5 security evaluation. Not included in main factorial count.

### Task Mapping to Tool Tiers

Each task annotated with `minimum_tier` field:
- `minimum_tier: 2` → MCP-5 sufficient
- `minimum_tier: 3-5` → Requires MCP-15

## Agent Configuration

### Per-Agent Setup

Each agent gets 3 config files:

| Agent | MCP-5 Config | MCP-15 Config | CodeGen Config |
|---|---|---|---|
| OpenCode | `opencode_mcp5.json` | `opencode_mcp15.json` | `opencode_codegen.json` |
| Claude Code | `.mcp_mcp5.json` | `.mcp_mcp15.json` | `.mcp_codegen.json` |
| Codex CLI | `config_mcp5.toml` | `config_mcp15.toml` | `config_codegen.toml` |
| Goose | `goose_mcp5.yaml` | `goose_mcp15.yaml` | `goose_codegen.yaml` |

### Black Box Constraint

Agents are treated as opaque units. See [KB-02-black-box-constraint](black-box-constraint.md).

## Execution Environment

| Component | Specification |
|---|---|
| OS | Ubuntu 24.04 LTS |
| QGIS | 3.44.x (conda-forge via Pixi) |
| Python | 3.12 |
| MCP SDK | FastMCP 4.0.3 |
| Package Manager | Pixi 0.80.0 |
| MCP Transport | stdio |
| Bridge | TCP localhost:9876 |

## Run Execution Flow

```
For each (paradigm, agent, task, repetition):
  1. Create clean workspace
  2. Copy input data to workspace/input/
  3. Generate agent config for paradigm
  4. Launch agent with task prompt
  5. Wait for completion or timeout (300s)
  6. Collect outputs from workspace/output/
  7. Collect trajectory logs
  8. Run OutputVerifier (independent process)
  9. Compute metrics
  10. Write TaskResult to JSONL
  11. Mark task as completed in completed.json
```

## Statistical Analysis Plan

| RQ | Test | Variables |
|---|---|---|
| PB1 | One-way ANOVA + Tukey HSD | Paradigm → TSR |
| PB2 | Two-way ANOVA | Paradigm × Difficulty → PCS |
| PB3 | Two-way ANOVA | Agent × Paradigm → TSR |
| PB4 | Chi-square + McNemar | Paradigm → Error types, ED |
| PB5 | Descriptive + qualitative | Paradigm → Security metrics |
| PB6 | Correlation analysis | Chain length → LCP (optional) |
| PB7 | Paired t-test | MCP-5 vs MCP-15 → TSR, TSA, ED |

**Significance:** α = 0.05, Bonferroni α_adj = 0.0083

## Sample Size Justification

- 600 runs per paradigm = high power (>0.95) for medium effects
- 200 runs per paradigm × difficulty cell = sufficient for interaction
- 150 runs per agent × paradigm cell = adequate for large effects
- 600 paired comparisons for PB7 = very high power

## Related Files

- [KB-02-evaluation-dimensions](evaluation-dimensions.md) — 5 evaluation dimensions
- [KB-02-black-box-constraint](black-box-constraint.md) — Observation constraints
- [KB-02-methodology-dsrm](methodology-dsrm.md) — DSRM mapping
- [KB-02-hypotheses](hypotheses.md) — All hypotheses
- [KB-02-task-stratification](task-stratification.md) — Task difficulty details
- [KB-03-metrics-overview](../03-metrics/metrics-overview.md) — Full metrics
