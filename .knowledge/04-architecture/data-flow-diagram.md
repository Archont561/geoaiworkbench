---
id: KB-04-data-flow-diagram
title: "Complete Data Flow for a Single Task Run"
category: architecture
subcategory: data-flow
tags: [data-flow, task-run, lifecycle, step-by-step, diagram]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-04-system-architecture
  - KB-02-final-research-design
  - KB-06-harness-implementation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Step-by-step data flow for a single benchmark task run"
  key_facts:
    - "22 steps from harness.run to JSONL write"
    - "Covers all 3 conditions (MCP-5, MCP-15, CodeGen)"
    - "Shows observation points and metric computation"
    - "Includes crash-safe persistence"
  common_questions:
    - "What happens during a single task run?"
    - "How does data flow through the system?"
    - "Where are metrics computed?"
---

# Complete Data Flow for a Single Task Run

## Overview

This diagram traces the complete lifecycle of a single benchmark task run from start to finish.

## MCP Condition Flow (MCP-5 or MCP-15)

```
Step 1: BenchmarkOrchestrator selects next (paradigm, agent, task, attempt)
        │
Step 2: Check completed.json — skip if already done
        │
Step 3: BenchmarkHarness.run_task() called
        │
Step 4: Create clean workspace/
        ├── input/     (copy task input data)
        ├── output/    (empty, agent writes here)
        └── scripts/   (empty, not used in MCP)
        │
Step 5: Generate agent config
        ├── opencode_mcp5.json (GEOMCP_TIER=5)
        │   or opencode_mcp15.json (GEOMCP_TIER=15)
        │
Step 6: Start QGIS bridge process (if not running)
        ├── pixi run qgis-bridge
        ├── TCP server listening on :9876
        │
Step 7: Start MCP server process
        ├── GEOMCP_TIER=5 pixi run mcp-server
        ├── FastMCP connects to QGIS bridge via TCP
        ├── MCPMonitor injected via set_hook()
        │
Step 8: Launch CLI agent
        ├── opencode acp < task_prompt
        ├── Agent connects to MCP server via stdio
        │
Step 9: Agent discovers tools
        ├── MCP tools/list → 5 or 15 tool schemas
        ├── Agent reads SERVER_INSTRUCTIONS
        │
Step 10: Agent executes task (loop)
        │
        ├── Agent calls layer_info("roads")
        │   ├── MCP → TCP → QGIS → PyQGIS → result → TCP → MCP
        │   └── MCPMonitor.wrap() records event ← OBSERVATION POINT 1
        │
        ├── Agent calls buffer(input="roads", distance=500)
        │   ├── MCP → TCP → QGIS → processing.run("native:buffer") → result
        │   └── MCPMonitor.wrap() records event
        │
        └── Agent calls clip(input="roads_buffer", overlay="study_area")
            ├── MCP → TCP → QGIS → processing.run("native:clip") → result
            └── MCPMonitor.wrap() records event
        │
Step 11: Agent signals completion (or timeout at 300s)
        │
Step 12: Agent process exits
        │
Step 13: MCP server process exits
        │
Step 14: MCPMonitor.clear_hook() called (finally block)
        │
Step 15: Collect outputs from workspace/output/  ← OBSERVATION POINT 2
        │
Step 16: OutputVerifier runs (SEPARATE PROCESS)
        ├── Load reference output
        ├── Load agent output
        ├── Compute OQS (geometry, CRS, IoU, features, attributes)
        └── Return pass/fail + OQS score
        │
Step 17: StepTracker computes workflow metrics
        ├── Step Count from MCPMonitor events
        ├── PEA from parameter comparison
        ├── Tool Selection Accuracy
        └── Step Order Accuracy
        │
Step 18: Assemble TaskResult
        ├── task_id, agent, paradigm, attempt
        ├── success (from OutputVerifier)
        ├── oqs (from OutputVerifier)
        ├── step_metrics (from StepTracker)
        ├── events (from MCPMonitor)
        ├── duration_ms (from timer)
        └── token_count (from agent logs)
        │
Step 19: Write TaskResult to results.jsonl (append + fsync)
        │
Step 20: Update completed.json (with filelock)
        │
Step 21: structlog emits summary event
        │
Step 22: Return to orchestrator for next run
```

## CodeGen Condition Flow

