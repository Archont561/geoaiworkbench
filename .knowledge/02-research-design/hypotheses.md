---
id: KB-02-hypotheses
title: "All Hypotheses (H1-H7)"
category: research-design
subcategory: hypotheses
tags: [hypotheses, predictions, PB1, PB2, PB3, PB4, PB5, PB7]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [2, 3, 15]
related:
  - KB-00-research-questions
  - KB-02-final-research-design
  - KB-03-metrics-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "All testable hypotheses mapped to research questions"
  key_facts:
    - "H1-H5 for PB1-PB5"
    - "H7a-H7e for PB7 (tool count)"
    - "Each hypothesis has supporting evidence and statistical test"
  common_questions:
    - "What are the hypotheses?"
    - "What does H7a predict?"
    - "Which hypothesis tests tool count?"
---

# All Hypotheses

Complete list of testable hypotheses for GeoAIWorkbench, mapped to research questions.

## PB1 Hypotheses

### H1: No Universal Superiority
**Statement:** Neither MCP-5, MCP-15, nor CodeGen is universally superior across all task types. Aggregate TSR differences are small and task-dependent.

**Supporting evidence:** Luo et al. (2026) showed paradigm advantage depends on task type.

**Statistical test:** One-way ANOVA on TSR (3 paradigms). Expect non-significant main effect or small effect size.

