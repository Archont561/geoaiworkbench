---
id: KB-13-week2-mcp-server
title: "Week 2: MCP Server"
category: roadmap
subcategory: weekly
tags: [roadmap, week2,mcp,server, tdd]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-13-two-month-roadmap
  - KB-13-critical-path
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Week 2: MCP Server — daily TDD breakdown"
  key_facts:
    - "Focus: FastMCP 4.0.3 server with 15 tools, Pydantic models, tier control"
    - "Deliverable: 48 tests passing"
  common_questions:
    - "What do I do this week?"
    - "What are the daily tasks?"
---

# Week 2: MCP Server

## Focus

FastMCP 4.0.3 server with 15 tools, Pydantic models, tier control

## Daily Breakdown

### Monday
Day 1: Add fastmcp>=4.0 to pyproject.toml; write failing tests for all 15 Pydantic input/output models (RED); implement models.py (GREEN)

### Tuesday
Day 2: Implement Tier 1-2 tools (layer_info, layer_statistics, buffer, clip, reproject) with @mcp.tool; write tool registration tests

### Wednesday
Day 3: Implement Tier 3-5 tools (dissolve, intersection, difference, union, spatial_join, select_by_location, centroid, simplify, merge_layers, calculate_field); implement GEOMCP_TIER env var and _enforce_tier()

### Thursday
Day 4: Implement paradigm boundary assertion; write test_no_execute_code_tool_exposed (MOST CRITICAL); add SERVER_INSTRUCTIONS for MCP-5 and MCP-15; add MCP annotations to all tools

### Friday
Day 5: Write integration tests for tool execution with mock QGIS; verify MCP Inspector connects; document tool specs (.knowledge/ Batch 6); MILESTONE M2

## Week Deliverable

48 tests passing

## Success Criteria

This week closes backlog milestone `m-1` (M2 MCP server complete). The criteria are the
milestone's, so they are kept there rather than restated here:

```
pixi run backlog -- milestone list
```

## TDD Cycle

Each day follows RED → GREEN → REFACTOR:
1. **RED:** Write failing test for the day's feature
2. **GREEN:** Implement minimum code to pass
3. **REFACTOR:** Clean up, run full test suite

## Risks This Week

- Delays cascade to subsequent weeks
- QGIS/PyQGIS compatibility issues may require debugging
- Agent API rate limits may slow pilot runs

## Related Files

- KB-13-two-month-roadmap
- KB-13-critical-path
