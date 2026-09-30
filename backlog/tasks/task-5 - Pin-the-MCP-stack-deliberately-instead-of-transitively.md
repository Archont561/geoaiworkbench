---
id: TASK-5
title: Pin the MCP stack deliberately instead of transitively
status: To Do
assignee: []
created_date: '2026-09-30 21:44'
updated_date: '2026-09-30 21:53'
labels:
  - orchestration
  - environment
milestone: m-0
dependencies: []
documentation:
  - .knowledge/07-tooling/dependencies-rationale.md
  - .knowledge/07-tooling/phase1-development.md
priority: high
ordinal: 5000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The default environment currently carries mcp 1.30.0, which arrived as a transitive dependency rather than a choice. decision-8 says the server uses standalone fastmcp v4 and decision-9 says the SDK must not float into v2 — neither is expressed anywhere a solver can enforce. Until it is, a routine relock can move the project onto an SDK whose FastMCP class no longer exists, and the failure lands on whoever next touches geoai-mcp.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 pixi.toml declares fastmcp>=4.0,<5 explicitly in the feature that geoai-mcp uses
- [ ] #2 The mcp SDK is either absent or pinned mcp>=1.28,<2; it is never left to float across the v2 boundary
- [ ] #3 pixi.lock records the pins and pixi run verify-packages still passes
- [ ] #4 A short note in AGENTS.md or the pixi.toml comment says why v2 is excluded, pointing at decision-9
<!-- AC:END -->
