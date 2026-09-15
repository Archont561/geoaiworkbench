---
id: KB-03-layer5-complex-tasks
title: "Layer 5 — Complex Task Metrics"
category: metrics
subcategory: layer5
tags: [metrics, complex-tasks, PCS, SCR, LCP, SHR, recovery]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [3, 12]
related:
  - KB-03-metrics-overview
  - KB-01-mansourian-oucheikh-2026
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Layer 5 metrics for complex multi-step tasks: PCS, SCR, LCP, SHR, Recovery"
  key_facts:
    - "PCS uses weighted step categories"
    - "SHR from Mansourian & Oucheikh (2026)"
    - "LCP measures how far agent got before first error"
    - "Critical for PB2 (difficulty moderation)"
  common_questions:
    - "What is PCS?"
    - "What are the step weights?"
    - "How is SHR different from Pass@3?"
---

# Layer 5 — Complex Task Metrics

## Metrics

### 1. Partial Credit Score (PCS)

**Formula:**
```
PCS = Σ(step_completed × step_weight) / Σ(step_weight)
```

**Range:** [0, 1]

**Step weights:**

| Step Category | Weight | Rationale |
|---|---|---|
| data_loading | 1.0 | Basic, low cognitive demand |
| data_preparation | 1.5 | Moderate (reprojection, filtering) |
| spatial_analysis | 3.0 | Core GIS operation |
| spatial_reasoning | 4.0 | Highest cognitive demand |
| output | 2.0 | Important but mechanical |

**Primary metric for:** PB2 (two-way ANOVA paradigm × difficulty)

**Example:**
```
Task: Load roads → Reproject → Buffer → Clip → Save
Steps:  data_loading(1.0) + data_preparation(1.5) + spatial_analysis(3.0) + spatial_analysis(3.0) + output(2.0)
Total weight: 10.5

Agent completes: Load ✅, Reproject ✅, Buffer ✅, Clip ❌, Save ❌
PCS = (1.0 + 1.5 + 3.0) / 10.5 = 5.5/10.5 = 0.524
```

### 2. Step Completion Rate (SCR)

**Formula:**
```
SCR = |{completed steps}| / |{required steps}|
```

**Range:** [0, 1]

**Simpler than PCS** — unweighted fraction of steps completed.

### 3. Longest Correct Prefix (LCP)

**Formula:**
```
LCP = max{n : first n steps of workflow are all correct}
```

**Range:** [0, total_steps]

**Measures:** How far the agent got before making the first error.

**Related to:** Fan et al. (2026) information fidelity degradation (PB6)

**Example:**
```
Reference: Load → Reproject → Buffer → Clip → Save
Agent:     Load → Reproject → Buffer → Union → Save
                                     ↑ first error
LCP = 3
```

### 4. Self-Healing Ratio (SHR) ⭐ NEW

**Formula:**
```
SHR = |{tasks failed on attempt 1 AND passed on attempt 2 or 3}| / |{tasks failed on attempt 1}|
```

**Range:** [0, 1]

**Source:** Mansourian & Oucheikh (2026)

**Difference from Pass@3:**
- Pass@3 = fraction of ALL tasks passed in 3 attempts
- SHR = fraction of FAILED tasks that recovered
- SHR isolates recovery capability from raw capability

**Expected pattern:** CodeGen > MCP-15 > MCP-5 (code is easier to fix than tool params)

### 5. Recovery After Failure

**Definition:** Binary indicator per task — did the agent recover from a mid-workflow failure?

**Measurement:** Compare step sequence across attempts. If attempt 2+ completes steps that failed in attempt 1, recovery occurred.

**Range:** {0, 1} per task

## Metric Sources by Condition

| Metric | MCP-5/15 | CodeGen |
|---|---|---|
| PCS | MCPMonitor step tracking | QGIS IR + runtime trace |
| SCR | MCPMonitor step count | QGIS IR step count |
| LCP | MCPMonitor ordered events | QGIS IR ordered operations |
| SHR | Pass@1 vs Pass@3 comparison | Pass@1 vs Pass@3 comparison |
| Recovery | Step comparison across attempts | Code diff across attempts |

## Related Files

- [KB-01-mansourian-oucheikh-2026](../01-literature/papers/mansourian-oucheikh-2026.md) — SHR source
- [KB-01-fan-et-al-2026](../01-literature/papers/fan-et-al-2026.md) — LCP theoretical basis
- [KB-02-task-stratification](../02-research-design/task-stratification.md) — Difficulty tiers
