---
id: KB-07-infrastructure-libraries
title: "Infrastructure Libraries Detail"
category: tooling
subcategory: infrastructure
tags: [infrastructure, diskcache, tenacity, structlog, filelock, platformdirs]
status: canonical
created: 2026-09-11
updated: 2026-09-11
source_conversation_parts: [15]
related:
  - KB-07-dependencies-rationale
  - KB-06-caching-strategy
  - KB-06-logging-strategy
authoritative: true
implementation_status: specified
llm_hints:
  primary_purpose: "Detailed usage patterns for infrastructure libraries"
  key_facts:
    - "diskcache + platformdirs for persistent caching"
    - "structlog for JSON trajectory logging"
    - "tenacity for retry with exponential backoff"
    - "filelock for completed.json concurrency"
    - "All replace custom implementations"
  common_questions:
    - "How is caching implemented?"
    - "How is logging configured?"
    - "How are retries handled?"
---

# Infrastructure Libraries Detail

## Combinations

```
CACHING:     platformdirs.user_cache_path() → diskcache.Cache(ttl=300)
LOGGING:     structlog (JSON) → JSONL trajectory files
RELIABILITY: tenacity (@retry) + filelock (FileLock)
ANALYSIS:    JSONL → DuckDB/Polars → scipy/statsmodels → matplotlib
```

## diskcache + platformdirs

```python
from diskcache import Cache
from platformdirs import user_cache_path

cache = Cache(str(user_cache_path("GeoAIWorkbench") / "mcp"))

@cache.memoize(expire=300)
def get_layer_info(layer_name: str) -> dict:
    return expensive_qgis_operation(layer_name)
```

## structlog

```python
import structlog
structlog.configure(
    processors=[
        structlog.contextvars.merge_contextvars,
        structlog.processors.add_log_level,
        structlog.processors.TimeStamper(fmt="iso"),
        structlog.processors.JSONRenderer(),
    ]
)
log = structlog.get_logger()
log.info("mcp_tool_call", tool="buffer", duration_ms=234.7)
```

## tenacity

```python
from tenacity import retry, stop_after_attempt, wait_exponential, retry_if_exception_type

@retry(stop=stop_after_attempt(3), wait=wait_exponential(multiplier=0.5, min=0.5, max=5),
       retry=retry_if_exception_type(ConnectionError))
def connect_to_bridge():
    return socket.create_connection(("localhost", 9876))
```

## filelock

```python
from filelock import FileLock
with FileLock("results/completed.json.lock", timeout=30):
    completed = json.load(open("results/completed.json"))
    completed[run_key] = True
    json.dump(completed, open("results/completed.json", "w"))
```

## Related Files

- [KB-06-caching-strategy](../06-implementation/caching-strategy.md)
- [KB-06-logging-strategy](../06-implementation/logging-strategy.md)
- [KB-06-retry-strategy](../06-implementation/retry-strategy.md)
- [KB-06-locking-strategy](../06-implementation/locking-strategy.md)