**Expected result:** Paradigm main effect significant but small (Cliff's delta < 0.33).

## PB2 Hypotheses

### H2a: MCP Wins on Structured Tasks
**Statement:** MCP paradigms outperform CodeGen on basic and intermediate tasks with well-defined operations.

**Supporting evidence:** Luo et al. (2026) function calling more stable for structured operations.

**Statistical test:** Two-way ANOVA interaction (paradigm × difficulty). Expect MCP > CodeGen on basic tier.

### H2b: CodeGen Wins on Complex Tasks
**Statement:** CodeGen outperforms both MCP paradigms on advanced tasks requiring creative spatial reasoning.

**Supporting evidence:** Luo et al. (2026) code generation better for complex open-ended tasks. Akinboyewa et al. (2025) advanced task failures.

**Statistical test:** Two-way ANOVA interaction. Expect CodeGen > MCP on advanced tier.

### H2c: MCP-15 Bridges the Gap
**Statement:** MCP-15 reduces the performance gap between MCP and CodeGen on advanced tasks compared to MCP-5.

**Supporting evidence:** Mo et al. (2025) more tools enable more operations.

**Statistical test:** Post-hoc Tukey HSD on advanced tasks: MCP-15 vs MCP-5 vs CodeGen.

## PB3 Hypotheses

### H3: Agent-Paradigm Interaction
**Statement:** Different agents have different affinities for each paradigm. No single agent dominates all conditions.

**Supporting evidence:** Díaz-Ireland et al. (2026) model-specific capabilities. Krechetova & Kochedykov (2025) model-specific rejection behavior.

**Statistical test:** Two-way ANOVA (agent × paradigm) on TSR. Expect significant interaction.

**Expected pattern:**
- Claude Code: Strong in all paradigms (best overall)
- Goose: Stronger in CodeGen (BYOM flexibility)
- Codex: Stronger in MCP (structured approach)
- OpenCode: Balanced

## PB4 Hypotheses

### H4a: MCP Has Fewer Parameter Errors
**Statement:** MCP paradigms have higher PEA than CodeGen due to Pydantic schema validation.

**Supporting evidence:** Yu et al. (2026) PEA is critical. MCP schemas enforce constraints.

**Statistical test:** Mann-Whitney U on PEA (MCP vs CodeGen).

### H4b: CodeGen Has Higher Self-Healing
**Statement:** CodeGen has higher SHR than MCP because agents can fix and re-run code.

**Supporting evidence:** Mansourian & Oucheikh (2026) self-healing patterns.

**Statistical test:** Chi-square on SHR (MCP vs CodeGen).

### H4c: Error Profiles Differ
**Statement:** MCP errors concentrate in wrong_tool and seq_error; CodeGen errors concentrate in syntax_error and hallucination.

**Supporting evidence:** Different failure mechanisms for structured vs free-form approaches.

**Statistical test:** Chi-square on error type distributions.

## PB5 Hypotheses

### H5a: MCP-5 Has Smallest Attack Surface
**Statement:** MCP-5 has the smallest attack surface due to minimal tool count and no code execution.

**Supporting evidence:** Hou et al. (2025) capability exposure threat.

**Measurement:** Attack surface = tool_count × avg_params × I/O_scope

### H5b: CodeGen Has Largest Attack Surface
**Statement:** CodeGen has the largest attack surface because agents can execute arbitrary code.

**Supporting evidence:** Arbitrary code execution is the ultimate capability exposure.

**Measurement:** Unlimited tool count, unlimited params, unlimited I/O.

### H5c: MCP-15 Introduces Expression Risk
**Statement:** MCP-15's `calculate_field` tool introduces expression injection risk not present in MCP-5.

**Supporting evidence:** Maloyan & Namiot (2026) parameter manipulation attacks.

**Measurement:** ADV-02 to ADV-04 results for `calculate_field`.

## PB7 Hypotheses (Tool Count Effect)

### H7a: MCP-15 > MCP-5 on Complex Tasks
**Statement:** MCP-15 outperforms MCP-5 on advanced tasks because required tools are available.

**Supporting evidence:** Mo et al. (2025) more tools enable more operations.

**Statistical test:** Paired t-test on TSR for advanced tasks (MCP-5 vs MCP-15).

### H7b: MCP-15 < MCP-5 on Simple Tasks
**Statement:** MCP-15 underperforms MCP-5 on basic tasks due to tool selection overhead.

**Supporting evidence:** Song et al. (2025) context pollution from tool schemas.

**Statistical test:** Paired t-test on TSR for basic tasks.

### H7c: CodeGen > MCP-15 > MCP-5 on Advanced
**Statement:** On advanced tasks, CodeGen > MCP-15 > MCP-5 in TSR.

**Supporting evidence:** Combined Mo et al. + Song et al. + Luo et al.

**Statistical test:** One-way ANOVA on advanced tasks with post-hoc Tukey.

### H7d: MCP-5 > MCP-15 on Execution Determinism
**Statement:** MCP-5 has higher ED than MCP-15 because fewer tool choices reduce variance.

**Supporting evidence:** Strickland et al. (2026) ED/CF tradeoff. Fewer choices = more deterministic.

**Statistical test:** Paired t-test on ED (MCP-5 vs MCP-15).

### H7e: Tool Selection Accuracy Decreases
**Statement:** Tool Selection Accuracy decreases from MCP-5 to MCP-15.

**Supporting evidence:** Mo et al. (2025) degradation curve. Even at 15 tools, some degradation expected.

**Statistical test:** Paired t-test on TSA (MCP-5 vs MCP-15).

## Hypothesis Summary Table

| ID | RQ | Direction | Test | Key Evidence |
|---|---|---|---|---|
| H1 | PB1 | No universal winner | ANOVA | Luo et al. |
| H2a | PB2 | MCP > CodeGen (basic) | ANOVA interaction | Luo et al. |
| H2b | PB2 | CodeGen > MCP (advanced) | ANOVA interaction | Luo et al., Akinboyewa |
| H2c | PB2 | MCP-15 bridges gap | Tukey HSD | Mo et al. |
| H3 | PB3 | Agent × paradigm interaction | ANOVA | Díaz-Ireland |
| H4a | PB4 | MCP PEA > CodeGen | Mann-Whitney | Yu et al. |
| H4b | PB4 | CodeGen SHR > MCP | Chi-square | Mansourian |
| H4c | PB4 | Different error profiles | Chi-square | Mechanism |
| H5a | PB5 | MCP-5 smallest surface | Descriptive | Hou et al. |
| H5b | PB5 | CodeGen largest surface | Descriptive | Hou et al. |
| H5c | PB5 | MCP-15 expression risk | ADV tasks | Maloyan |
| H7a | PB7 | MCP-15 > MCP-5 (advanced) | Paired t-test | Mo et al. |
| H7b | PB7 | MCP-5 > MCP-15 (basic) | Paired t-test | Song et al. |
| H7c | PB7 | CodeGen > MCP-15 > MCP-5 | ANOVA + Tukey | Combined |
| H7d | PB7 | MCP-5 ED > MCP-15 | Paired t-test | Strickland |
| H7e | PB7 | TSA decreases | Paired t-test | Mo et al. |

## Related Files

- [KB-00-research-questions](../00-meta/research-questions.md) — RQ definitions
- [KB-02-final-research-design](final-research-design.md) — Experimental design
- [KB-03-statistical-tests](../03-metrics/statistical-tests.md) — Test details
