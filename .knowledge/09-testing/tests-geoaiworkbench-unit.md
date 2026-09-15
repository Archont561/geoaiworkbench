---
id: KB-09-tests-geoaiworkbench-unit
title: "Tests: geoaiworkbench Unit (48 tests)"
category: testing
subcategory: package-tests
tags: [testing, geoaiworkbench, unit, models, mcp]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-09-test-inventory
  - KB-09-contract-tests
  - KB-04-package-geoaiworkbench
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Unit tests for geoaiworkbench models and MCP server"
  key_facts:
    - "48 unit tests"
    - "Pydantic validator tests for all 15 tools"
    - "MCP tool registration tests"
    - "Server instruction tests"
  common_questions:
    - "What model validators are tested?"
    - "How is MCP registration tested?"
---

# Tests: geoaiworkbench Unit (48 tests)

## Model Validator Tests (38 tests)

### Buffer Validators (8)
- `test_buffer_valid` — Valid input accepted
- `test_buffer_negative_distance` — gt=0 rejects -100
- `test_buffer_zero_distance` — gt=0 rejects 0
- `test_buffer_zero_segments` — ge=1 rejects 0
- `test_buffer_output_equals_input` — Cross-field rejects
- `test_buffer_default_segments` — Default is 5
- `test_buffer_dissolve_default` — Default is False
- `test_buffer_large_distance` — Accepts 1e6

### Clip Validators (4)
- `test_clip_valid`, `test_clip_output_equals_input`, `test_clip_output_equals_overlay`, `test_clip_all_same`

### Reproject Validators (6)
- `test_reproject_valid`, `test_reproject_invalid_crs`, `test_reproject_lowercase_epsg` (normalized to upper), `test_reproject_wgs84_string` (rejected), `test_reproject_output_equals_input`, `test_reproject_empty_crs`

### Tier 3-5 Validators (20)
- dissolve, intersection, difference, union, spatial_join, select_by_location, centroid, simplify, merge_layers, calculate_field
- Each has: valid input, output≠input, specific validators (predicate Literal, min_length, tolerance gt=0, expression sanitization)

## MCP Server Tests (10)

- `test_all_tools_registered` — 15 tools in tool manager
- `test_tool_names_match` — Exact name set
- `test_tool_descriptions_nonempty` — All have docstrings
- `test_tool_annotations_present` — All have readOnlyHint etc.
- `test_server_instructions_set` — Instructions non-empty
- `test_mcp5_tier_tools` — GEOMCP_TIER=5 → 5 tools
- `test_mcp15_tier_tools` — GEOMCP_TIER=15 → 15 tools
- `test_tier_default` — Default is 5
- `test_forbidden_not_in_any_tier` — No execute_code at any tier
- `test_sync_tools` — All tools are synchronous

## Related Files

- [KB-06-models-pydantic](../06-implementation/models-pydantic.md)
- [KB-09-contract-tests](contract-tests.md)
