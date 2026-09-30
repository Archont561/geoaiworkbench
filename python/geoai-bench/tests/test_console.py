"""The console entry point named by ``[project.scripts]``.

The scaffold has exactly one function worth covering, and it is this one: everything
else in ``__main__`` is module-level wiring for Typer and Rich. The assertions are
about the *installed chain* rather than about any output — the console script, the
editable install of ``geoai_bench``, and ``typer`` and ``rich`` resolving from the root
environment — because that chain is what a restored sandbox has to be able to run.

Output is asserted through Typer's own runner instead of by capturing stdout. Rich
decides its own width from the terminal, so a line-length assertion passes locally and
fails in CI; asserting on the substring that must be present is stable across both.
"""

from __future__ import annotations

import click
import pytest
from geoai_bench import __version__
from geoai_bench.__main__ import app, main
from typer.main import get_command
from typer.testing import CliRunner

runner = CliRunner()


def test_bare_invocation_reports_the_scaffold() -> None:
    """``geoai-bench`` with no subcommand runs the single command.

    A Typer app with exactly one command collapses to that command, so there is no
    subcommand to name. This asserts the collapse, which is the part that is easy to
    break by adding a second command later.
    """
    result = runner.invoke(app, [])

    assert result.exit_code == 0, result.output
    assert __version__ in result.output
    assert "scaffold" in result.output


def test_main_delegates_to_the_app() -> None:
    """The entry point is wired to the app rather than being a second implementation.

    Asserted by invoking ``main`` and checking it does not raise — ``main()`` reads
    ``sys.argv``, which under pytest is the pytest argument list, so the clickable
    command exits on pytest's own options rather than running. A SystemExit is the
    expected outcome and is what makes the call meaningful; a TypeError would mean the
    entry point was never wired to the app at all.

    The second assertion is the collapse, restated at the level Typer actually
    implements it: an app with exactly one command resolves to that command directly,
    so ``get_command`` returns a ``TyperCommand`` and not a ``click.Group``. It is here
    because ``test_bare_invocation_reports_the_scaffold`` only proves that *something*
    runs — adding a second command later would break the bare invocation and this one
    together, which is the intended signal.
    """
    with pytest.raises(SystemExit):
        main()

    assert not isinstance(get_command(app), click.Group)
