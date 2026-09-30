#!/usr/bin/env bash
# taplo canonicality check.
#
# Only pixi.toml and .pixi-sandbox.toml are kept in taplo's canonical form. The rest
# of the repository uses the aligned-`=` style deliberately, and taplo would reformat
# all of it — so the check is scoped rather than repo-wide, and this wrapper is the
# only place that scope is written down.
#
# The wrapper exists at all because of what a bare `taplo format --check` does: it
# takes no path, walks the whole working tree, and reports 107 files, of which 100
# are PyQt5's and sipbuild's vendored pyproject.toml files inside
# `.pixi/envs/default/lib/python3.12/site-packages/`. A gate that reads conda's
# manifests will fail the moment conda changes one, and it says so in terms nobody
# reviewing a PR for a QGIS bump can act on.
#
# Arguments override the list, which is how lefthook uses it: staged TOML files only.
set -euo pipefail
# shellcheck source=scripts/lib.sh
source "$(dirname "$0")/lib.sh"

if [ "$#" -gt 0 ]; then
  taplo fmt --check "$@"
else
  taplo fmt --check pixi.toml .pixi-sandbox.toml
fi