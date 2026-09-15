---
id: KB-07-phase7-archival
title: "Phase: Reproducibility & Archival"
category: tooling
subcategory: phase
tags: [tooling, phase, phase7,archival]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-07-toolchain-overview
  - KB-04-crash-safe-persistence
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Tools and workflow for Reproducibility & Archival"
  key_facts:
    - "Tools: pixi.lock, Git LFS 3.5+, Zenodo, pixi pack, GitHub Releases"
  common_questions:
    - "What tools are used for Reproducibility & Archival?"
---

# Phase: Reproducibility & Archival

## Tools

pixi.lock, Git LFS 3.5+, Zenodo, pixi pack, GitHub Releases

## Details

pixi.lock pins full stack (Conda+PyPI); Git LFS for large datasets and reference outputs; Zenodo for DOI-archived release; pixi pack for portable environment tarball; GitHub Releases for tagged v1.0.0

## Key Commands

```bash
pixi pack -e benchmark --platform linux-64; git lfs track 'data/**'
```

## Related Files

- KB-07-toolchain-overview
- KB-04-crash-safe-persistence
