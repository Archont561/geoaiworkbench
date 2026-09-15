---
id: KB-09-testing-strategy
title: "Testing Strategy — TDD Roadmap"
category: testing
subcategory: strategy
tags: [testing, tdd, roadmap, red-green-refactor, pytest]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 7, 15]
related:
  - KB-09-test-inventory
  - KB-09-critical-tests
  - KB-07-phase1-development
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "TDD testing strategy with RED-GREEN-REFACTOR cycle"
  key_facts:
    - "Full TDD: write failing test first, then minimum code to pass"
    - "202+ tests total across 3 packages"
    - "pytest + pytest-qgis + pytest-xdist"
    - "CI runs on every commit via GitHub Actions"
    - "Paradigm boundary test is most critical"
  common_questions:
    - "What is the testing approach?"
    - "How many tests?"
    - "What framework?"
---

# Testing Strategy — TDD Roadmap

## Philosophy

Full Test-Driven Development (TDD):

1. **RED:** Write a failing test that specifies desired behavior
2. **GREEN:** Write minimum code to make the test pass
3. **REFACTOR:** Clean up without breaking tests

Every module has tests written before implementation.

## Test Framework

| Tool | Version | Purpose |
|---|---|---|
| pytest | ≥8.0 | Test runner |
| pytest-qgis | latest | QGIS fixtures (qgis_app, qgis_processing) |
| pytest-xdist | ≥3.6 | Parallel execution (-n auto) |

## Test Categories

| Category | Count | Description |
|---|---|---|
| Unit tests | ~136 | Isolated function/method tests with mocks |
| Integration tests | ~46 | Cross-component tests with real QGIS |
| Contract tests | ~15 | Pydantic validator edge cases |
| Paradigm boundary tests | ~5 | Most critical invariant |
| **Total** | **~202** | |

## Test Organization

```
tests/
├── conftest.py                    # Shared fixtures
├── test_qgis_utils/               # 26 tests
│   ├── test_headless.py           # HeadlessIface, qgis_app
│   └── test_paths.py              # resolve_qgis_paths, init_processing
├── test_geoaiworkbench/           # 80 tests
│   ├── test_models.py             # Pydantic model validation
│   ├── test_geo_mcp.py            # MCP server tool registration
│   ├── test_paradigm_boundary.py  # ⭐ MOST CRITICAL
│   ├── test_tier_control.py       # GEOMCP_TIER=5 vs 15
│   ├── test_bridge.py             # TCP bridge protocol
│   └── test_plugin.py             # QGIS plugin dispatch
└── test_geoaibenchmark/           # 76 tests
    ├── test_mcp_monitor.py        # MCPMonitor event capture
    ├── test_codegen_monitor.py    # CodeGenMonitor error classification
    ├── test_verifier.py           # OutputVerifier OQS computation
    ├── test_code_analyzer.py      # QGISIRBuilder AST extraction
    ├── test_harness.py            # BenchmarkHarness lifecycle
    ├── test_orchestrator.py       # Crash recovery, resume
    └── test_statistics.py         # Statistical test correctness
```

## CI Pipeline

```yaml
# .github/workflows/ci.yml
- name: Run tests
  run: pixi run -e test test-parallel

- name: Verify paradigm boundary
  run: pixi run -e test pytest tests/test_geoaiworkbench/test_paradigm_boundary.py -v
```

## Test Execution

```bash
pixi run test                    # All tests, verbose
pixi run test-parallel           # All tests, parallel
pixi run -e test pytest tests/test_geoaiworkbench/test_paradigm_boundary.py -v  # Critical only
```

## Related Files

- [KB-09-test-inventory](test-inventory.md) — Full test list
- [KB-09-critical-tests](critical-tests.md) — Most important tests
- [KB-09-contract-tests](contract-tests.md) — Validator tests
