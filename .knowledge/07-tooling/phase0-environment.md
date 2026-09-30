---
id: KB-07-phase0-environment
title: "Phase: Environment Setup"
category: tooling
subcategory: phase
tags: [tooling, phase, phase0,environment]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-07-toolchain-overview
  - KB-15-pixi-docs
  - backlog-decision-1
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Tools and workflow for Environment Setup"
  key_facts:
    - "Tools: Pixi 0.80, conda-forge, Docker, Git, Python 3.12"
  common_questions:
    - "What tools are used for Environment Setup?"
---

# Phase: Environment Setup

## Tools

Pixi 0.80, conda-forge, Docker, Git, Python 3.12

## Details

Pixi manages Conda+PyPI in one lockfile; conda-forge provides QGIS/GDAL/GEOS/PROJ natively; Docker qgis/qgis:3.44.14-noble as fallback CI image; Git 2.45+ for VCS; Python 3.12 required by QGIS 3.40+ and FastMCP 4.x

## Key Commands

```bash
pixi install; pixi run test; docker run qgis/qgis
```

## Related Files

- KB-07-toolchain-overview
- KB-15-pixi-docs
- backlog-decision-1
