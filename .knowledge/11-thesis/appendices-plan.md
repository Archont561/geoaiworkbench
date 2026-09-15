---
id: KB-11-appendices-plan
title: "Appendices Plan (A-D)"
category: thesis
subcategory: appendices
tags: [thesis, appendices, supplementary]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [6]
related:
  - KB-11-thesis-structure
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Plan for thesis appendices A through D"
  key_facts:
    - "Appendix A: Complete MCP tool specifications"
    - "Appendix B: Full task list with difficulty"
    - "Appendix C: Metrics framework details"
    - "Appendix D: Raw results tables"
  common_questions:
    - "What goes in the appendices?"
---

# Appendices Plan (A-D)

## Appendix A: Complete MCP Tool Specifications
- Full JSON schemas for all 15 tools
- Pydantic model definitions
- Behavioral contracts
- MCP annotations
- Server instructions (MCP-5 and MCP-15)

## Appendix B: Full Task List
- 50 GeoAnalystBench tasks with QGIS adaptations
- 5 adversarial tasks (ADV-01 to ADV-05)
- Difficulty tier assignments
- Required tool tier per task
- Reference output descriptions

## Appendix C: Metrics Framework Details
- Complete metric definitions with formulas
- Error taxonomy (MCP + CodeGen)
- Statistical test specifications
- Effect size interpretation guidelines
- OQS sub-metric computation details

## Appendix D: Raw Results Tables
- Full 1,800-run results summary
- Per-task TSR by paradigm and agent
- Per-agent error type distributions
- Security evaluation results (ADV tasks)
- Cost-performance data

## Related Files

- [KB-11-thesis-structure](thesis-structure.md)
- [KB-05-tool-spec-overview](../05-mcp-tools/tool-spec-overview.md)
- [KB-03-metrics-overview](../03-metrics/metrics-overview.md)
