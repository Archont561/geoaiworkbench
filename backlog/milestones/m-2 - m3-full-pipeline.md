---
id: m-2
title: "M3 Full pipeline"
---

## Description

Go/no-go criteria (previously .knowledge/13-roadmap/critical-path.md), weeks 3-4.

- A single task runs end to end in MCP-5, MCP-15 and CodeGen
- JSONL output contains a valid TaskResult
- OQS, PEA and TSR are computed correctly
- 120+ tests passing

**If blocked:** the likely cause is a bridge threading issue or the CodeGen container; week 5 is the buffer.
