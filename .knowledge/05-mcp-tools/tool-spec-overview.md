---
id: KB-05-tool-spec-overview
title: "GeoMCP Tool Specification Overview"
category: mcp-tools
subcategory: overview
tags: [mcp, tools, overview, tiers, design-principles, geomcp]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8, 15]
related:
  - KB-04-package-geoaiworkbench
  - KB-04-paradigm-boundary
  - KB-05-server-instructions
  - KB-05-mcp-annotations
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Overview of all 15 GeoMCP tools organized by tier with design principles"
  key_facts:
    - "15 tools in 5 tiers"
    - "MCP-5 = Tier 1-2 (5 tools), MCP-15 = Tier 1-5 (15 tools)"
    - "8 design principles (P1-P8)"
    - "All tools use PyQGIS exclusively (no geopandas/shapely in server)"
    - "Tier control via GEOMCP_TIER env var"
  common_questions:
    - "How many tools does GeoMCP expose?"
    - "What are the tiers?"
    - "What design principles govern the tools?"
---

# GeoMCP Tool Specification Overview

## Tool Count and Tiers

| Tier | Name | Tools | MCP-5 | MCP-15 |
|---|---|---|---|---|
| 1 | Inspection | 2 | ✅ | ✅ |
| 2 | Core Geoprocessing | 3 | ✅ | ✅ |
| 3 | Extended Geoprocessing | 6 | ❌ | ✅ |
| 4 | Geometry Operations | 2 | ❌ | ✅ |
| 5 | Data Management | 2 | ❌ | ✅ |
| **Total** | | **15** | **5** | **15** |

## Complete Tool List

### Tier 1: Inspection (Read-Only)

| # | Tool | QGIS Algorithm | Purpose |
|---|---|---|---|
| 1 | `layer_info` | Direct PyQGIS | Layer metadata, CRS, geometry, fields |
| 2 | `layer_statistics` | `qgis:basicstatisticsforfields` | Numeric field statistics |

### Tier 2: Core Geoprocessing

| # | Tool | QGIS Algorithm | Purpose |
|---|---|---|---|
| 3 | `buffer` | `native:buffer` | Geometric buffer zones |
| 4 | `clip` | `native:clip` | Clip by overlay geometry |
| 5 | `reproject` | `native:reprojectlayer` | CRS transformation |

### Tier 3: Extended Geoprocessing (MCP-15 only)

| # | Tool | QGIS Algorithm | Purpose |
|---|---|---|---|
| 6 | `dissolve` | `native:dissolve` | Merge features by attribute |
| 7 | `intersection` | `native:intersection` | Geometric intersection |
| 8 | `difference` | `native:difference` | Subtract overlay from input |
| 9 | `union` | `native:union` | Combine all features from both layers |
| 10 | `spatial_join` | `native:joinattributesbylocation` | Join attributes by spatial relationship |
| 11 | `select_by_location` | `native:selectbylocation` | Select features by spatial predicate |

### Tier 4: Geometry Operations (MCP-15 only)

| # | Tool | QGIS Algorithm | Purpose |
|---|---|---|---|
| 12 | `centroid` | `native:centroids` | Compute feature centroids |
| 13 | `simplify` | `native:simplifygeometries` | Reduce geometry complexity |

### Tier 5: Data Management (MCP-15 only)

| # | Tool | QGIS Algorithm | Purpose |
|---|---|---|---|
| 14 | `merge_layers` | `native:mergevectorlayers` | Combine multiple layers |
| 15 | `calculate_field` | `native:fieldcalculator` | Compute new attribute values |

## 8 Design Principles

| ID | Principle | Rationale |
|---|---|---|
| **P1** | No code execution tools | Paradigm boundary — most critical |
| **P2** | Structured Pydantic I/O only | Type safety, validation, schema generation |
| **P3** | Read-only by default | Tier 1 tools don't modify anything |
| **P4** | Explicit output layer naming | No silent overwrites |
| **P5** | Behavioral contracts per tool | Documented invariants for each tool |
| **P6** | MCP annotations | readOnlyHint, destructiveHint, idempotentHint |
| **P7** | Server instructions | Cross-tool workflow guidance |
| **P8** | Tiered tool exposure | Runtime tier control (5 or 15) |

## Implementation Constraints

- **PyQGIS only:** No geopandas, shapely, or pyproj in MCP server code
- **Processing algorithms:** All geoprocessing via `processing.run()`
- **Sync execution:** Tools are synchronous (FastMCP runs on worker threads)
- **Structured output:** All tools return Pydantic models serialized to JSON
- **Error handling:** `ToolError` exceptions for actionable error messages

## Tool Description Guidelines

Each tool description follows this pattern:

1. **What it does** (one sentence)
2. **When to use it** (use case)
3. **What it returns** (output summary)
4. **What it does NOT do** (boundary)
5. **Prerequisites** (e.g., "Use layer_info first if CRS unknown")

Descriptions are kept **short** — cross-tool workflow rules go in server instructions.

## Tier Control Mechanism

```bash
# MCP-5 condition
GEOMCP_TIER=5 pixi run mcp-server

# MCP-15 condition
GEOMCP_TIER=15 pixi run mcp-server
```

Implementation: `_enforce_tier()` removes Tier 3-5 tools from FastMCP tool manager when `GEOMCP_TIER=5`.

## Related Files

- Individual tool specs: `tool-*.md` (15 files)
- [KB-05-server-instructions](server-instructions.md)
- [KB-05-mcp-annotations](mcp-annotations.md)
- [KB-05-forbidden-tools](forbidden-tools.md)
- [KB-05-tool-selection-decision-tree](tool-selection-decision-tree.md)
- [KB-05-three-condition-experiment](three-condition-experiment.md)
