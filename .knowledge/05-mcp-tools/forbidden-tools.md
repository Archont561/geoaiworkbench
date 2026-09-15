---
id: KB-05-forbidden-tools
title: "Forbidden Tools List"
category: mcp-tools
subcategory: security
tags: [forbidden, execute-code, paradigm-boundary, security]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8, 15]
related:
  - KB-04-paradigm-boundary
  - KB-05-tool-spec-overview
  - KB-09-critical-tests
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Complete list of tools that must NEVER be exposed by GeoMCP"
  key_facts:
    - "8 forbidden tool names"
    - "Assertion at import time prevents registration"
    - "Test runs on every CI commit"
    - "qgis-mcp exposes execute_code — GeoMCP does not"
  common_questions:
    - "What tools are forbidden?"
    - "Why is execute_code forbidden?"
    - "How is this enforced?"
---

# Forbidden Tools List

## The Forbidden Set

```python
FORBIDDEN_TOOLS = {
    "execute_code",                  # Arbitrary Python execution
    "run_python",                    # Arbitrary Python execution (alias)
    "python_console",                # QGIS Python console access
    "shell",                         # Shell command execution
    "bash",                          # Bash command execution (alias)
    "execute_processing_algorithm",  # Generic Processing dispatch (bypasses tool constraints)
    "arbitrary_sql",                 # SQL execution against data sources
    "arbitrary_file_write",          # Unrestricted file system access
}
```

## Why Each Is Forbidden

| Tool | Risk | Why It Breaks the Experiment |
|---|---|---|
| `execute_code` | Arbitrary code execution | Collapses MCP into CodeGen paradigm |
| `run_python` | Same as above | Alias for execute_code |
| `python_console` | Interactive Python access | Same as execute_code |
| `shell` | OS command execution | Security + paradigm collapse |
| `bash` | Same as above | Alias for shell |
| `execute_processing_algorithm` | Generic algorithm dispatch | Bypasses tool-specific validation |
| `arbitrary_sql` | SQL injection risk | Security + uncontrolled data access |
| `arbitrary_file_write` | File system access | Security + data exfiltration |

## Comparison with Existing Servers

| Server | execute_code | Other dangerous tools | Paradigm clean? |
|---|---|---|---|
| qgis-mcp v0.3.1 | ✅ Yes | SQL, shell | ❌ No |
| QGIS2OllamaMCP | ✅ Yes | Python console | ❌ No |
| **GeoMCP** | ❌ No | None | ✅ Yes |

## Enforcement

See [KB-04-paradigm-boundary](../04-architecture/paradigm-boundary.md) for full enforcement mechanism.

## Related Files

- [KB-04-paradigm-boundary](../04-architecture/paradigm-boundary.md) — Enforcement details
- [KB-09-critical-tests](../09-testing/critical-tests.md) — Test coverage
