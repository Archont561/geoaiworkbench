---
id: KB-08-qgis-version-3.44
title: "Decision: QGIS Version Pinning"
category: technology-decisions
subcategory: decision
tags: [decision, qgis,version,3.44]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-14-all-decisions-summary
  - KB-15-qgis-pyqgis-docs
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "QGIS Version Pinning — rationale and outcome"
  key_facts:
    - "Target >=3.40 with primary testing on 3.44.x; use flexible constraint in Pixi; pin exact version in pixi.lock; note LTR vs stable in thesis"
  common_questions:
    - "Why was this decision made?"
    - "What were the alternatives?"
---

# Decision: QGIS Version Pinning

## Context

Which QGIS version to target

## Analysis

QGIS 3.40 is current LTR; 3.44 is current stable; conda-forge provides 3.44.x; Docker provides 3.44.14-noble; future 4.0 will bring PyQt6 migration

## Decision

Target >=3.40 with primary testing on 3.44.x; use flexible constraint in Pixi; pin exact version in pixi.lock; note LTR vs stable in thesis

## Impact on Project

This decision affects:
- Implementation architecture
- Dependency configuration (pyproject.toml)
- Thesis Chapter V (Implementation) documentation

## Reversibility

- **Reversible:** Can switch later with moderate effort
- **Cost of reversal:** Update imports, configs, and tests

## Related Files

- KB-15-qgis-pyqgis-docs
