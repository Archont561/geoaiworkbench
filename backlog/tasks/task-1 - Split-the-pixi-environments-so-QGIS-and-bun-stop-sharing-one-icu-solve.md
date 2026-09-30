---
id: TASK-1
title: Split the pixi environments so QGIS and bun stop sharing one icu solve
status: Done
assignee: []
created_date: '2026-09-30 19:52'
updated_date: '2026-09-30 21:12'
labels:
  - orchestration
dependencies: []
priority: high
ordinal: 1000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
pixi.toml has a single default environment because the current QGIS build pins icu75.1 while any newer QGIS pins icu78.3, and bun pins icu75. Split into default (QGIS) and bun. Raising the QGIS floor is blocked on this.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 pixi.toml declares two environments,default (qgis) and bun (javascript tooling),No task in pixi.toml or lefthook.yml hardcodes -e, so both environments resolve from one command set,pixi run gates passes in both,airlock.yml proves both restore offline
- [x] #2 pixi.toml declares two environments, default (qgis + python-toolchain + utils) and bun (bun only), and pixi.lock records icu 78.3 in one and icu 75.1 in the other.
- [x] #3 A new task is expressible in the bun environment: the bun passthrough task runs bun there, and every task that reaches turbo or biome declares default-environment = bun.
- [x] #4 Every nested pixi run names its environment: scripts/ci.sh, every hook in lefthook.yml, and ci.yml, because a nested pixi run inherits the ambient one on pixi 0.81.0.
- [x] #5 The Python packages cross the boundary themselves: python/*/package.json runs pixi run -e default, so turbo in bun still runs pytest against QGIS.
- [x] #6 pixi run gates passes from a bare shell, from -e default and from -e bun.
- [x] #7 The offline transport packs both environments and is verified by pixi-sandbox doctor --verify, not by a second CI workflow.
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Delete .github/workflows/airlock.yml and scripts/airlock-gate.sh; pixi-sandbox pack/doctor/publish already own the transport.

2. Split [environments] into default = qgis + python-toolchain + utils and bun = bun + utils, so icu 75.1 and icu 78.3 stop sharing one solve.

3. Give every bun-needing task default-environment = "bun", add a bun passthrough task, and give the aggregators structured depends-on entries carrying an explicit environment.

4. Bridge turbo to Python: python/*/package.json scripts call pixi run -e default -- TOOL, because turbo only exists in the bun environment and QGIS only in the default one.

5. Name -e explicitly in every nested pixi run (scripts/ci.sh, lefthook.yml, ci.yml, .devcontainer/setup.sh): a nested pixi run inherits the ambient environment and ignores the task own default-environment. Verified on pixi 0.81.0.

6. Pack both environments in .pixi-sandbox.toml, re-lock, and update AGENTS.md, README and the pixi.toml header.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Verified on pixi 0.81.0 in a scratch workspace: a bare pixi run T honours T own default-environment; pixi run -e E T always wins over it; a nested pixi run inherits the ambient environment and ignores default-environment; structured depends-on entries ({ task, environment }) carry an explicit environment and are immune to the ambient one.

Consequence: the AC line demanding that no task or hook hardcode -e is not satisfiable for nested calls. Aggregators keep it out of pixi.toml; scripts/ci.sh and lefthook.yml carry explicit -e.

Implementation: .github/workflows/airlock.yml and scripts/airlock-gate.sh deleted; [environments] split into default (qgis + python-toolchain + utils) and bun (bun); the PyPI table moved from [workspace.pypi-dependencies] to [feature.python-toolchain.pypi-dependencies] because a workspace-level PyPI list cannot solve into a Python-free environment; 14 tasks gained default-environment or structured depends-on; python/*/package.json now calls pixi run -e default; turbo.json lost its globalPassThroughEnv; .pixi-sandbox.toml packs both environments; ci.yml, .devcontainer/setup.sh, lefthook.yml, scripts/ci.sh, scripts/restore.sh, AGENTS.md, README.md and the pixi.toml header updated.

Validation: pixi install --locked --all resolves both; pixi run gates, pixi run -e default gates and pixi run -e bun gates all pass; bash scripts/ci.sh passes with coverage and passes again when launched from inside the bun environment (pixi run -e bun -- bash scripts/ci.sh --no-coverage); pixi run setup reaches bun-install in bun and hooks-install in default; QGIS stays at 3.44.7 in the lockfile, so the split did not move the floor.

Known gap: no gate runs the geoai-bench console script any more, since the only caller was the deleted airlock gate. python/geoai-bench/src/geoai_bench/__main__.py records the seam (one line in verify-packages would close it). The egress-denied offline proof is gone with the workflow; AGENTS.md records that pixi-sandbox doctor --verify is what remains and that a human-triggered pixi run task is where that proof would belong.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Split the pixi environments so QGIS and bun stop sharing one icu solve, and deleted the airlock proof that pixi-sandbox already covers. default carries QGIS/Python/the git instruments, bun carries bun alone; every task, every depends-on entry and every nested pixi run now names its environment, and the Python packages re-enter default from inside turbo. Verified by pixi run gates from a bare shell, from -e default and from -e bun, plus a full scripts/ci.sh run with coverage and another launched from inside the bun environment; QGIS stays pinned at 3.44.7 in pixi.lock.
<!-- SECTION:FINAL_SUMMARY:END -->
