---
id: KB-09-contract-tests
title: "Contract Tests — Pydantic Validators"
category: testing
subcategory: contracts
tags: [testing, contract, pydantic, validators, edge-cases]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [8, 15]
related:
  - KB-06-models-pydantic
  - KB-09-tests-geoaiworkbench-unit
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Pydantic validator edge case tests for all 15 tools"
  key_facts:
    - "~15 contract tests"
    - "Tests every Pydantic validator"
    - "Edge cases: zero, negative, empty, injection"
    - "Ensures paradigm boundary via validation"
  common_questions:
    - "What validators are tested?"
    - "What edge cases are covered?"
---

# Contract Tests — Pydantic Validators

## Validator Test Matrix

| Tool | Validator | Valid | Invalid | Edge Cases |
|---|---|---|---|---|
| buffer | distance gt=0 | 500, 0.01 | 0, -1, -100 | 1e-10, 1e10 |
| buffer | segments ge=1 | 1, 5, 100 | 0, -1 | 1 (minimum) |
| buffer | output≠input | "buf" | "roads" (same) | Case sensitivity |
| reproject | EPSG regex | "EPSG:4326" | "WGS84", "4326" | "epsg:4326" (normalized) |
| simplify | tolerance gt=0 | 1.0, 0.001 | 0, -0.5 | Very small values |
| spatial_join | predicate Literal | "intersects" | "near", "within 5m" | All 6 valid values |
| merge_layers | min_length=2 | ["a","b"] | ["a"], [] | Exactly 2, many |
| calculate_field | expression sanitize | "$area" | "eval(os.system('rm'))" | SQL injection patterns |
| clip | output≠inputs | "out" | "input", "overlay" | Both inputs checked |

## Expression Injection Tests (calculate_field)

```python
class TestCalculateFieldExpressionSanitization:
    def test_valid_area(self):
        CalculateFieldInput(expression="$area", ...)  # OK

    def test_valid_length(self):
        CalculateFieldInput(expression="length($geometry)", ...)  # OK

    def test_valid_arithmetic(self):
        CalculateFieldInput(expression='"pop" / "area"', ...)  # OK

    def test_reject_eval(self):
        with pytest.raises(ValidationError):
            CalculateFieldInput(expression="eval('1+1')", ...)

    def test_reject_import(self):
        with pytest.raises(ValidationError):
            CalculateFieldInput(expression="__import__('os')", ...)

    def test_reject_os_system(self):
        with pytest.raises(ValidationError):
            CalculateFieldInput(expression="os.system('rm -rf /')", ...)

    def test_reject_subprocess(self):
        with pytest.raises(ValidationError):
            CalculateFieldInput(expression="subprocess.run(['ls'])", ...)

    def test_reject_open(self):
        with pytest.raises(ValidationError):
            CalculateFieldInput(expression="open('/etc/passwd')", ...)
```

## Related Files

- [KB-06-models-pydantic](../06-implementation/models-pydantic.md)
- [KB-06-security-hardening](../06-implementation/security-hardening.md)
- [KB-10-input-validation](../10-security/input-validation.md)
