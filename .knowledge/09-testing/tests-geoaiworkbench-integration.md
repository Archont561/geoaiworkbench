---
id: KB-09-tests-geoaiworkbench-integration
title: "Tests: geoaiworkbench Integration (32 tests)"
category: testing
subcategory: package-tests
tags: [testing, geoaiworkbench, integration, qgis, bridge]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-09-test-inventory
  - KB-09-critical-tests
  - KB-04-bridge-tcp-protocol
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Integration tests for geoaiworkbench with real QGIS"
  key_facts:
    - "32 integration tests"
    - "Real QGIS Processing execution"
    - "TCP bridge round-trip tests"
    - "Hook injection lifecycle tests"
  common_questions:
    - "How are tools tested with real QGIS?"
    - "How is the bridge tested?"
---

# Tests: geoaiworkbench Integration (32 tests)

## Paradigm Boundary (4 tests) ⭐

- `test_no_execute_code_tool_exposed` — MOST CRITICAL TEST
- `test_no_forbidden_tools_mcp5` — GEOMCP_TIER=5 clean
- `test_no_forbidden_tools_mcp15` — GEOMCP_TIER=15 clean
- `test_exact_tool_count_per_tier` — 5 and 15 exactly

## Tool Execution (12 tests)

- `test_buffer_real_qgis` — Buffer roads layer, verify output
- `test_clip_real_qgis` — Clip to study area
- `test_reproject_real_qgis` — Reproject EPSG:32633 → EPSG:4326
- `test_dissolve_real_qgis` — Dissolve by attribute
- `test_intersection_real_qgis` — Overlay intersection
- `test_difference_real_qgis` — Geometric difference
- `test_union_real_qgis` — Layer union
- `test_spatial_join_real_qgis` — Join by location
- `test_select_by_location_real_qgis` — Select by predicate
- `test_centroid_real_qgis` — Compute centroids
- `test_simplify_real_qgis` — Simplify geometries
- `test_merge_layers_real_qgis` — Merge two layers

## Bridge Protocol (6 tests)

- `test_bridge_connect` — TCP connection established
- `test_bridge_request_response` — JSON-RPC round-trip
- `test_bridge_error_response` — Error code returned
- `test_bridge_layer_not_found` — -32000 error
- `test_bridge_timeout` — 30s timeout handling
- `test_bridge_concurrent` — Multiple simultaneous requests

## Hook Injection (4 tests)

- `test_set_hook` — Monitor receives events
- `test_clear_hook` — No events after clear
- `test_hook_finally_block` — Cleared even on exception
- `test_hook_event_schema` — MonitorEvent fields correct

## Cache (4 tests)

- `test_cache_hit` — Second call uses cache
- `test_cache_ttl` — Expired cache misses
- `test_cache_clear` — Clear between tasks
- `test_cache_isolation` — No cross-task leakage

## Plugin (2 tests)

- `test_plugin_dispatch` — QGIS plugin routes to Processing
- `test_plugin_main_thread` — PyQGIS runs on main thread

## Related Files

- [KB-09-critical-tests](critical-tests.md)
- [KB-04-bridge-tcp-protocol](../04-architecture/bridge-tcp-protocol.md)
