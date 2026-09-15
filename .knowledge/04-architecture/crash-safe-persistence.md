---
id: KB-04-crash-safe-persistence
title: "Crash-Safe Result Persistence"
category: architecture
subcategory: pattern
tags: [persistence, jsonl, crash-safe, resumable, completed]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [5]
related:
  - KB-04-system-architecture
  - KB-06-orchestrator-implementation
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "JSONL + completed.json pattern for crash-safe benchmark persistence"
  key_facts:
    - "Every TaskResult written as JSON line immediately"
    - "completed.json tracks finished run keys"
    - "Interrupted experiments resume automatically"
    - "Append-only (no data loss on crash)"
    - "filelock for concurrent access"
  common_questions:
    - "What happens if the benchmark crashes?"
    - "How are results stored?"
    - "Can I resume an interrupted run?"
---

# Crash-Safe Result Persistence

## Design Goal

1,800 benchmark runs take hours. If the process crashes (OOM, power loss, agent hang), no data should be lost and the experiment should resume from where it stopped.

## Storage Format

### results.jsonl (Append-Only)

Every `TaskResult` is immediately written as a single JSON line:

```jsonl
{"task_id":"T001","agent":"opencode","paradigm":"mcp5","attempt":1,"success":true,"duration_ms":12400,"oqs":0.95,...}
{"task_id":"T001","agent":"opencode","paradigm":"mcp5","attempt":2,"success":true,"duration_ms":11200,"oqs":0.97,...}
{"task_id":"T001","agent":"opencode","paradigm":"codegen","attempt":1,"success":false,"duration_ms":18900,"oqs":0.42,...}
```

**Properties:**
- Append-only (never modify existing lines)
- One line per task run
- Crash-safe (partial writes don't corrupt existing data)
- Streamable (can be read while being written)
- Queryable via DuckDB: `SELECT * FROM read_json_auto('results.jsonl')`

### completed.json (Run Key Set)

Tracks which (paradigm, agent, task, attempt) combinations are done:

```json
{
  "mcp5:opencode:T001:1": true,
  "mcp5:opencode:T001:2": true,
  "mcp5:opencode:T001:3": true,
  "mcp5:opencode:T002:1": true
}
```

**Properties:**
- Read on startup to determine remaining work
- Updated after each successful run
- Protected by `filelock` for concurrent access

## Write Flow

```python
class ResultStore:
    def save_result(self, result: TaskResult):
        """Crash-safe write of single result."""
        run_key = f"{result.paradigm}:{result.agent}:{result.task_id}:{result.attempt}"

        # 1. Append result to JSONL (atomic append)
        with open(self.results_path, "a") as f:
            f.write(result.model_dump_json() + "\n")
            f.flush()
            os.fsync(f.fileno())  # Force disk write

        # 2. Mark as completed (with file lock)
        with FileLock(str(self.completed_lock_path)):
            completed = self._load_completed()
            completed[run_key] = True
            self._save_completed(completed)

    def get_remaining(self, all_run_keys: set[str]) -> list[str]:
        """Return run keys not yet completed."""
        completed = self._load_completed()
        return [k for k in all_run_keys if k not in completed]
```

## Resume Flow

```python
class BenchmarkOrchestrator:
    def run(self):
        all_keys = self._generate_all_run_keys()  # 1,800 keys
        remaining = self.result_store.get_remaining(all_keys)

        log.info("benchmark_resume",
                 total=len(all_keys),
                 completed=len(all_keys) - len(remaining),
                 remaining=len(remaining))

        for run_key in remaining:
            result = self._execute_single_run(run_key)
            self.result_store.save_result(result)
```

## Concurrency Safety

When running parallel workers (future optimization):

```python
from filelock import FileLock

with FileLock("results/completed.json.lock", timeout=30):
    # Read-modify-write completed.json
    ...
```

JSONL append is naturally concurrent-safe (OS atomic append for small writes).

## Data Recovery

If `completed.json` is corrupted but `results.jsonl` is intact:

```python
def rebuild_completed_from_jsonl(results_path):
    """Rebuild completed.json from JSONL contents."""
    completed = {}
    with open(results_path) as f:
        for line in f:
            result = json.loads(line)
            key = f"{result['paradigm']}:{result['agent']}:{result['task_id']}:{result['attempt']}"
            completed[key] = True
    return completed
```

## Related Files

- [KB-06-orchestrator-implementation](../06-implementation/orchestrator-implementation.md) — Orchestrator code
- [KB-03-metrics-overview](../03-metrics/metrics-overview.md) — What gets stored
