---
id: KB-03-layer4-execution
title: "Layer 4 — Execution Behavior Metrics"
category: metrics
subcategory: layer4
tags: [metrics, execution, determinism, errors, tokens, time, ITS]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [3, 12, 15]
related:
  - KB-03-metrics-overview
  - KB-01-strickland-et-al-2026
  - KB-01-mansourian-oucheikh-2026
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Layer 4 metrics: ED, Error Rate, Error Recovery, ITS, Tokens, Wall Clock Time"
  key_facts:
    - "ED from Strickland et al. (2026)"
    - "ITS from Mansourian & Oucheikh (2026)"
    - "Error taxonomy differs by paradigm"
    - "Token tracking via agent API logs"
    - "Context Window Utilization added for PB7"
  common_questions:
    - "What is Execution Determinism?"
    - "How is ITS calculated?"
    - "What error types are tracked?"
---

# Layer 4 — Execution Behavior Metrics

## Metrics

### 1. Execution Determinism (ED)

**Formula (binary):**
```
ED = 1 if all 3 repetitions produced identical output else 0
```

**Formula (continuous):**
```
ED = mean(pairwise_OQS_similarity across 3 runs)
```

**Range:** [0, 1]

**Source:** Strickland et al. (2026) ED/CF Pareto framework

**Primary metric for:** PB4, PB7 (H7d)

**Expected pattern:** MCP-5 > MCP-15 > CodeGen (fewer choices = more deterministic)

### 2. Error Rate

**Formula:**
```
Error Rate = |{tool calls with errors}| / |{total tool calls}|
```

**Range:** [0, 1]

**MCP source:** MCPMonitor error events

**CodeGen source:** CodeGenMonitor non-zero exit codes + runtime exceptions

### 3. Error Recovery Rate

**Formula:**
```
Error Recovery Rate = |{errors followed by successful retry}| / |{total errors}|
```

**Range:** [0, 1]

**Measures:** Agent's ability to self-correct after errors.

### 4. Error Type Distribution

**Definition:** Frequency of each error type across all runs.

**MCP error types:**
- `wrong_tool` — Selected incorrect tool
- `param_type` — Wrong parameter type (caught by Pydantic)
- `param_value` — Invalid parameter value (e.g., negative distance)
- `crs_mismatch` — CRS incompatibility
- `exec_error` — QGIS Processing execution failure
- `seq_error` — Wrong operation sequence

**CodeGen error types:**
- `syntax_error` — Python syntax error
- `import_error` — Missing or wrong import
- `runtime_error` — Runtime exception
- `logic_error` — Code runs but produces wrong result
- `hallucination` — References nonexistent layer, algorithm, or API

**Statistical test:** Chi-square on error type distributions (PB4)

### 5. Iterations to Success (ITS) ⭐ NEW

**Formula:**
```
ITS = min({attempt_number : task passed on attempt_number}) or ∞
```

**Range:** [1, 3] or ∞

**Source:** Mansourian & Oucheikh (2026)

**Reporting:** Median and IQR per paradigm × difficulty cell.

**Measures:** How many attempts needed. Lower = better.

### 6. Token Consumption

**Definition:** Total tokens consumed per task run (input + output).

**Source:** Agent API logs (recorded in JSONL).

**Units:** Tokens (model-specific tokenization)

**Used in:** Cost-Performance Ratio (Layer 6)

### 7. Wall Clock Time

**Definition:** Total elapsed time from agent launch to task completion.

**Measurement:** Harness timer (start → agent exit).

**Units:** Seconds

**Includes:** Agent startup, LLM inference, tool execution, retries.

### 8. Context Window Utilization (CWU) ⭐ NEW for PB7

**Formula:**
```
CWU = tokens(all_tool_schemas + server_instructions) / model_context_window
```

**Definition:** Fraction of context window consumed by MCP tool definitions.

**Expected:** MCP-15 ≈ 3× MCP-5. CodeGen ≈ 0 (no schemas).

**Tests:** H7b (context pollution on simple tasks)

## Metric Sources by Condition

| Metric | MCP-5/15 | CodeGen |
|---|---|---|
| ED | Output diff across 3 runs | Output diff across 3 runs |
| Error Rate | MCPMonitor | CodeGenMonitor |
| Error Types | MCP error codes | stderr classification |
| ITS | Attempt counting | Attempt counting |
| Tokens | Agent API logs | Agent API logs |
| Wall Clock | Harness timer | Harness timer |
| CWU | Schema token count | N/A (0) |

## Related Files

- [KB-03-error-taxonomy](error-taxonomy.md) — Full error type definitions
- [KB-01-strickland-et-al-2026](../01-literature/papers/strickland-et-al-2026.md) — ED theory
- [KB-01-mansourian-oucheikh-2026](../01-literature/papers/mansourian-oucheikh-2026.md) — ITS source
