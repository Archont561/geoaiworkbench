---
id: KB-12-task-execution-flow
title: "Single Task Execution Flow"
category: tasks-benchmark
subcategory: execution
tags: [task, execution, flow, lifecycle, workspace]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-04-data-flow-diagram
  - KB-06-harness-implementation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Step-by-step execution flow for a single benchmark task"
  key_facts:
    - "Clean workspace per task"
    - "Input data copied, output collected"
    - "Agent launched with condition-specific config"
    - "Verifier runs after agent exits"
    - "Result written to JSONL"
  common_questions:
    - "What happens during one task?"
    - "How is the workspace managed?"
---

# Single Task Execution Flow

## Lifecycle

```
1. SELECT next (paradigm, agent, task, attempt)
2. CHECK completed.json → skip if done
3. CREATE workspace/
   ├── input/    (copy from data/input/)
   ├── output/   (empty)
   └── scripts/  (empty, CodeGen only)
4. GENERATE agent config (MCP-5/15 or CodeGen)
5. START QGIS bridge (if MCP, not already running)
6. START MCP server (if MCP, with GEOMCP_TIER)
7. LAUNCH agent with task prompt
8. WAIT for completion or 300s timeout
9. KILL agent process
10. KILL MCP server (if MCP)
11. CLEAR monitor hook
12. COLLECT outputs from workspace/output/
13. RUN OutputVerifier (separate process)
14. COMPUTE metrics (7 layers)
15. ASSEMBLE TaskResult
16. WRITE to results.jsonl (append + fsync)
17. UPDATE completed.json (with filelock)
18. LOG summary via structlog
19. CLEAN workspace (optional)
20. RETURN to orchestrator
```

## Workspace Isolation

Each task gets a **fresh workspace** to prevent cross-task contamination:
- Input data is **copied** (not symlinked)
- Output directory starts **empty**
- Scripts directory starts **empty**
- No shared state between tasks

## Timeout Handling

- Default: 300 seconds per task
- On timeout: SIGTERM → wait 10s → SIGKILL
- Result: success=False, error_type="timeout"
- Task marked as completed (no retry)

## Related Files

- [KB-04-data-flow-diagram](../04-architecture/data-flow-diagram.md)
- [KB-06-harness-implementation](../06-implementation/harness-implementation.md)
- [KB-06-orchestrator-implementation](../06-implementation/orchestrator-implementation.md)
