---
id: KB-14-decision-infrastructure-libs
title: "Decision: Infrastructure: Mature Libraries over Custom"
category: decisions-log
subcategory: decision
tags: [decision, decision,infrastructure,libs]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-14-all-decisions-summary
  - KB-07-infrastructure-libraries
  - KB-07-dependencies-rationale
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Decision record: Infrastructure: Mature Libraries over Custom"
  key_facts:
    - "Choice: Use mature libraries for all commodity infrastructure. Novel GIS/MCP/benchmark logic in our code only. 10 infrastructure packages added to pyproject.toml."
    - "Rejected: Custom cache.py, retry.py, logging.py (original)"
  common_questions:
    - "Why was this decision made?"
    - "What was the alternative?"
---

# Decision: Infrastructure: Mature Libraries over Custom

## Context

Whether to use existing libraries for caching, retry, logging

## Analysis

Initial plan was custom implementations. Web search revealed mature alternatives: diskcache (persistent cache), tenacity (retries), structlog (JSON logging), filelock (concurrency), platformdirs (paths). All well-maintained, well-tested.

## Decision

Use mature libraries for all commodity infrastructure. Novel GIS/MCP/benchmark logic in our code only. 10 infrastructure packages added to pyproject.toml.

## Rejected Alternative

Custom cache.py, retry.py, logging.py (original)

## Rationale

Reinventing wheels; less reliable; more maintenance

## Impact

pyproject.toml, all implementation files

## Reversibility

Low — swap implementations

## Evidence

See related files for supporting evidence.

## Related Files

- KB-14-all-decisions-summary
- KB-07-infrastructure-libraries
- KB-07-dependencies-rationale
