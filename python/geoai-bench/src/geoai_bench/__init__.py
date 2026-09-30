"""GeoAnalystBench harness: task corpus, CLI agents and run orchestration.

The measurement apparatus. It loads a task, hands it to one of the four CLI agents
under one of the three conditions, and records the run so a metric can be computed
from it. 4 agents x 3 conditions x 50 tasks x 3 repetitions is the 1,800 runs in
``.knowledge/12-tasks-benchmark/``.

Two properties matter more than anything the harness computes. A run must be
reproducible offline, which is why the whole environment is a locked pixi solve
published to an orphan git branch; and a run must be attributable, which is why a
run record names the tool surface it ran against rather than assuming a constant
one. A harness that cannot tell MCP-5 from MCP-15 measured nothing.

This module is a scaffold. It declares the package identity the environment and the
test suite need, plus the console entry point the airlock gate invokes to prove a
restored environment can run something.
"""

__version__ = "0.1.0"

__all__ = ["__version__"]
