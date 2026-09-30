---
id: decision-1
title: 'Pixi is the package manager, not uv or bare conda'
date: '2026-09-30 21:42'
status: accepted
---
## Context

The project mixes conda-only native dependencies (QGIS, GDAL, GEOS, PROJ) with PyPI-only Python packages, and needs one lockfile covering both plus a task runner that can set per-task environment variables such as `GEOMCP_TIER`.

## Decision

Pixi is the package manager. conda-forge supplies the native stack, PyPI packages are resolved through Pixi (which uses uv internally), and `pixi.lock` is committed. uv alone was rejected: it cannot install QGIS/GDAL/GEOS/PROJ, which are the reason this project needs a solver at all.

## Consequences

`pixi.toml` becomes the single owner of environments and tasks, and `pixi.lock` becomes the definition of a reproducible run. Reversible at moderate cost. Realised in this repository: see TASK-1, `pixi.toml` and `scripts/ci.sh`.

Supersedes `.knowledge/08-technology-decisions/pixi-vs-uv.md`, `.knowledge/14-decisions-log/decision-pixi.md` — deleted from the knowledge base; this decision is that content.
