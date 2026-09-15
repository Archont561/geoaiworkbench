---
id: KB-09-test-inventory
title: "Complete Test Inventory (~202 tests)"
category: testing
subcategory: inventory
tags: [testing, inventory, test-list, count]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-09-testing-strategy
  - KB-09-critical-tests
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Complete inventory of all ~202 tests organized by package"
  key_facts:
    - "qgis_utils: 26 tests"
    - "geoaiworkbench: 80 tests (48 unit + 32 integration)"
    - "geoaibenchmark: 76 tests (62 unit + 14 integration)"
    - "Contract tests: ~15 additional"
    - "Paradigm boundary: 5 critical tests"
  common_questions:
    - "How many tests per package?"
    - "What tests exist?"
---

# Complete Test Inventory

## qgis_utils (26 tests)

| # | Test | Type | What It Verifies |
|---|---|---|---|
| 1-5 | test_qgis_app_lifecycle | Unit | Init, yield, cleanup, exception handling |
| 6-10 | test_headless_iface | Unit | All no-op methods return expected values |
| 11-15 | test_resolve_paths | Unit | Conda, Docker, system paths |
| 16-20 | test_init_processing | Integration | Processing algorithms available |
| 21-26 | test_loaded_plugin | Integration | Plugin load/unload cycle |

## geoaiworkbench (80 tests)

### Unit Tests (48)

| # | Test | What It Verifies |
|---|---|---|
| 1-8 | test_models_buffer | BufferInput validators (gt=0, ge=1, output≠input) |
| 9-14 | test_models_clip | ClipInput validators |
| 15-20 | test_models_reproject | ReprojectInput EPSG regex, case normalization |
| 21-26 | test_models_dissolve | DissolveInput validators |
| 27-30 | test_models_spatial_join | Predicate Literal validation |
| 31-34 | test_models_merge | MergeLayersInput min_length=2 |
| 35-38 | test_models_calculate_field | Expression sanitization |
| 39-42 | test_models_simplify | Tolerance gt=0 |
| 43-46 | test_geo_mcp_registration | All 15 tools registered correctly |
| 47-48 | test_server_instructions | Instructions set per tier |

### Integration Tests (32)

| # | Test | What It Verifies |
|---|---|---|
| 1-4 | test_paradigm_boundary | ⭐ No forbidden tools at any tier |
| 5-8 | test_tier_control | GEOMCP_TIER=5 → 5 tools, =15 → 15 tools |
| 9-14 | test_buffer_execution | Real QGIS buffer via bridge |
| 15-18 | test_clip_execution | Real QGIS clip via bridge |
| 19-22 | test_reproject_execution | Real QGIS reproject via bridge |
| 23-26 | test_bridge_protocol | TCP request/response cycle |
| 27-30 | test_hook_injection | set_hook/clear_hook lifecycle |
| 31-32 | test_cache_integration | diskcache layer_info caching |

## geoaibenchmark (76 tests)

### Unit Tests (62)

| # | Test | What It Verifies |
|---|---|---|
| 1-6 | test_mcp_monitor_wrap | MCPMonitor event creation |
| 7-12 | test_codegen_monitor_classify | Error type classification |
| 13-18 | test_verifier_identical | OQS=1.0 for identical files |
| 19-24 | test_verifier_crs_mismatch | OQS penalty for wrong CRS |
| 25-30 | test_verifier_geometry_invalid | OQS penalty for invalid geometry |
| 31-36 | test_code_analyzer_processing | AST extraction of processing.run() |
| 37-40 | test_code_analyzer_layer_load | QgsVectorLayer detection |
| 41-44 | test_code_analyzer_broken | Tree-sitter recovery on syntax errors |
| 45-48 | test_step_tracker | Step count, order, PEA |
| 49-54 | test_statistics_anova | ANOVA computation correctness |
| 55-58 | test_statistics_bootstrap | Bootstrap CI computation |
| 59-62 | test_statistics_cliffs_delta | Effect size computation |

### Integration Tests (14)

| # | Test | What It Verifies |
|---|---|---|
| 1-4 | test_harness_mcp_run | Full MCP task run lifecycle |
| 5-8 | test_harness_codegen_run | Full CodeGen task run lifecycle |
| 9-12 | test_orchestrator_resume | Crash recovery from completed.json |
| 13-14 | test_orchestrator_parallel | Concurrent run key management |

## Contract Tests (~15 additional)

See [KB-09-contract-tests](contract-tests.md) for details.

## Adversarial Tests (5)

See [KB-09-adversarial-tests](adversarial-tests.md) for details.

## Related Files

- [KB-09-testing-strategy](testing-strategy.md)
- [KB-09-critical-tests](critical-tests.md)
- [KB-09-contract-tests](contract-tests.md)
- [KB-09-adversarial-tests](adversarial-tests.md)
