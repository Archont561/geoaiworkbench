---
id: decision-5
title: CLI agents are treated as black boxes
date: '2026-09-30 21:42'
status: accepted
---
## Context

The comparison is between paradigms, not between instrumentation harnesses. Modifying an agent's internals would break fairness, create vendor lock-in, require per-agent code and distort timing metrics.

## Decision

Agents are observed from the outside only: MCP logs and output files, plus generated code files and runtime traces in the CodeGen condition. No agent internals, no prompt surgery, no per-condition tuning. Any agent is swappable.

## Consequences

Some questions become unanswerable — token-level reasoning, internal retries the agent does not surface. In exchange the design matches real deployment and a fifth agent costs a config file rather than a port.

Source: `.knowledge/02-research-design/black-box-constraint.md`.
Supersedes `.knowledge/08-technology-decisions/black-box-vs-instrumented.md` — deleted from the knowledge base; this decision is that content.
