---
id: KB-05-tool-calculate-field
title: "MCP Tool: calculate_field"
category: mcp-tools
subcategory: tool-spec
tags: [tool, calculate-field, data-management, native-fieldcalculator, tier-5, mcp-15-only, security-risk]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [15]
related:
  - KB-05-tool-spec-overview
  - KB-10-security-overview
  - KB-05-forbidden-tools
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Full specification for the calculate_field MCP tool (MCP-15 only, SECURITY SENSITIVE)"
  key_facts:
    - "Tier 5 (Data Management), MCP-15 only"
    - "Computes new attribute values using QGIS expressions"
    - "SECURITY RISK: expression injection possible"
    - "Expression must be validated/sanitized"
    - "Uses native:fieldcalculator"
  common_questions:
    - "What expression syntax is used?"
    - "Is there an injection risk?"
    - "What field types are supported?"
---

# MCP Tool: calculate_field ⚠️ SECURITY SENSITIVE

## Purpose
Compute new attribute values using a QGIS expression.

## Tool Description
```
Compute new attribute values for features in a QGIS vector layer using
a QGIS expression.

Use this tool when the task requires deriving new fields from existing
attributes or geometry properties (e.g., area, length, ratios).

The expression uses QGIS expression syntax. Common expressions:
- $area (feature area in CRS units)
- length($geometry) (feature length)
- "field1" + "field2" (arithmetic)
- substr("name", 1, 3) (string operations)

A new output layer is created. The input layer is never modified.
```

## Input Schema
```json
{
  "input_layer": "string (required)",
  "field_name": "string (required, new or existing field)",
  "field_type": "integer | float | string (default: float)",
  "expression": "string (required, QGIS expression syntax)",
  "output_layer": "string (required)"
}
```

## Pydantic Validators
- `field_type`: `Literal["integer", "float", "string"]`
- `expression`: `@field_validator` — **MUST sanitize for injection**

## ⚠️ Expression Injection Risk

This is the **highest-risk tool** in GeoMCP because QGIS expressions can:
- Access file system functions
- Execute external commands (via `eval()` in some contexts)
- Read environment variables

### Mitigation Strategy

```python
FORBIDDEN_EXPRESSION_PATTERNS = [
    r"eval\s*\(",
    r"exec\s*\(",
    r"__import__",
    r"os\.",
    r"sys\.",
    r"subprocess",
    r"open\s*\(",
    r"file\s*\(",
]

@field_validator("expression")
@classmethod
def sanitize_expression(cls, v: str) -> str:
    for pattern in FORBIDDEN_EXPRESSION_PATTERNS:
        if re.search(pattern, v, re.IGNORECASE):
            raise ValueError(
                f"Expression contains forbidden pattern: {pattern}"
            )
    return v
```

## Output Schema
```json
{
  "output_layer": "roads_with_area",
  "field_name": "area_sqm",
  "field_type": "float",
  "non_null_count": 1250,
  "feature_count": 1250
}
```

## Behavioral Contract
- Creates new layer. Input never modified.
- Expression validated against injection patterns.
- Must report field name, type, and non-null count.

## Annotations
`readOnlyHint=false, destructiveHint=false, idempotentHint=true, openWorldHint=false`

## QGIS Implementation
`processing.run("native:fieldcalculator", {"INPUT": layer, "FIELD_NAME": name, "FIELD_TYPE": type, "FORMULA": expression, "OUTPUT": output})`

## Security Notes

- **ADV-02 to ADV-04** adversarial tasks specifically target this tool
- Expression sanitization is defense-in-depth (not primary security boundary)
- Primary security boundary is paradigm boundary (P1: no execute_code)
- See [KB-10-security-overview](../10-security/security-overview.md) for full analysis

## Tier
**MCP-15 only** (Tier 5). Not available in MCP-5.
