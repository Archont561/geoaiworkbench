---
id: KB-12-task-schema
title: "BenchmarkTask Pydantic Schema"
category: tasks-benchmark
subcategory: schema
tags: [task, schema, pydantic, json, benchmark]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5, 15]
related:
  - KB-06-models-pydantic
  - KB-12-geoanalystbench-overview
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Pydantic schema for benchmark task definitions"
  key_facts:
    - "BenchmarkTask model with all required fields"
    - "minimum_tier field for MCP-5 vs MCP-15 mapping"
    - "required_tools for tool selection ground truth"
    - "verification_config for OutputVerifier"
    - "Stored as JSON files in tasks/"
  common_questions:
    - "What fields does a task have?"
    - "How are tasks stored?"
---

# BenchmarkTask Pydantic Schema

## Schema Definition

```python
class VerificationConfig(BaseModel):
    geometry_type: str | None = None
    expected_crs: str | None = None
    feature_count_tolerance: float = 0.05
    required_fields: list[str] = []
    extent_iou_threshold: float = 0.90

class BenchmarkTask(BaseModel):
    task_id: str                          # e.g., "T017"
    prompt: str                           # Natural language task description
    difficulty: Literal[
        "basic", "intermediate",
        "advanced", "adversarial"
    ]
    required_layers: list[str]            # Input data files
    expected_operations: list[str]        # Reference workflow steps
    required_tools: set[str]              # MCP tools needed (ground truth)
    minimum_tier: int                     # 2=MCP-5, 3-5=MCP-15
    reference_output_path: str            # Path to ground truth
    verification_config: VerificationConfig
    max_attempts: int = 3
    timeout_seconds: int = 300
```

## Example Task

```json
{
  "task_id": "T017",
  "prompt": "Buffer the roads layer by 500m, then clip to the study area",
  "difficulty": "intermediate",
  "required_layers": ["roads.shp", "study_area.shp"],
  "expected_operations": ["buffer", "clip"],
  "required_tools": ["buffer", "clip", "layer_info"],
  "minimum_tier": 2,
  "reference_output_path": "data/reference_outputs/T017/result.shp",
  "verification_config": {
    "geometry_type": "Polygon",
    "expected_crs": "EPSG:32633",
    "feature_count_tolerance": 0.05
  },
  "max_attempts": 3,
  "timeout_seconds": 300
}
```

## File Organization

```
tasks/
├── basic/T001.json ... T015.json
├── intermediate/T016.json ... T035.json
├── advanced/T036.json ... T050.json
└── adversarial/ADV-01.json ... ADV-05.json
```

## Related Files

- [KB-06-models-pydantic](../06-implementation/models-pydantic.md)
- [KB-12-geoanalystbench-overview](geoanalystbench-overview.md)
- [KB-02-task-stratification](../02-research-design/task-stratification.md)
