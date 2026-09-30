---
id: decision-7
title: 'Three conditions at 5, 15 and unlimited tools, selected by GEOMCP_TIER'
date: '2026-09-30 21:42'
status: accepted
---
## Context

How many MCP tools to expose. The literature reports degradation beyond roughly 50 tools (Mo et al. 2025), context pollution from MCP itself (Song et al. 2025), and that coherent bundles work best (Wang et al. 2025).

## Decision

Three conditions: MCP-5 (tiers 1-2), MCP-15 (tiers 1-5) and CodeGen (unlimited). One server, one code path, the active tier chosen at runtime by `GEOMCP_TIER`, so the conditions differ in exposed surface and nothing else.

## Consequences

5 and 15 both sit below the reported degradation threshold, which is deliberate: the design samples the rising part of the inverted-U rather than its collapse. `GEOMCP_TIER` becomes a load-bearing environment variable that the tier tests must pin.

Source: `.knowledge/08-technology-decisions/decision-tool-count.md`, `.knowledge/05-mcp-tools/three-condition-experiment.md`.
