---
id: KB-14-decision-pixi
title: "Decision: Package Manager: Pixi over uv"
category: decisions-log
subcategory: decision
tags: [decision, decision,pixi]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [all]
related:
  - KB-14-all-decisions-summary
  - KB-08-pixi-vs-uv
  - KB-15-pixi-docs
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Decision record: Package Manager: Pixi over uv"
  key_facts:
    - "Choice: Pixi 0.80.0 as primary. conda-forge for native deps. PyPI via Pixi for Python-only. pixi.lock committed to Git."
    - "Rejected: uv with system QGIS (original)"
  common_questions:
    - "Why was this decision made?"
    - "What was the alternative?"
---

# Decision: Package Manager: Pixi over uv

## Context

Package manager for mixed Conda+PyPI project

## Analysis

uv cannot install QGIS/GDAL/GEOS/PROJ natively (PyPI only). Pixi uses rattler Conda solver + uv internally. Provides lockfile for full native stack. Task runner with env vars (GEOMCP_TIER). Multi-environment support.

## Decision

Pixi 0.80.0 as primary. conda-forge for native deps. PyPI via Pixi for Python-only. pixi.lock committed to Git.

## Rejected Alternative

uv with system QGIS (original)

## Rationale

Cannot manage QGIS natively; system QGIS version uncontrolled

## Impact

pyproject.toml, pixi.lock, CI workflow

## Reversibility

Moderate — change package manager commands

## Evidence

See related files for supporting evidence.

## Related Files

- KB-14-all-decisions-summary
- KB-08-pixi-vs-uv
- KB-15-pixi-docs
