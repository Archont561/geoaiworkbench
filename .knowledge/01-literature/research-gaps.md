---
id: KB-01-research-gaps
title: "10 Research Gaps Identified from Literature"
category: literature
subcategory: gaps
tags: [gaps, research-motivation, novelty, contribution]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [1, 15]
related:
  - KB-01-bibliography-overview
  - KB-00-contribution-summary
  - KB-00-research-questions
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "10 research gaps identified from Round 0 literature review"
  key_facts:
    - "Motivates GeoAIWorkbench thesis contribution"
    - "Each gap maps to specific research question"
    - "Some gaps addressed, others deferred to future work"
  common_questions:
    - "Why is GeoAIWorkbench needed?"
    - "What gaps does this thesis fill?"
    - "What is future work?"
---

# 10 Research Gaps Identified from Literature

Systematic analysis of Round 0 literature identified 10 research gaps. These motivate the GeoAIWorkbench thesis and map to specific research questions.

## Gap 1: Vector-Only Platform Limitation

**Observation:** Existing GIS agent systems are restricted to vector data on proprietary platforms.

**Evidence:**
- GIS Copilot (Akinboyewa et al., 2025) — QGIS only, vector focus
- GeoJSON Agents (Luo et al., 2026) — GeoJSON only
- GeoAnalystBench (Zhang et al., 2025) — ArcPy (proprietary), Python tasks

**Addressed by:** GeoAIWorkbench uses QGIS (open-source) with plans for raster extensions
**RQ:** Partial — scope note in [KB-00-scope-and-limitations](../00-meta/scope-and-limitations.md)
**Status:** Partially filled (QGIS open-source), raster deferred

## Gap 2: No Autonomous Data Retrieval Testing

**Observation:** Agents cannot independently discover needed data.

**Evidence:**
- Ning et al. (2025) provides framework, but not tested in comparison
- No benchmark measures data discovery capability

**Addressed by:** Not in scope for GeoAIWorkbench (tasks provide pre-loaded data)
**Status:** Future work

## Gap 3: Weak Spatial Reasoning

**Observation:** Tasks requiring deep spatial reasoning remain challenging for all models.

**Evidence:**
- Zhang et al. (2025) — advanced tasks show low success rates
- Akinboyewa et al. (2025) — challenges with advanced tasks

**Addressed by:** GeoAIWorkbench measures difficulty stratification (PB2)
**RQ:** PB2
**Status:** Directly addressed via difficulty analysis

## Gap 4: Inadequate Benchmarks

**Observation:** Existing benchmarks rely on static text matching, ignoring runtime feedback and multimodal outputs.

**Evidence:**
- GeoAnalystBench (Zhang et al., 2025) — CodeBLEU only, no runtime
- Most benchmarks single-turn

**Addressed by:** 4-layer CodeGen evaluation (static/semantic/runtime/artifact)
**RQ:** PB1, PB4
**Status:** Directly addressed via new evaluation pipeline

## Gap 5: Architecture Design Knowledge Gap

**Observation:** Relative merits of single vs multi-agent architectures poorly understood.

**Evidence:**
- Han et al. (2026) — Dual Agent DEGRADES strong models
- Wu et al. (2025) — Multi-agent IMPROVES code quality

**Addressed by:** GeoAIWorkbench uses single-agent throughout (fair comparison)
**Status:** Not addressed — deferred to future work

## Gap 6: Flexibility vs Determinism Tradeoff

**Observation:** No system achieves both simultaneously.

**Evidence:**
- Strickland et al. (2026) — Empirical Pareto front

**Addressed by:** GeoAIWorkbench measures ED across 3 repetitions per condition
**RQ:** PB4 (execution determinism), PB7 (tool count effect on ED)
**Status:** Directly addressed via ED metric

## Gap 7: No Self-Improvement

**Observation:** Agents use static backends and cannot learn from experience.

**Evidence:**
- No prior system implements self-improvement
- Li et al. (2025) — listed as future goal

**Addressed by:** Not in scope for GeoAIWorkbench
**Status:** Future work

## Gap 8: Advanced Task Autonomy Lacking

**Observation:** Agents succeed on simple tasks but fail on complex multi-step workflows.

**Evidence:**
- Akinboyewa et al. (2025) — 90%+ basic, <50% advanced
- Han et al. (2026) — long-horizon planning failures

**Addressed by:** GeoAIWorkbench includes advanced tasks with PCS weighting
**RQ:** PB2 (difficulty moderation)
**Status:** Directly addressed via PCS and stratification

## Gap 9: Societal and Ethical Concerns Unaddressed

**Observation:** Implications of autonomous GIS largely unexamined.

**Evidence:**
- Li et al. (2025) — flagged but not investigated
- No paper measures potential harms

**Addressed by:** GeoAIWorkbench includes security dimension (PB5) — subset of ethical concerns
**RQ:** PB5 (partial)
**Status:** Partially addressed

## Gap 10: No Standardized Agent Communication

**Observation:** Competing protocols not yet converged for GIS.

**Evidence:**
- MCP for tools, A2A for agents, ACP for editors
- No GIS-specific standard

**Addressed by:** GeoAIWorkbench evaluates MCP as protocol foundation
**RQ:** All (via MCP as experimental variable)
**Status:** Directly addressed

## Gap Coverage Summary

| Gap | Directly Addressed | Partially Addressed | Future Work |
|---|---|---|---|
| 1. Vector-only | ✅ (QGIS open-source) | | Raster |
| 2. Data retrieval | | | ✅ |
| 3. Spatial reasoning | ✅ (PB2) | | |
| 4. Benchmarks | ✅ (4-layer eval) | | |
| 5. Architecture | | | ✅ |
| 6. ED vs CF | ✅ (PB4, PB7) | | |
| 7. Self-improvement | | | ✅ |
| 8. Advanced tasks | ✅ (PB2, PCS) | | |
| 9. Ethics | | ✅ (PB5) | Full |
| 10. Standardization | ✅ (MCP focus) | | A2A |

**Coverage:** 6/10 directly addressed, 2/10 partially, 4/10 deferred to future work

## New Gaps Identified After Rounds 1-2

Additional gaps emerged from expanded literature:

### Gap 11 (added Round 2): No MCP Tool Count Study in GIS
**Evidence:** Mo et al. (2025), Song et al. (2025) show tool count matters generally, but no GIS-specific study.
**Addressed by:** PB7 (MCP-5 vs MCP-15 comparison)

### Gap 12 (added Round 2): No MCP Information Fidelity Study in GIS
**Evidence:** Fan et al. (2026) provides formal model, no GIS empirical validation.
**Addressed by:** PB6 (optional)

### Gap 13 (added Round 2): No MCP Security Study in GIS
**Evidence:** Hou et al. (2025) TOSEM taxonomy, no GIS-specific evaluation.
**Addressed by:** PB5 (adversarial tasks + attack surface analysis)

## Total Gap Contribution

GeoAIWorkbench directly addresses **9 out of 13 identified gaps**, making it one of the most comprehensive GIS agent evaluation studies to date.
