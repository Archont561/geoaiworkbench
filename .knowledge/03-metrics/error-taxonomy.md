---
id: KB-03-error-taxonomy
title: "Error Taxonomy — MCP and CodeGen"
category: metrics
subcategory: errors
tags: [errors, taxonomy, mcp-errors, codegen-errors, classification]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [3, 15]
related:
  - KB-03-layer4-execution
  - KB-06-codegen-monitor
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Complete error taxonomy for both MCP and CodeGen paradigms"
  key_facts:
    - "6 MCP error types"
    - "5 CodeGen error types"
    - "Errors classified automatically from logs"
    - "Chi-square test compares distributions"
  common_questions:
    - "What error types are tracked?"
    - "How are errors classified?"
    - "Which errors are most common?"
---

# Error Taxonomy

## MCP Error Types (6)

Captured by MCPMonitor from MCP server error responses.

| Code | Type | Description | Example |
|---|---|---|---|
| `wrong_tool` | Wrong Tool Selection | Agent called incorrect tool for operation | Called `clip` when `buffer` needed |
| `param_type` | Parameter Type Error | Wrong type for parameter (caught by Pydantic) | String instead of float for distance |
| `param_value` | Parameter Value Error | Invalid value (caught by Pydantic validators) | Negative distance, invalid EPSG |
| `crs_mismatch` | CRS Incompatibility | Input layers have incompatible CRS | EPSG:4326 with EPSG:32633 without reproject |
| `exec_error` | Execution Error | QGIS Processing algorithm failed | Algorithm threw exception |
| `seq_error` | Sequence Error | Operations in wrong order | Clip before buffer when buffer needed first |

## CodeGen Error Types (5)

Captured by CodeGenMonitor from stderr classification.

| Code | Type | Description | Detection Pattern |
|---|---|---|---|
| `syntax_error` | Python Syntax Error | Invalid Python syntax | `SyntaxError` in stderr |
| `import_error` | Import Error | Missing or wrong module | `ImportError` or `ModuleNotFoundError` |
| `runtime_error` | Runtime Error | Exception during execution | `RuntimeError`, `Exception` |
| `logic_error` | Logic Error | Code runs but wrong result | Output fails OQS verification |
| `hallucination` | Hallucination | References nonexistent API/layer/algorithm | `NameError` with QGIS terms, "algorithm not found" |

## Error Classification Logic

### MCP Errors
```python
# From MCPMonitor
if error.response.code == "invalid_params":
    if "type" in error.message:
        return "param_type"
    else:
        return "param_value"
elif error.response.code == "method_not_found":
    return "wrong_tool"
elif "CRS" in error.message:
    return "crs_mismatch"
elif "sequence" in error.message:
    return "seq_error"
else:
    return "exec_error"
```

### CodeGen Errors
```python
# From CodeGenMonitor._classify_error()
stderr_lower = stderr.lower()
if "syntaxerror" in stderr_lower:
    return "syntax_error"
if "importerror" in stderr_lower or "modulenotfounderror" in stderr_lower:
    return "import_error"
if "nameerror" in stderr_lower and ("qgs" in stderr_lower or "processing" in stderr_lower):
    return "hallucination"
if "algorithm" in stderr_lower and "not found" in stderr_lower:
    return "hallucination"
if "runtimeerror" in stderr_lower:
    return "runtime_error"
return "runtime_error"  # Default
```

## Expected Distribution

| Error Type | MCP-5 | MCP-15 | CodeGen |
|---|---|---|---|
| wrong_tool | Low | Medium | N/A |
| param_type | Very Low | Low | N/A |
| param_value | Low | Low | N/A |
| crs_mismatch | Medium | Medium | Medium |
| exec_error | Medium | Low | N/A |
| seq_error | Low | Low | N/A |
| syntax_error | N/A | N/A | High |
| import_error | N/A | N/A | Medium |
| runtime_error | N/A | N/A | High |
| logic_error | N/A | N/A | Medium |
| hallucination | N/A | N/A | Medium |

**Key insight:** MCP errors are caught early (Pydantic validation), CodeGen errors are caught late (runtime).

## Statistical Test

**Chi-square test** on error type distributions across paradigms (PB4).

## Related Files

- [KB-03-layer4-execution](layer4-execution.md) — Error Rate metric
- [KB-06-codegen-monitor](../06-implementation/codegen-monitor.md) — Classification code
