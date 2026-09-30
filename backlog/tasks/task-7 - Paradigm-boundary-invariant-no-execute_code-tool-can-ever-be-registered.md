---
id: TASK-7
title: 'Paradigm-boundary invariant: no execute_code tool can ever be registered'
status: To Do
assignee: []
created_date: '2026-09-30 21:44'
updated_date: '2026-09-30 21:45'
labels:
  - testing
  - security
milestone: m-1
dependencies:
  - TASK-2
documentation:
  - .knowledge/04-architecture/paradigm-boundary.md
  - .knowledge/05-mcp-tools/forbidden-tools.md
  - .knowledge/09-testing/critical-tests.md
priority: high
ordinal: 7000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The entire comparison rests on one invariant: the MCP conditions cannot execute arbitrary code, because if they could, MCP-15 and CodeGen would stop being different paradigms and every number in the study would be measuring the same thing. The knowledge base records this as a hard assertion plus a test (test_no_execute_code_tool_exposed), and it is the one piece of the MCP surface that belongs in the gate of the repository that owns the gate, not in the feature repository that owns the tools.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 A test asserts that no registered tool name matches the forbidden set (execute_code, run_script, eval, exec and the aliases listed in KB-05-forbidden-tools), at every tier
- [ ] #2 The assertion holds for GEOMCP_TIER=5 and GEOMCP_TIER=15, enumerated from the server rather than from a hardcoded list
- [ ] #3 The test runs inside pixi run gates and fails the gate, not merely a nightly job
- [ ] #4 The test fails loudly if the server exposes no tools at all, so an empty registry cannot pass as compliance
<!-- AC:END -->