```
Steps 1-4: Same as MCP (workspace setup)
        │
Step 5: Generate agent config (NO MCP server)
        ├── opencode_codegen.json (empty mcp section)
        │
Step 6: Build CodeGen system prompt
        ├── "You have PyQGIS access. Write and run Python code."
        ├── "Save outputs to workspace/output/"
        │
Steps 7-8: Launch CLI agent (no MCP server started)
        │
Step 9: Agent writes Python scripts
        ├── workspace/scripts/solution.py
        │
Step 10: Agent executes scripts via shell
        ├── python workspace/scripts/solution.py
        ├── CodeGenMonitor captures stdout/stderr/exit_code
        │   ← OBSERVATION POINT 1 (execution events)
        │
Step 11-12: Agent completes, process exits
        │
Step 13: CodeExtractor extracts Python from agent output
        ├── File-first: use workspace/scripts/*.py
        ├──
        ├── File-first: use workspace/scripts/*.py
        ├── Fallback: extract from markdown fences in transcript
        └── Tree-sitter/Parso recovery if syntax errors
        │
Step 14: QGISIRBuilder analyzes extracted code (static)
        ├── Parse AST → QGIS Workflow IR
        ├── Extract processing.run() calls
        ├── Map algorithm IDs to MCP equivalents
        ├── Compute Tool Selection Accuracy
        └── Compute static PEA
        │
Step 15: QGISValidator checks against Processing registry (semantic)
        ├── algorithmById() — does algorithm exist?
        ├── checkParameterValues() — are params valid?
        └── Report hallucinated algorithms
        │
Step 16: RuntimeTracer executes code in Docker QGIS (runtime)
        ├── docker run --network=none qgis/qgis:3.44
        ├── Monkeypatch processing.run() for tracing
        ├── Capture runtime events (algorithm, params, success)
        ├── coverage.py for line execution
        └── Return RuntimeTrace
        │
Step 17: Collect outputs from workspace/output/  ← OBSERVATION POINT 2
        │
Step 18: OutputVerifier runs (SEPARATE PROCESS, same as MCP)
        ├── Load reference output
        ├── Load agent output
        ├── Compute OQS
        └── Return pass/fail + OQS score
        │
Step 19: Assemble TaskResult
        ├── task_id, agent, paradigm="codegen", attempt
        ├── success (from OutputVerifier)
        ├── oqs (from OutputVerifier)
        ├── step_metrics (from QGISIRBuilder + RuntimeTracer)
        ├── code_analysis (from QGISIRBuilder)
        ├── events (from CodeGenMonitor + RuntimeTracer)
        ├── duration_ms, token_count
        └── 4-layer scores (static, semantic, runtime, artifact)
        │
Steps 20-22: Same as MCP (JSONL write, completed.json, next run)
```

## Condition Comparison Summary

| Step | MCP-5/15 | CodeGen |
|---|---|---|
| Config | MCP server enabled | No MCP server |
| Agent interaction | Tool calls via MCP | Code writing + shell execution |
| Observation 1 | MCPMonitor (tool logs) | CodeGenMonitor (exec logs) |
| Step extraction | MCPMonitor events | QGISIRBuilder (AST) + RuntimeTracer |
| Param validation | Pydantic (pre-execution) | checkParameterValues() (post-hoc) |
| Observation 2 | Output files | Output files (same) |
| Output verification | OutputVerifier | OutputVerifier (same) |
| Result format | TaskResult | TaskResult (same schema) |

## Metric Computation Points

```
                    MCP Condition              CodeGen Condition
                    ─────────────              ─────────────────
Layer 1 (TSR)       OutputVerifier             OutputVerifier
Layer 2 (PEA)       MCPMonitor params          QGISIRBuilder + registry
Layer 2 (TSA)       MCPMonitor tool names      QGISIRBuilder algo IDs
Layer 3 (OQS)       OutputVerifier             OutputVerifier
Layer 4 (ED)        Output diff ×3             Output diff ×3
Layer 4 (Errors)    MCPMonitor error codes     CodeGenMonitor stderr
Layer 4 (ITS)       Attempt counting           Attempt counting
Layer 4 (Tokens)    Agent API logs             Agent API logs
Layer 5 (PCS)       StepTracker                QGISIRBuilder + RuntimeTracer
Layer 5 (SHR)       Pass@1 vs Pass@3           Pass@1 vs Pass@3
Layer 6 (CPR)       TSR / tokens               TSR / tokens
Layer 7 (Security)  ADV tasks + surface        ADV tasks + surface
```

## Error Handling Flow

```
Tool call fails
    │
    ├── MCP Condition:
    │   ├── Pydantic validation error → param_type/param_value
    │   ├── QGIS Processing error → exec_error
    │   ├── Layer not found → error returned to agent
    │   └── Agent may retry with corrected params (self-healing)
    │
    └── CodeGen Condition:
        ├── SyntaxError → code won't run
        ├── ImportError → missing module
        ├── RuntimeError → QGIS exception
        ├── Hallucination → nonexistent algorithm
        └── Agent may fix code and re-run (self-healing)
```

## Timeout Flow

```
Task exceeds 300s timeout
    │
    ├── Kill agent process (SIGTERM → SIGKILL after 10s)
    ├── Kill MCP server process (if MCP condition)
    ├── Record timeout in TaskResult (success=False, error="timeout")
    ├── Write to JSONL
    └── Mark as completed (don't retry)
```

## Related Files

- [KB-04-system-architecture](system-architecture.md) — Component overview
- [KB-06-harness-implementation](../06-implementation/harness-implementation.md) — Harness code
- [KB-06-orchestrator-implementation](../06-implementation/orchestrator-implementation.md) — Orchestrator code
- [KB-02-final-research-design](../02-research-design/final-research-design.md) — Run execution flow
