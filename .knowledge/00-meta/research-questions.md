---
id: KB-00-research-questions
title: "Research Questions (PB1-PB7)"
category: meta
subcategory: research-design
tags: [research-questions, hypotheses, PB1, PB2, PB3, PB4, PB5, PB6, PB7]
status: canonical
created: 2026-09-10
updated: 2026-09-11
source_conversation_parts: [2, 3, 8, 15]
related:
  - KB-00-project-overview
  - KB-02-hypotheses
  - KB-02-final-research-design
  - KB-03-metrics-overview
  - backlog-decision-7
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "The seven research questions that structure the entire thesis and evaluation"
  key_facts:
    - "6 primary RQs (PB1-PB5, PB7), 1 optional (PB6)"
    - "PB5 added after Hou et al. TOSEM evidence on security"
    - "PB7 added for tool count effect (MCP-5 vs MCP-15)"
    - "Each RQ maps to specific metrics and statistical tests"
    - "PB1 uses McNemar, PB2 uses two-way ANOVA, PB4 uses chi-square, PB7 uses one-way ANOVA"
  common_questions:
    - "What is PB2?"
    - "Which metrics answer PB4?"
    - "Why was PB5 added?"
    - "What is PB6?"
    - "What is PB7?"
    - "How does PB7 relate to Mo et al. and Song et al.?"
---

# Research Questions

The GeoAIWorkbench thesis is structured around seven research questions. Six are primary (PB1-PB5, PB7); the seventh (PB6) is optional pending time.

Polish: "PB" = "Pytanie Badawcze" (Research Question).

## PB1 — Overall Effectiveness

> **How does MCP-based tool integration compare to code generation in overall task success rate and spatial output quality?**

**Compares:** MCP-5 vs MCP-15 vs CodeGen (all three conditions)

**Metrics:**
- Task Success Rate (TSR)
- Pass@1, Pass@3
- Output Quality Score (OQS): geometry validity, feature count match, CRS match, extent IoU, attribute preservation

**Statistical test:** One-way ANOVA (paradigm, 3 levels) + post-hoc Tukey HSD; Mann-Whitney U for OQS distributions.

**Hypothesis:** Aggregate performance depends on task type. No paradigm is universally superior.

**Related metrics:** [KB-03-layer1-task-success](../03-metrics/layer1-task-success.md), [KB-03-layer3-output-quality](../03-metrics/layer3-output-quality.md)

## PB2 — Difficulty Moderation

> **How does task difficulty moderate the relative effectiveness of MCP tool calling versus code generation?**

**Compares:** MCP-5 vs MCP-15 vs CodeGen across difficulty tiers

**Metrics:**
- Partial Credit Score (PCS) with weights: data_loading=1.0, data_preparation=1.5, spatial_analysis=3.0, spatial_reasoning=4.0, output=2.0
- Difficulty-Adjusted Score
- Success rate stratified by difficulty tier

**Statistical test:** Two-way ANOVA (paradigm × difficulty) on PCS.

**Hypothesis:** MCP wins on structured, parameter-sensitive tasks. CodeGen wins on open-ended, creative spatial analysis. MCP-15 outperforms MCP-5 on tasks requiring Tier 3+ operations. Interaction effects expected.

**Supporting evidence:** Luo et al. (2026) showed 97.14% (code gen) vs 85.71% (function calling) on GeoJSON tasks with similar pattern.

**Related:** [KB-01-luo-et-al-2026](../01-literature/papers/luo-et-al-2026.md)

## PB3 — Agent-Paradigm Interaction

> **Which agent-paradigm combinations achieve the best cost-performance tradeoff?**

**Compares:** 4 agents × 3 paradigms (12 combinations)

**Metrics:**
- Cost-Performance Ratio (success rate / total tokens)
- Token consumption per task
- Wall clock time per task
- TSR by agent × paradigm

**Statistical test:** Two-way ANOVA (agent × paradigm) on TSR; effect size via Cliff's delta.

**Hypothesis:** Different agents have different affinities for each paradigm. Model architecture matters.

**Practical output:** 3×4 decision matrix for practitioners choosing agent/paradigm combinations.

## PB4 — Execution Behavior

> **How do the paradigms differ in execution behavior — parameter correctness, error profiles, self-healing, and determinism?**

**Compares:** MCP-5 vs MCP-15 vs CodeGen

**Metrics:**
- Parameter Execution Accuracy (PEA): (correct params) / (required params)
- Error Type Distribution:
  - MCP: wrong_tool, param_type, param_value, crs_mismatch, exec_error, seq_error
  - CodeGen: syntax_error, import_error, runtime_error, logic_error, hallucination
- Self-Healing Ratio (SHR)
- Iterations to Success (ITS)
- Execution Determinism (ED) across 3 repetitions

**Statistical test:** Chi-square for error type distributions; McNemar for paired ED comparisons.

**Hypothesis:** MCP has fewer parameter errors due to schema validation; CodeGen has broader error types but higher self-healing capability. MCP-5 has highest determinism (fewer choices).

## PB5 — Security Posture (Added Post-TOSEM Evidence)

> **What is the security posture of an MCP-based GIS tool server compared to code generation, and what design principles mitigate protocol-specific risks?**

