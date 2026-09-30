# Sourced by every script here; never executed directly.
#
# NOTE the name: it must not start with an underscore. The reference repository this
# borrows the trick from had a `_*` rule in .gitignore, so its `_common.sh` was
# silently never committed and CI failed with "No such file or directory" on a file
# that existed on every developer's machine. .gitignore here has no such rule; the
# constraint is recorded so nobody "tidies" the filename.
#
# One job: put the caller at the repository root and expose it as REPO_ROOT, so a
# script behaves identically whether it was started by a pixi task (cwd = repo root),
# by a package.json script (cwd = that package), by lefthook, or by a human from a
# random subdirectory. A script that assumes its cwd was reached the right way is a
# script that works for exactly one of those four callers.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export REPO_ROOT
cd "$REPO_ROOT"