---
id: KB-03-layer2-workflow
title: "Layer 2 — Workflow Process Metrics"
category: metrics
subcategory: layer2
tags: [metrics, workflow, PEA, tool-selection, step-count, validity]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [3, 12, 15]
related:
  - KB-03-metrics-overview
  - KB-01-yu-et-al-2026
  - KB-01-shabbir-et-al-2025
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Layer 2 metrics: Step Count, PEA, Tool Selection, Workflow Validity, Tool Selection Degradation"
  key_facts:
    - "PEA from Yu et al. (2026)"
    - "Tool Selection Accuracy from Shabbir et al. (2025)"
    - "Tool Selection Degradation Rate for PB7"
    - "MCP source: MCPMonitor logs; CodeGen source: QGIS IR"
  common_questions:
    - "What is PEA?"
    - "How is tool selection measured in CodeGen?"
    - "What is Tool Selection Degradation?"
---

# Layer 2 — Workflow Process Metrics

## Metrics

### 1. Step Count

**Definition:** Number of geoprocessing operations executed.

**MCP source:** Count of MCPMonitor tool call events (excluding `layer_info` inspection calls).

**CodeGen source:** Count of `processing.run()` calls in QGIS Workflow IR.

**Expected:** Matches reference workflow step count for successful tasks.

### 2. Correct Step Ratio

**Formula:**
```
CSR = |{steps matching reference workflow}| / |{reference steps}|
```

**Definition:** Fraction of required steps that were correctly executed.

**Range:** [0, 1]

### 3. Step Order Accuracy

**Definition:** Whether steps were executed in the correct sequence.

**Measurement:** Longest common subsequence of executed steps vs reference.

**Range:** [0, 1]

### 4. Backtrack Count

**Definition:** Number of times agent re-did a previously attempted step.

**MCP source:** Repeated calls to same tool with same parameters.

**CodeGen source:** Repeated `processing.run()` calls with same algorithm.

### 5. Parameter Execution Accuracy (PEA) ⭐ KEY METRIC

**Formula:**
```
PEA = Σ(correctly_inferred_params) / Σ(total_required_params)
```

**Definition:** Fraction of required parameters that were correctly provided.

**Range:** [0, 1]

**Source:** Yu et al. (2026) GeoAgentBench

**MCP computation:**
- Extract params from MCPMonitor logs
- Compare against reference workflow parameters
- Pydantic validation catches type errors before execution

**CodeGen computation:**
- Extract params from QGIS Workflow IR (AST parsing)
- Validate against QGIS Processing registry via `checkParameterValues()`
- More granular than MCP (QGIS-native validation)

**Example:**
```
Task: "Buffer roads by 500m"
Required: input_layer="roads", distance=500, output_layer="roads_buf"

MCP agent provides: {input_layer: "roads", distance: 500, output_layer: "roads_buf"}
PEA = 3/3 = 1.0

CodeGen agent provides: processing.run("native:buffer", {"INPUT": "roads", "DISTANCE": 500})
PEA = 2/3 = 0.67 (missing OUTPUT)
```

### 6. Tool Selection Accuracy (TSA)

**Formula:**
```
TSA = |{correct tool selections}| / |{total tool selections}|
```

**Definition:** Fraction of times agent selected the correct tool/algorithm.

**Source:** Shabbir et al. (2025) ThinkGeo (ToolAcc)

**MCP computation:** Compare MCPMonitor tool names against reference workflow.

**CodeGen computation:** Compare QGIS IR algorithm IDs against reference.

### 7. Tool Selection Degradation Rate (TSDR) ⭐ NEW for PB7

**Formula:**
```
TSDR = (TSA_MCP5 - TSA_MCP15) / TSA_MCP5
```

**Definition:** Relative decrease in tool selection accuracy from MCP-5 to MCP-15.

**Range:** [0, 1] (0 = no degradation, 1 = complete degradation)

**Tests:** H7e (tool selection decreases with more tools)

**Source:** Mo et al. (2025) degradation curve

## Metric Sources by Condition

| Metric | MCP-5/15 Source | CodeGen Source |
|---|---|---|
| Step Count | MCPMonitor event count | QGIS IR `processing_calls` |
| PEA | MCPMonitor params | QGIS IR + `checkParameterValues()` |
| TSA | MCPMonitor tool names | QGIS IR algorithm IDs |
| TSDR | Compare MCP-5 vs MCP-15 TSA | N/A |

## Related Files

- [KB-01-yu-et-al-2026](../01-literature/papers/yu-et-al-2026.md) — PEA source
- [KB-01-shabbir-et-al-2025](../01-literature/papers/shabbir-et-al-2025.md) — ToolAcc source
- [KB-01-mo-et-al-2025](../01-literature/papers/mo-et-al-2025.md) — TSDR basis
