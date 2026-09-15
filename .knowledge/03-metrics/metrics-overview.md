---
id: KB-03-metrics-overview
title: "7-Layer Metrics Framework Overview"
category: metrics
subcategory: overview
tags: [metrics, framework, layers, overview, evaluation]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [3, 12, 14, 15]
related:
  - KB-02-evaluation-dimensions
  - KB-00-research-questions
  - KB-03-layer1-task-success
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Overview of the complete 7-layer metrics framework"
  key_facts:
    - "7 layers: Task Success, Workflow, Output, Execution, Complex, Composite, Security"
    - "~28 metrics total"
    - "Layer 7 (Security) added after Hou et al. TOSEM"
    - "Tool count metrics added for PB7"
    - "All metrics computable in all 3 conditions"
  common_questions:
    - "What metrics are used?"
    - "How many layers?"
    - "Which metrics are primary vs secondary?"
---

# 7-Layer Metrics Framework Overview

## Framework Structure

```
Layer 7: Security          ← Attack surface, injection resistance
Layer 6: Composite         ← Weighted scores, cost-performance
Layer 5: Complex Tasks     ← PCS, SCR, LCP, SHR, Recovery
Layer 4: Execution         ← ED, errors, ITS, tokens, time
Layer 3: Output Quality    ← Geometry, CRS, IoU, features, attributes
Layer 2: Workflow Process  ← Steps, PEA, tool selection, validity
Layer 1: Task Success      ← TSR, Pass@1/3, completion, rejection
```

## Layer Summary

| Layer | Name | Metrics Count | Primary RQ | Source |
|---|---|---|---|---|
| 1 | Task Success | 5 | PB1 | Standard |
| 2 | Workflow Process | 6 | PB2, PB4, PB7 | Yu et al., Shabbir et al. |
| 3 | Output Quality | 5 | PB1 | Zhang et al., Han et al. |
| 4 | Execution Behavior | 6 | PB4, PB7 | Strickland et al., Mansourian |
| 5 | Complex Tasks | 5 | PB2 | Standard + Mansourian |
| 6 | Composite | 4 | PB3 | Derived |
| 7 | Security | 4 | PB5 | Hou et al. TOSEM |
| **Total** | | **~35** | | |

## Primary vs Secondary Metrics

### Primary (reported in thesis tables)
- TSR (Layer 1)
- Pass@1, Pass@3 (Layer 1)
- OQS (Layer 3)
- PEA (Layer 2)
- ED (Layer 4)
- PCS (Layer 5)
- Cost-Performance Ratio (Layer 6)
- Prompt Injection Resistance (Layer 7)

### Secondary (reported in appendix)
- Completion Rate, RR (Layer 1)
- Step Count, Tool Selection Accuracy (Layer 2)
- Error Type Distribution (Layer 4)
- ITS, SHR (Layer 4/5)
- LCP, SCR (Layer 5)
- Attack Surface Size (Layer 7)

## Metric Parity Across Conditions

| Metric | MCP-5 | MCP-15 | CodeGen | Parity |
|---|---|---|---|---|
| TSR | ✅ | ✅ | ✅ | Exact |
| OQS | ✅ | ✅ | ✅ | Exact |
| PEA | ✅ (from logs) | ✅ (from logs) | ✅ (from IR + registry) | Comparable |
| ED | ✅ | ✅ | ✅ | Exact |
| Tool Selection | ✅ | ✅ | ✅ (from IR) | Comparable |
| Error Types | ✅ | ✅ | ✅ | Comparable |
| ITS/SHR | ✅ | ✅ | ✅ | Exact |
| Tokens | ✅ | ✅ | ✅ | Exact |
| Security | ✅ | ✅ | ✅ | Comparable |

## Detailed Layer Files

- [KB-03-layer1-task-success](layer1-task-success.md)
- [KB-03-layer2-workflow](layer2-workflow.md)
- [KB-03-layer3-output-quality](layer3-output-quality.md)
- [KB-03-layer4-execution](layer4-execution.md)
- [KB-03-layer5-complex-tasks](layer5-complex-tasks.md)
- [KB-03-layer6-composite](layer6-composite.md)
- [KB-03-layer7-security](layer7-security.md)
- [KB-03-error-taxonomy](error-taxonomy.md)
- [KB-03-statistical-tests](statistical-tests.md)

## Related Files

- [KB-02-evaluation-dimensions](../02-research-design/evaluation-dimensions.md) — 5 dimensions
- [KB-00-research-questions](../00-meta/research-questions.md) — PB1-PB7
- [KB-02-final-research-design](../02-research-design/final-research-design.md) — Experimental design
