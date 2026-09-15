---
id: KB-04-package-geoaiworkbench
title: "Package: geoaiworkbench"
category: architecture
subcategory: package
tags: [package, geoaiworkbench, mcp-server, plugin, bridge, tools]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 7, 15]
related:
  - KB-04-system-architecture
  - KB-05-tool-spec-overview
  - KB-04-bridge-tcp-protocol
  - KB-04-paradigm-boundary
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "QGIS plugin + MCP server + TCP bridge package"
  key_facts:
    - "FastMCP 4.0.3 server with 5 or 15 tools"
    - "TCP bridge to QGIS plugin"
    - "Pydantic v2 models for all tool I/O"
    - "Tier control via GEOMCP_TIER env var"
    - "Paradigm boundary enforced at import time"
    - "80 tests (48 unit + 32 integration)"
  common_questions:
    - "What is in geoaiworkbench?"
    - "How does the MCP server work?"
    - "How does tier control work?"
---

# Package: geoaiworkbench

## Purpose

Contains the GeoMCP plugin: MCP server, TCP bridge, QGIS plugin, and all Pydantic models.

## Components

### models.py — Pydantic v2 Schemas

All tool input/output models. See [KB-06-models-pydantic](../06-implementation/models-pydantic.md).

**MCP-5 tools (Tier 1-2):**
- `LayerInfoInput` / `LayerInfoOutput`
- `LayerStatisticsInput` / `LayerStatisticsOutput`
- `BufferInput` / `BufferOutput`
- `ClipInput` / `ClipOutput`
- `ReprojectInput` / `ReprojectOutput`

**MCP-15 additional tools (Tier 3-5):**
- `DissolveInput` / `DissolveOutput`
- `IntersectionInput` / `IntersectionOutput`
- `DifferenceInput` / `DifferenceOutput`
- `UnionInput` / `UnionOutput`
- `SpatialJoinInput` / `SpatialJoinOutput`
- `SelectByLocationInput` / `SelectByLocationOutput`
- `CentroidInput` / `CentroidOutput`
- `SimplifyInput` / `SimplifyOutput`
- `MergeLayersInput` / `MergeLayersOutput`
- `CalculateFieldInput` / `CalculateFieldOutput`

**Shared:**
- `MonitorEvent` — Unified trajectory event schema
- `OpenCodeConfig` — Agent config structure

### geo_mcp.py — FastMCP Server

The core MCP server. See [KB-06-geo-mcp-server](../06-implementation/geo-mcp-server.md).

**Key features:**
- `from fastmcp import FastMCP` (standalone v4.0.3)
- `@mcp.tool` decorator (no parentheses)
- `SERVER_INSTRUCTIONS` for cross-tool guidance
- MCP annotations on all tools
- Tier control via `GEOMCP_TIER` env var
- Paradigm boundary assertion at import time

### bridge.py — TCP Socket Bridge

Connects standalone MCP server to QGIS plugin. See [KB-04-bridge-tcp-protocol](bridge-tcp-protocol.md).

**Protocol:**
```
MCP Server → JSON request → TCP → QGIS Bridge → PyQGIS → JSON response → TCP → MCP Server
```

### plugin.py — QGIS Plugin

Thin bridge host running inside QGIS main thread. See [KB-06-plugin-implementation](../06-implementation/plugin-implementation.md).

**Responsibilities:**
- Listen on TCP port 9876
- Receive tool requests from MCP server
- Execute via PyQGIS on main thread
- Return structured JSON results

### acp_client.py — HookableACPClient (Optional)

ACP client for editor-agent communication. See [KB-04-hook-injection](hook-injection-pattern.md).

## File Structure

```
geoaiworkbench/
├── __init__.py
├── models.py           # All Pydantic v2 schemas
├── geo_mcp.py          # FastMCP server (standalone process)
├── bridge.py           # TCP socket bridge
├── plugin.py           # QGIS plugin (thin bridge host)
├── acp_client.py       # HookableACPClient (optional)
└── metadata.txt        # QGIS plugin metadata
```

## Dependencies

```
geoaiworkbench → qgis_utils (headless QGIS)
geoaiworkbench → fastmcp >= 4.0
geoaiworkbench → pydantic >= 2.0
geoaiworkbench → structlog (logging)
geoaiworkbench → diskcache (layer_info caching)
```

## Testing

80 tests (48 unit + 32 integration):
- Tool contract tests (Pydantic validators)
- Paradigm boundary tests (no execute_code)
- Tier control tests (5 vs 15 tools)
- Bridge protocol tests
- MCP server integration tests

## Related Files

- [KB-05-tool-spec-overview](../05-mcp-tools/tool-spec-overview.md) — Tool specifications
- [KB-04-paradigm-boundary](paradigm-boundary.md) — Boundary enforcement
- [KB-04-bridge-tcp-protocol](bridge-tcp-protocol.md) — Bridge details
