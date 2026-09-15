---
id: KB-07-phase1-development
title: "Phase: Code Development"
category: tooling
subcategory: phase
tags: [tooling, phase, phase1,development]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-07-toolchain-overview
  - KB-09-testing-strategy
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Tools and workflow for Code Development"
  key_facts:
    - "Tools: VS Code 1.95+, Pylance, Ruff 0.6+, mypy 1.11+, pytest 8+, pytest-qgis, pytest-xdist"
  common_questions:
    - "What tools are used for Code Development?"
---

# Phase: Code Development

## Tools

VS Code 1.95+, Pylance, Ruff 0.6+, mypy 1.11+, pytest 8+, pytest-qgis, pytest-xdist

## Details

VS Code with Pylance for type-aware autocomplete; Ruff replaces flake8+black+isort (10-100x faster); mypy catches Pydantic misuse; pytest-qgis provides qgis_app and qgis_processing fixtures; pytest-xdist for parallel test execution

## Key Commands

```bash
pixi run -e dev lint; pixi run -e dev typecheck; pixi run -e test test-parallel
```

## Related Files

- KB-07-toolchain-overview
- KB-09-testing-strategy
