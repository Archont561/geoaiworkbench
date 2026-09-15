---
id: KB-02-black-box-constraint
title: "Black Box Constraint — Observation Points"
category: research-design
subcategory: constraints
tags: [black-box, observation, fairness, reproducibility, constraint]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [3, 15]
related:
  - KB-02-final-research-design
  - KB-00-scope-and-limitations
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Defines what can and cannot be observed about agent behavior"
  key_facts:
    - "Agents are opaque units — no internal instrumentation"
    - "MCP condition: 2 observation points (MCP logs + output files)"
    - "CodeGen condition: 4 observation points (code + execution + trace + output)"
    - "Ensures fair, reproducible, vendor-neutral evaluation"
  common_questions:
    - "What can we observe about agents?"
    - "Why not instrument agent internals?"
    - "Is this fair to both paradigms?"
---

# Black Box Constraint

## Definition

Agents are treated as **replaceable black boxes**. The benchmark does not modify, instrument, or inspect agent internals. Only external observation points are used.

## Observation Points by Condition

### MCP-5 and MCP-15 Conditions

| # | Observation Point | What It Captures |
|---|---|---|
| 1 | **MCP server logs** | Every tool call: name, params, result, error, duration |
| 2 | **GIS output files** | Final spatial artifacts in workspace/output/ |

### CodeGen Condition

| # | Observation Point | What It Captures |
|---|---|---|
| 1 | **Generated code files** | Python scripts in workspace/scripts/ |
| 2 | **Execution logs** | stdout, stderr, exit codes from subprocess |
| 3 | **Runtime traces** | `processing.run()` calls via monkeypatch |
| 4 | **GIS output files** | Final spatial artifacts in workspace/output/ |

## What Is NOT Observed

- Agent internal reasoning or chain-of-thought
- LLM prompts sent by agent to model API
- LLM responses received by agent
- Agent decision-making process
- Agent memory or context management
- Token-level model behavior

## Rationale

### Fairness
- Same observation constraints for all agents
- No vendor-specific instrumentation advantages
- Any agent can be swapped in without code changes

### Reproducibility
- Observation points are deterministic
- No dependency on agent internal APIs (which change between versions)
- Other researchers can replicate with different agents

### Practicality
- CLI agents don't expose internal APIs
- Modifying agent code would defeat "production agent" premise
- Instrumentation overhead would affect timing metrics

### Scientific Validity
- Matches real-world deployment (users don't see internals)
- External validity: results generalize to any agent with same capabilities
- Avoids confounding agent architecture with paradigm effect

## Threats to Validity

### Internal Validity Threat
Cannot determine *why* an agent made a particular choice.

**Mitigation:** Error taxonomy classifies *what* went wrong. Step-level metrics show *where* in the workflow failure occurred.

### Construct Validity Threat
MCP condition has richer observation (tool call logs) than CodeGen (must infer from code).

**Mitigation:** CodeGen evaluation uses 4-layer pipeline (static/semantic/runtime/artifact) to extract comparable metrics. Final arbiter (Layer 3: Output Quality) is identical for all conditions.

## Benchmark Security Warning

Following SWE-bench contamination findings: the OutputVerifier MUST run as a completely independent process after agent completion. The agent must not be able to tamper with the verification process.

**Implementation:**
1. Agent process terminates
2. Harness collects output files
3. Separate OutputVerifier process runs
4. Results written to JSONL

## Related Files

- [KB-02-final-research-design](final-research-design.md) — Full design
- [KB-00-scope-and-limitations](../00-meta/scope-and-limitations.md) — Limitation 4
- [KB-06-monitor-implementation](../06-implementation/monitor-implementation.md) — Monitor details
