---
id: KB-09-tests-geoaibenchmark-integration
title: "Tests: geoaibenchmark Integration (14 tests)"
category: testing
subcategory: package-tests
tags: [testing, geoaibenchmark, integration, harness, orchestrator]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-09-test-inventory
  - KB-06-harness-implementation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Integration tests for full task run lifecycle"
  key_facts:
    - "14 integration tests"
    - "Full MCP task run lifecycle"
    - "Full CodeGen task run lifecycle"
    - "Crash recovery end-to-end"
  common_questions:
    - "How is a full task run tested?"
    - "How is crash recovery tested?"
---

# Tests: geoaibenchmark Integration (14 tests)

## Harness MCP Run (4 tests)
- `test_harness_mcp5_success` — Full MCP-5 run, task passes
- `test_harness_mcp15_success` — Full MCP-15 run, task passes
- `test_harness_mcp_timeout` — Agent exceeds 300s
- `test_harness_mcp_hook_cleanup` — Monitor cleared in finally

## Harness CodeGen Run (4 tests)
- `test_harness_codegen_success` — Full CodeGen run, task passes
- `test_harness_codegen_syntax_error` — Agent produces broken code
- `test_harness_codegen_runtime_error` — Code fails at runtime
- `test_harness_codegen_four_layers` — Static/semantic/runtime/artifact scores

## Orchestrator Resume (4 tests)
- `test_orchestrator_fresh_start` — All 1,800 keys remaining
- `test_orchestrator_partial_resume` — 500 done, 1,300 remaining
- `test_orchestrator_complete` — All done, nothing to run
- `test_orchestrator_corrupted_json` — Rebuilds from JSONL

## Orchestrator Parallel (2 tests)
- `test_parallel_no_duplicate` — Two workers don't run same key
- `test_parallel_result_merge` — Results from workers merge correctly

## Related Files

- [KB-06-harness-implementation](../06-implementation/harness-implementation.md)
- [KB-06-orchestrator-implementation](../06-implementation/orchestrator-implementation.md)
- [KB-04-crash-safe-persistence](../04-architecture/crash-safe-persistence.md)
