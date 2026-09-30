---
id: decision-2
title: Target QGIS 3.44 and split the environments over the icu pin
date: '2026-09-30 21:42'
status: accepted
---
## Context

QGIS 3.40 is the current LTR and 3.44 the current stable; conda-forge ships 3.44.x. Separately, QGIS pins icu 78.3 while bun pins icu 75.1, and no single solve satisfies both.

## Decision

Target `>=3.40` with primary testing on 3.44.x, flexible in `pixi.toml` and exact in `pixi.lock`. Split the workspace into two environments — `default` (QGIS, Python toolchain, git instruments) and `bun` (the JavaScript runtime) — so the icu conflict disappears and the QGIS floor stops being decided by bun.

## Consequences

Every task must declare the environment it needs, every nested `pixi run` must name `-e`, and the offline transport must pack both environments or restore a machine that cannot run turbo. Implemented: TASK-1 (Done).

Source: `AGENTS.md`.
Supersedes `.knowledge/08-technology-decisions/qgis-version-3.44.md` — deleted from the knowledge base; this decision is that content.
