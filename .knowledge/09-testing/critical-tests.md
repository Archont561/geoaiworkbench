---
id: KB-09-critical-tests
title: "Critical Tests — Must Never Fail"
category: testing
subcategory: critical
tags: [testing, critical, paradigm-boundary, invariant, must-pass]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-04-paradigm-boundary
  - KB-09-test-inventory
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Tests that must never fail — breaking them invalidates the thesis"
  key_facts:
    - "5 critical tests identified"
    - "Paradigm boundary is #1"
    - "Run on every CI commit"
    - "Failure = thesis invalid"
  common_questions:
    - "Which tests are most important?"
    - "What happens if a critical test fails?"
---

# Critical Tests — Must Never Fail

## The 5 Critical Tests

### 1. test_no_execute_code_tool_exposed ⭐⭐⭐ MOST CRITICAL

```python
def test_no_execute_code_tool_exposed():
    """If this fails, the entire thesis is invalid."""
    from geoaiworkbench.geo_mcp import mcp, FORBIDDEN_TOOLS
    registered = {t.name for t in mcp._tool_manager._tools.values()}
    violations = registered & FORBIDDEN_TOOLS
    assert not violations, f"PARADIGM VIOLATION: {violations}"
```

**Why critical:** If execute_code leaks into MCP condition, MCP and CodeGen paradigms collapse into one. The comparison becomes meaningless.

### 2. test_identical_files_oqs_is_1

```python
def test_identical_files_oqs_is_1():
    """OutputVerifier must give perfect score for identical outputs."""
    verifier = OutputVerifier()
    result = verifier.verify(reference_path, reference_path)
    assert result.oqs == 1.0
```

**Why critical:** If the verifier gives <1.0 for identical files, all OQS scores are unreliable.

### 3. test_all_steps_completed_is_1

```python
def test_all_steps_completed_is_1():
    """StepTracker must give 1.0 when all reference steps matched."""
    tracker = StepTracker(events_matching_reference)
    assert tracker.step_completion_rate == 1.0
```

**Why critical:** Step metrics underpin PB2 (difficulty moderation) and PB4 (execution behavior).

### 4. test_wrap_records_event

```python
def test_wrap_records_event():
    """MCPMonitor must capture every tool call."""
    monitor = MCPMonitor("T001", "opencode", 1)
    monitor.wrap("buffer", {"distance": 500}, {"success": True}, 234.7)
    assert len(monitor.events) == 1
    assert monitor.events[0].tool_or_endpoint == "buffer"
```

**Why critical:** If monitor misses events, all Layer 2/4 metrics are wrong.

### 5. test_mcp5_has_exactly_5_tools

```python
def test_mcp5_has_exactly_5_tools():
    """MCP-5 must expose exactly 5 tools, no more, no less."""
    os.environ["GEOMCP_TIER"] = "5"
    from geoaiworkbench.geo_mcp import mcp
    tools = {t.name for t in mcp._tool_manager._tools.values()}
    assert tools == {"layer_info", "layer_statistics", "buffer", "clip", "reproject"}
```

**Why critical:** Tier control is the mechanism for PB7 (tool count effect). If it leaks tools, PB7 is invalid.

## CI Enforcement

These 5 tests run in a **separate CI step** that fails the build immediately:

```yaml
- name: Critical invariant checks
  run: |
    pixi run -e test pytest \
      tests/test_geoaiworkbench/test_paradigm_boundary.py \
      tests/test_geoaibenchmark/test_verifier.py::test_identical_files_oqs_is_1 \
      tests/test_geoaibenchmark/test_step_tracker.py::test_all_steps_completed_is_1 \
      tests/test_geoaibenchmark/test_mcp_monitor.py::test_wrap_records_event \
      -v --tb=short
```

## Related Files

- [KB-04-paradigm-boundary](../04-architecture/paradigm-boundary.md)
- [KB-05-forbidden-tools](../05-mcp-tools/forbidden-tools.md)