**Compares:** MCP-5 vs MCP-15 vs CodeGen attack surface

**Added because:** Hou et al. (ACM TOSEM 2025) established comprehensive MCP threat taxonomy. Security became mandatory evaluation dimension.

**Metrics:**
- Attack Surface Size (tool count × parameter count × I/O scope)
- Prompt Injection Resistance (ADV-01 to ADV-05 pass/fail)
- Parameter Validation Coverage (% params with range/regex constraints)
- Data Exfiltration Risk (qualitative: low/medium/high)

**Method:** 5 adversarial tasks + qualitative attack surface analysis using Hou et al. taxonomy.

**Hypothesis:** MCP-5 has smallest attack surface. MCP-15 introduces additional risks (especially `calculate_field` expression injection). CodeGen has largest attack surface but risks are well-understood.

**Related:** [KB-10-threat-taxonomy-hou](../10-security/threat-taxonomy-hou.md), [KB-10-adversarial-task-design](../10-security/adversarial-task-design.md)

## PB6 — Information Fidelity (Optional)

> **How does information fidelity degrade across multi-step MCP tool chains in geospatial workflows?**

**Compares:** MCP-5 vs MCP-15 (CodeGen excluded — different mechanism)

**Added because:** Fan et al. (AAMAS 2026) provides formal martingale model of MCP information degradation.

**Metrics:**
- Longest Correct Prefix (LCP)
- Information fidelity per chain depth
- Step Order Accuracy

**Method:** Analyze subset of complex tasks (5+ step chains) for degradation patterns.

**Status:** Optional. Include if time permits. Otherwise defer to future work.

## PB7 — Tool Count Effect (NEW)

> **How does MCP tool set size affect task success, tool selection accuracy, and execution determinism?**

**Compares:** MCP-5 vs MCP-15 directly

**Added because:** Mo et al. (2025) LiveMCPBench showed tool selection degrades beyond ~50 tools. Song et al. (2025) "Help or Hurdle" showed MCP can hurt performance when misapplied. No prior work has tested this in GIS context.

**Metrics:**
- Task Success Rate (TSR) — MCP-5 vs MCP-15
- Tool Selection Accuracy — expected to decrease from MCP-5 to MCP-15
- Execution Determinism (ED) — expected to decrease from MCP-5 to MCP-15
- Context Window Utilization — MCP-15 uses more context for tool schemas
- Schema Loading Time — proxy for context overhead

**Statistical test:** Paired t-test on TSR (MCP-5 vs MCP-15 per task); chi-square on tool selection patterns.

**Hypotheses:**
- **H7a:** MCP-15 > MCP-5 on complex tasks (more tools available)
- **H7b:** MCP-15 < MCP-5 on simple tasks (tool selection overhead)
- **H7c:** CodeGen > MCP-15 > MCP-5 on advanced tasks
- **H7d:** MCP-5 > MCP-15 on execution determinism (fewer choices = more consistent)
- **H7e:** Tool selection accuracy decreases from MCP-5 to MCP-15

**Related:** [KB-01-mo-et-al-2025](../01-literature/papers/mo-et-al-2025.md), [KB-01-song-et-al-2025](../01-literature/papers/song-et-al-2025.md), backlog `decision-7`

## Cross-Cutting Design Principle (PB5-derived)

> **What design principles should govern a GIS MCP server for controlled evaluation?**

Not a standalone RQ, but a synthesis output feeding into Chapter VII. Produces principles P1-P8:

- P1: No code execution tools (paradigm boundary)
- P2: Structured Pydantic input/output only
- P3: Read-only by default
- P4: Explicit output layer naming (no silent overwrite)
- P5: Behavioral contracts documented per tool
- P6: MCP annotations for hints (readOnlyHint, destructiveHint, idempotentHint)
- P7: Server instructions for cross-tool workflow guidance
- P8: **Tiered tool exposure** — provide minimal (5) and expanded (15) tiers to enable capability/determinism tradeoff (NEW from PB7)

## Mapping to Thesis Chapters

| Chapter | Addresses |
|---|---|
| Chapter IV (Experiment Design) | Introduces all 7 RQs, explains 3-condition design |
| Chapter VI (Results) | Answers PB1, PB2, PB3, PB4, PB5, PB6, PB7 |
| Chapter VII (Evaluation) | Synthesizes into design principles P1-P8 |

## Statistical Significance

- Significance threshold α = 0.05
- Bonferroni correction for multiple RQs: α_adj = 0.05 / 6 = 0.0083 (excluding PB6)
- Effect sizes reported alongside p-values (Cohen's d, Cliff's delta)
- Bootstrap 95% CIs on all primary metrics (following GISclaw precedent)

## Sample Size Justification

With 3 conditions × 4 agents × 50 tasks × 3 repetitions = 1,800 runs:

- **PB1 (paradigm main effect):** 600 runs per condition = high power (>0.95) for medium effect sizes
- **PB2 (paradigm × difficulty):** 200 runs per cell (3 paradigms × 3 difficulty tiers) = sufficient power
- **PB3 (paradigm × agent):** 150 runs per cell = adequate power for large effects
- **PB7 (MCP-5 vs MCP-15):** 600 paired comparisons per task = very high power for paired tests
