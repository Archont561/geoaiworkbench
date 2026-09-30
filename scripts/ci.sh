#!/usr/bin/env bash
# THE gate. `pixi run ci` locally, the lefthook `pre-push` hook, and the CI job all
# run exactly this file, so "passes on my machine" and "passes in Actions" cannot come
# to mean different things.
#
#   bash scripts/ci.sh                # everything
#   bash scripts/ci.sh --no-coverage  # the pre-push loop
#
# WHAT LIVES WHERE, so this file stays short enough to trust:
#
#   pixi.toml `gates` owns the *list* of checks. This script does not restate it — it
#   calls `pixi run gates`. One owner of "what must pass", or the two entry points
#   drift and CI becomes the only place the difference is discoverable.
#
#   This script owns the *order* and the *producers*. Order is not expressible in a
#   `depends-on` list worth relying on, and it matters: the cheap repository-global
#   lints fail in seconds, so a malformed workflow should not be discovered after a
#   pytest run and three path-source package builds. Coverage runs last because it is
#   the slowest producer and its only output is an artefact.
set -euo pipefail
# shellcheck source=scripts/lib.sh
source "$(dirname "$0")/lib.sh"

coverage=1
rewrite=1
for arg in "$@"; do
  case "$arg" in
    --no-coverage) coverage=0 ;;
    --no-rewrite) rewrite=0 ;;
    -h | --help)
      sed -n '2,17p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "scripts/ci.sh: unknown argument: $arg" >&2
      echo "usage: scripts/ci.sh [--no-coverage] [--no-rewrite]" >&2
      exit 2
      ;;
  esac
done

# Fail the gate the moment a step fails. `set -e` is not enough on its own: the
# commands here are pixi tasks, and whether a failure propagates out of a task's shell
# depends on the task, not on this script.
step() {
  printf '\n\033[1m==> %s\033[0m\n' "$*"
  "$@"
}

# ── 1. the gate itself ─────────────────────────────────────────────────────────
# lint (ruff, turbo fan-out) → lint-js (biome) → lint-toml (taplo) → lint-actions
# (actionlint) → test → version-check → verify-packages → publish-plan.
step pixi run gates

# ── 2. format drift ───────────────────────────────────────────────────────────
# Separate from `lint` on purpose. `ruff format --check` and `biome check` each only
# report drift in the files they own; what makes drift a *gate* is refusing to
# continue once the formatter has said it would change something. Without this the
# `--check` in the lint step is advisory, and advisory format checks do not stay
# clean. `--no-rewrite` skips this step for a contributor who only wants the tests;
# CI always runs it, because the whole point is that the working tree is unchanged.
if [ "$rewrite" -eq 0 ]; then
  printf '\n\033[1m==> format drift (rewrite check skipped)\033[0m\n'
else
  # Both formatters, not just one: `pixi run fmt` is the turbo fan-out over the Python
  # packages (ruff), `pixi run fmt-js` is biome over the repository's JSON and
  # TypeScript. Either alone leaves the other family's drift unrewritten and therefore
  # undetected by the diff below.
  step pixi run fmt
  step pixi run fmt-js
  if ! git diff --exit-code --quiet; then
    echo >&2
    echo "formatting drift — a formatter changed files that were not staged:" >&2
    git --no-pager diff --stat >&2
    exit 1
  fi
fi

# ── 3. the publishable set actually builds ─────────────────────────────────────
# `publish-plan` already resolved it; this is the step that produces the artefacts a
# release would upload. Also the check that the hatchling backend can build a wheel
# from a path source dependency, which resolution alone does not prove.
step pixi run publish-dist

# ── 4. coverage ────────────────────────────────────────────────────────────────
# Last, and outside `gates`: the slowest producer, and the only step whose output
# exists to be uploaded rather than read.
if [ "$coverage" -eq 1 ]; then
  step pixi run cov
fi

printf '\n\033[1;32mgate passed\033[0m\n'