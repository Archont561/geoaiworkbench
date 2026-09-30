"""Console entry point for the ``geoai-bench`` harness.

Declared as ``[project.scripts] geoai-bench`` in ``pyproject.toml``, so installing
the package puts ``geoai-bench`` on the environment's ``PATH``. That is what makes
the package a tool rather than a library: a restored sandbox has to be able to *do*
something, not merely import.

The command is intentionally a stub that reports the scaffold's state. It exists to
exercise the whole installed chain — the console script, the editable install of
``geoai_bench``, ``typer`` and ``rich`` from PyPI — in one process.

No gate runs it. ``pixi run verify-packages`` covers the import half; the console
script is the half nothing invokes yet, because the workflow that used to (the airlock
proof) is gone with the rest of pixi-sandbox's. The seam is one line in that task:
``geoai-bench`` on its own is the cheapest possible proof that ``PATH`` works.
"""

from __future__ import annotations

import typer
from rich.console import Console

from geoai_bench import __version__

app = typer.Typer(
    add_completion=False,
    help="GeoAnalystBench harness (scaffold — no benchmark logic implemented yet).",
)
console = Console()


@app.command()
def scaffold() -> None:
    """Report the scaffold's state and exit.

    A Typer app with exactly one command *is* that command, so this runs as a bare
    `geoai-bench` with no subcommand. The name says what it is rather than
    `version`, which would promise a flag that does not exist.
    """
    console.print(f"geoai-bench {__version__} — scaffold, no benchmark logic implemented yet.")


def main() -> None:
    """Console-script entry point named by ``[project.scripts]``."""
    app()


if __name__ == "__main__":
    main()  # pragma: no cover — reached by `python -m geoai_bench`, never by pytest
