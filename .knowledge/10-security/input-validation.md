---
id: KB-10-input-validation
title: "Input Validation"
category: security
subcategory: detail
tags: [security, input,validation]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [14, 15]
related:
  - KB-10-security-overview
  - distance gt=0 prevents negative buffers; EPSG regex prevents path traversal; output≠input prevents overwrite; predicate Literal prevents injection; expression sanitization prevents code execution; min_length=2 prevents empty merge; all validators run BEFORE QGIS execution|KB-06-models-pydantic
  - KB-09-contract-tests
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Input Validation"
  key_facts:
    - "Input Validation"
  common_questions:
    - "How is Input Validation handled?"
---

# Input Validation

## Details

Pydantic validators as security boundary

## Related Files

- KB-10-security-overview
- distance gt=0 prevents negative buffers; EPSG regex prevents path traversal; output≠input prevents overwrite; predicate Literal prevents injection; expression sanitization prevents code execution; min_length=2 prevents empty merge; all validators run BEFORE QGIS execution|KB-06-models-pydantic
- KB-09-contract-tests
