---
id: KB-04-paradigm-boundary
title: "Paradigm Boundary Enforcement"
category: architecture
subcategory: invariant
tags: [paradigm-boundary, invariant, execute-code, forbidden, assertion, test]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 8, 15]
related:
  - KB-04-package-geoaiworkbench
  - KB-05-forbidden-tools
  - KB-09-critical-tests
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Hard invariant preventing code execution tools in MCP conditions"
  key_facts:
    - "FORBIDDEN_TOOLS set checked at import time"
    - "AssertionError raised if any forbidden tool registered"
    - "Dedicated test runs on every commit"
    - "Most critical invariant in the entire system"
    - "Differentiates GeoMCP from qgis-mcp"
  common_questions:
    - "What is the paradigm boundary?"
    - "How is it enforced?"
    - "Why is it critical?"
    - "What tools are forbidden?"
---

# Paradigm Boundary Enforcement

## The Invariant

**The MCP conditions (MCP-5 and MCP-15) MUST NOT expose any code execution capability.**

This is the single most important design constraint in GeoAIWorkbench. Without it, the MCP vs CodeGen comparison is meaningless — the agent could simply write code through an MCP tool, collapsing the two paradigms into one.

## Forbidden Tools

```python
FORBIDDEN_TOOLS = {
    "execute_code",
    "run_python",
    "python_console",
    "shell",
    "bash",
    "execute_processing_algorithm",  # Generic dispatch = code execution
    "arbitrary_sql",
    "arbitrary_file_write",
}
```

## Enforcement Mechanism (Two Layers)

### Layer 1: Assertion at Import Time

```python
# geoaiworkbench/geo_mcp.py

def _enforce_paradigm_boundary():
    """Called at module import time. Crashes if boundary violated."""
    registered = {t.name for t in mcp._tool_manager._tools.values()}
    violations = registered & FORBIDDEN_TOOLS
    assert not violations, (
        f"PARADIGM BOUNDARY VIOLATION: forbidden tools registered: {violations}. "
        f"This would invalidate the MCP vs CodeGen comparison."
    )

# Called after all tool registrations and tier filtering
_enforce_paradigm_boundary()
```

**Effect:** If any developer accidentally adds `execute_code`, the server **refuses to start**.

### Layer 2: Dedicated Test (Runs on Every Commit)

```python
# tests/test_geoaiworkbench/test_paradigm_boundary.py

class TestParadigmBoundary:
    """Most critical tests in the entire suite."""

    def test_no_forbidden_tools_exposed(self):
        """Verify no code execution tools in production server."""
        from geoaiworkbench.geo_mcp import mcp, FORBIDDEN_TOOLS
        registered = {t.name for t in mcp._tool_manager._tools.values()}
        assert not (registered & FORBIDDEN_TOOLS)

    def test_mcp5_has_exactly_5_tools(self):
        """MCP-5 must expose exactly Tier 1-2."""
        import os
        os.environ["GEOMCP_TIER"] = "5"
        from geoaiworkbench.geo_mcp import mcp
        tools = {t.name for t in mcp._tool_manager._tools.values()}
        assert tools == {
            "layer_info", "layer_statistics",
            "buffer", "clip", "reproject"
        }

    def test_mcp15_has_exactly_15_tools(self):
        """MCP-15 must expose exactly Tier 1-5."""
        import os
        os.environ["GEOMCP_TIER"] = "15"
        from geoaiworkbench.geo_mcp import mcp
        tools = {t.name for t in mcp._tool_manager._tools.values()}
        assert len(tools) == 15
        assert "dissolve" in tools
        assert "calculate_field" in tools
        assert "execute_code" not in tools

    def test_no_execute_code_in_any_tier(self):
        """execute_code must not appear at any tier level."""
        for tier in ["5", "15"]:
            os.environ["GEOMCP_TIER"] = tier
            # Reimport and check
            assert "execute_code" not in registered_tools
```

## Why This Matters

### Scientific Validity

If MCP server exposes `execute_code`:
- Agent can write arbitrary PyQGIS code via MCP
- This IS code generation, just through a tool
- The "MCP" condition becomes "CodeGen with extra steps"
- Comparison is meaningless

### Differentiation from qgis-mcp

| Server | execute_code | Paradigm Clean? |
|---|---|---|
| qgis-mcp (nkarasiak) | ✅ Exposed | ❌ Contaminated |
| QGIS2OllamaMCP | ✅ Exposed | ❌ Contaminated |
| **GeoMCP (this thesis)** | ❌ Forbidden | ✅ Clean |

### Design Principle P1

This is Design Principle P1 from Chapter VII:
> **P1: No code execution tools.** The MCP server must not expose any tool that allows arbitrary code execution. This is the fundamental constraint that makes paradigm comparison meaningful.

## Threat Model

| Threat | Mitigation |
|---|---|
| Developer accidentally adds execute_code | Assertion at import + test |
| Tier filtering bug exposes hidden tool | Test verifies exact tool set per tier |
| Agent tries to call execute_code anyway | MCP server returns "method not found" |
| Future tool addition violates boundary | CI test catches before merge |

## Related Files

- [KB-05-forbidden-tools](../05-mcp-tools/forbidden-tools.md) — Full forbidden list
- [KB-09-critical-tests](../09-testing/critical-tests.md) — Test details
- [KB-05-tool-spec-overview](../05-mcp-tools/tool-spec-overview.md) — Design principles
