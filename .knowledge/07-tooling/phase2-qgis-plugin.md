---
id: KB-07-phase2-qgis-plugin
title: "Phase: QGIS Plugin Development"
category: tooling
subcategory: phase
tags: [tooling, phase, phase2,qgis,plugin]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [7, 15]
related:
  - KB-07-toolchain-overview
  - KB-15-qgis-pyqgis-docs
  - KB-06-plugin-implementation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Tools and workflow for QGIS Plugin Development"
  key_facts:
    - "Tools: Plugin Builder 3, Plugin Reloader, qgis-plugin-ci 2.10.0, MCP Inspector, QGIS Python Console"
  common_questions:
    - "What tools are used for QGIS Plugin Development?"
---

# Phase: QGIS Plugin Development

## Tools

Plugin Builder 3, Plugin Reloader, qgis-plugin-ci 2.10.0, MCP Inspector, QGIS Python Console

## Details

Plugin Builder scaffolds initial structure; Plugin Reloader enables iteration without restart; qgis-plugin-ci automates packaging and release; MCP Inspector (npx @modelcontextprotocol/inspector) for debugging MCP tools; QGIS Python Console for quick PyQGIS prototyping

## Key Commands

```bash
npx @modelcontextprotocol/inspector python scripts/start_mcp_server.py
```

## Related Files

- KB-07-toolchain-overview
- KB-15-qgis-pyqgis-docs
- KB-06-plugin-implementation
