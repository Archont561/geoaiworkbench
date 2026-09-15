---
id: KB-09-benchmark-security-warning
title: "Benchmark Security Warning — Evaluation Contamination"
category: testing
subcategory: warning
tags: [testing, security, contamination, swe-bench, isolation]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-04-black-box-constraint
  - KB-06-verifier-implementation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Warning about evaluation contamination from SWE-bench findings"
  key_facts:
    - "SWE-bench and Terminal-Bench shown vulnerable to contamination"
    - "Agent can tamper with verifier if in same process"
    - "OutputVerifier MUST run as separate process"
    - "Agent process must terminate before verification"
  common_questions:
    - "What is evaluation contamination?"
    - "How do we prevent it?"
---

# Benchmark Security Warning — Evaluation Contamination

## The Problem

SWE-bench and Terminal-Bench have been shown to be vulnerable to **evaluation contamination** when the agent controls or can influence the test infrastructure.

**Scenario:** If the agent process is still running when the verifier executes, the agent could:
- Modify reference output files
- Tamper with verification scripts
- Intercept verification results
- Create symlinks to fake outputs

## GeoAIWorkbench Mitigation

### Rule: Verifier Runs AFTER Agent Terminates

```
1. Agent process starts
2. Agent works (writes code, calls tools)
3. Agent signals completion OR timeout
4. Agent process TERMINATES (verified via proc.poll())
5. OutputVerifier starts as SEPARATE PROCESS
6. Verifier reads output files (read-only)
7. Verifier compares to reference (read-only)
8. Verifier writes score to JSONL
```

### Implementation

```python
# harness.py
proc = self._launch_agent(...)
proc.wait(timeout=task.timeout_seconds)
assert proc.poll() is not None, "Agent must be terminated"

# Verifier runs in separate process
result = subprocess.run(
    ["python", "-m", "geoaibenchmark.benchmark.verifier",
     "--output", str(workspace / "output"),
     "--reference", task.reference_output_path],
    capture_output=True, text=True
)
```

### Additional Safeguards

- Reference outputs are read-only (`chmod 444`)
- Workspace is scoped to benchmark directory
- Agent has no access to verifier code
- JSONL is append-only

## Related Files

- [KB-04-black-box-constraint](../04-architecture/black-box-constraint.md)
- [KB-06-verifier-implementation](../06-implementation/verifier-implementation.md)
