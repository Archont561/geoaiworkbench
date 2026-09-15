---
id: KB-09-tests-geoaibenchmark-unit
title: "Tests: geoaibenchmark Unit (62 tests)"
category: testing
subcategory: package-tests
tags: [testing, geoaibenchmark, unit, monitors, verifier, analyzer]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-09-test-inventory
  - KB-04-package-geoaibenchmark
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Unit tests for geoaibenchmark monitors, verifier, analyzer, statistics"
  key_facts:
    - "62 unit tests"
    - "Monitor event creation and schema"
    - "OutputVerifier OQS computation"
    - "CodeAnalyzer AST extraction"
    - "Statistical test correctness"
  common_questions:
    - "How is OQS tested?"
    - "How is code analysis tested?"
---

# Tests: geoaibenchmark Unit (62 tests)

## MCPMonitor (6 tests)
- `test_wrap_creates_event` — MonitorEvent with correct fields
- `test_wrap_records_duration` — duration_ms populated
- `test_wrap_records_error` — error_type on failure
- `test_wrap_multiple_events` — Event list grows
- `test_event_schema_valid` — Pydantic validation
- `test_event_json_serializable` — JSONL compatible

## CodeGenMonitor (6 tests)
- `test_classify_syntax_error` — SyntaxError → syntax_error
- `test_classify_import_error` — ImportError → import_error
- `test_classify_runtime_error` — RuntimeError → runtime_error
- `test_classify_hallucination` — NameError+QGIS → hallucination
- `test_classify_algorithm_not_found` — "not found" → hallucination
- `test_classify_success` — exit_code=0 → None

## OutputVerifier (12 tests)
- `test_identical_files_oqs_is_1` — ⭐ Perfect match = 1.0
- `test_crs_mismatch_penalty` — Wrong CRS reduces OQS
- `test_feature_count_mismatch` — Count diff reduces OQS
- `test_geometry_invalid` — Invalid geometry reduces OQS
- `test_extent_iou_partial` — Partial overlap IoU
- `test_attribute_missing` — Missing fields reduces OQS
- `test_empty_output` — No features = 0.0
- `test_raster_crs_match` — Raster CRS comparison
- `test_raster_rmse` — RMSE computation
- `test_pass_threshold` — OQS ≥ 0.90 = pass
- `test_fail_threshold` — OQS < 0.90 = fail
- `test_tolerance_5_percent` — Feature count ±5%

## CodeAnalyzer (10 tests)
- `test_extract_processing_run` — Finds processing.run() calls
- `test_extract_algorithm_name` — Extracts "native:buffer"
- `test_extract_parameters` — Extracts param dict
- `test_extract_layer_load` — Finds QgsVectorLayer()
- `test_extract_qgis_init` — Detects initQgis()
- `test_extract_output_save` — Detects writeAsVectorFormat
- `test_broken_code_recovery` — Tree-sitter on syntax error
- `test_dynamic_params` — Marks non-literal as <dynamic>
- `test_alias_detection` — `import processing as p`
- `test_empty_code` — No operations = empty IR

## StepTracker (6 tests)
- `test_step_count` — Correct count from events
- `test_all_steps_completed_is_1` — ⭐ All match = 1.0
- `test_partial_steps` — Partial completion
- `test_step_order` — Order accuracy
- `test_pea_computation` — PEA from params
- `test_backtrack_count` — Repeated calls detected

## Statistics (12 tests)
- `test_anova_significant` — Detects real difference
- `test_anova_not_significant` — No false positive
- `test_mcnemar_paired` — Paired binary test
- `test_chi_square_distribution` — Error type comparison
- `test_bootstrap_ci` — CI contains true mean
- `test_cliffs_delta_large` — Large effect detected
- `test_cliffs_delta_negligible` — Small effect detected
- `test_ttest_rel` — Paired t-test
- `test_tukey_hsd` — Post-hoc comparison
- `test_bonferroni_correction` — α_adj = 0.0083
- `test_spearman_correlation` — Chain length vs LCP
- `test_effect_size_interpretation` — Thresholds correct

## Orchestrator (10 tests)
- `test_run_key_generation` — 1,800 unique keys
- `test_remaining_calculation` — Correct remaining count
- `test_crash_recovery` — Resumes from completed.json
- `test_jsonl_append` — Results appended correctly
- `test_completed_lock` — FileLock prevents corruption
- `test_timeout_handling` — 300s timeout recorded
- `test_dry_run` — --dry-run skips execution
- `test_condition_filter` — --condition mcp5 filters
- `test_agent_filter` — --agent opencode filters
- `test_task_filter` — --task T001 runs single

## Related Files

- [KB-06-verifier-implementation](../06-implementation/verifier-implementation.md)
- [KB-06-metrics-implementation](../06-implementation/metrics-implementation.md)
- [KB-03-statistical-tests](../03-metrics/statistical-tests.md)
