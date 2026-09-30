"""The package's declared version, asserted against the import.

A test that a package is importable from the environment is a test of the
orchestration, not of the package: it fails when the path source dependency in the
root `pixi.toml` stops resolving, and that is a different bug from anything in this
module.
"""

from geoai_mcp import __version__


def test_version_is_declared() -> None:
    """The package exposes a version string."""
    assert __version__
