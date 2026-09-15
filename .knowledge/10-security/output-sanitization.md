---
id: KB-10-output-sanitization
title: "Output Sanitization"
category: security
subcategory: detail
tags: [security, output,sanitization]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14, 15]
related:
  - KB-10-security-overview
  - All outputs are Pydantic models (structured); no raw WKT or SQL; attribute tables truncated to 100 rows; error messages sanitized (no stack traces); layer metadata stripped of control chars; CRS returned as EPSG string only|KB-06-geo-mcp-server
  - KB-10-prompt-injection-mitigation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Output Sanitization"
  key_facts:
    - "Output Sanitization"
  common_questions:
    - "How is Output Sanitization handled?"
---

# Output Sanitization

## Details

How tool results are cleaned before returning to agent

## Related Files

- KB-10-security-overview
- All outputs are Pydantic models (structured); no raw WKT or SQL; attribute tables truncated to 100 rows; error messages sanitized (no stack traces); layer metadata stripped of control chars; CRS returned as EPSG string only|KB-06-geo-mcp-server
- KB-10-prompt-injection-mitigation
