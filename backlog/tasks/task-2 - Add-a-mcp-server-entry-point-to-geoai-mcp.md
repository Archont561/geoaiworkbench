---
id: TASK-2
title: Add a mcp server entry point to geoai-mcp
status: To Do
assignee: []
created_date: '2026-09-30 19:52'
updated_date: '2026-09-30 21:53'
labels:
  - feature
milestone: m-1
dependencies:
  - TASK-5
documentation:
  - .knowledge/05-mcp-tools/tool-spec-overview.md
  - .knowledge/05-mcp-tools/server-instructions.md
priority: medium
ordinal: 2000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
geoai-mcp is a scaffold: a manifest, an import and a version test. The fifteen tools belong to the feature repository, but the seam they plug into does not — the console entry point, the tier variable and the "this server exposes nothing" report are what makes the package testable here, and what the paradigm-boundary invariant (TASK-7) needs something to interrogate. Without them the first tool written elsewhere has nowhere to arrive.

The tool specifications themselves are in .knowledge/05-mcp-tools/ (21 files) and stay there; this task is the entry point and the tier contract only.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 geoai-mcp exposes a console entry point that starts an MCP server over stdio, using standalone fastmcp v4 per decision-8
- [ ] #2 The server registers zero tools and says so clearly on start, so an empty registry is never mistaken for a working tier
- [ ] #3 GEOMCP_TIER is read and validated at startup: 5 and 15 are accepted, anything else fails with a message naming the accepted values
- [ ] #4 A test starts the server in-process and asserts the entry point, the tier validation and the zero-tool report
- [ ] #5 The entry point is reachable from the default environment after pixi install, proved the way verify-packages proves the imports
<!-- AC:END -->
