---
id: KB-08-pixi-vs-uv
title: "Decision: Pixi vs uv Package Manager"
category: technology-decisions
subcategory: decision
tags: [decision, pixi,vs,uv]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-14-all-decisions-summary
  - KB-15-pixi-docs
  - KB-07-pixi-guide
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Pixi vs uv Package Manager — rationale and outcome"
  key_facts:
    - "Pixi 0.80.0 as primary; conda-forge for native deps; PyPI via Pixi for Python-only; pixi.lock committed to Git"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: Pixi vs uv Package Manager

## Context

Package manager for mixed Conda+PyPI project

## Analysis

uv cannot install QGIS/GDAL/GEOS/PROJ natively (PyPI only); Pixi uses rattler Conda solver + uv internally for PyPI; Pixi provides lockfile for full native stack; Pixi has task runner with env vars (GEOMCP_TIER); Pixi has multi-environment support

## Decision

Pixi 0.80.0 as primary; conda-forge for native deps; PyPI via Pixi for Python-only; pixi.lock committed to Git

## Impact on Project

This decision affects:
- Implementation architecture
- Dependency configuration (pyproject.toml)
- Thesis Chapter V (Implementation) documentation

## Reversibility

- **Reversible:** Can switch later with moderate effort
- **Cost of reversal:** Update imports, configs, and tests

## Related Files

- KB-15-pixi-docs
- KB-07-pixi-guide
