#!/usr/bin/env bash
# One-time devcontainer setup: install the locked environments, install the Bun
# workspace, register the git hooks, and put opencode on PATH.
#
# It does NOT install the QGIS environment before pixi has read the lockfile, and it
# does not `pixi run setup` — that task would be circular here, because pixi itself
# has to be on PATH before any task can run, and the task list is a large thing to
# discover as a side effect of opening a folder. The explicit sequence below is also
# the sequence that makes a failure point at the step that actually failed.
set -euo pipefail

# No Node.js in this devcontainer, by design — see the header of pixi.toml for why
# QGIS and bun share one environment and bun is the only JavaScript runtime. Anything
# with a `node` shebang (`node_modules/.bin/*`, an npm-installed CLI) is unreachable
# here, which is exactly why every JS tool in pixi.toml goes through `bun x`.
export BUN_INSTALL="$HOME/.bun"
mkdir -p "$BUN_INSTALL/bin"

pixi --version

# 1. The environment. `--frozen` makes a stale pixi.lock an error rather than a silent
#    re-solve: the lockfile IS the environment, and a container that quietly solved
#    something else is a container whose test results mean nothing.
echo "==> installing the locked environment"
pixi install --frozen

# Past this line the environment is activated by every `pixi run`, which is also the
# first moment `bun` is on PATH. Checking for it any earlier would be checking the
# base image's PATH, which says nothing about this project.
pixi run bun --version

# 2. The Bun workspace: turbo, biome, backlog, and the skills CLI.
echo "==> installing the Bun workspace"
pixi run bun-install

# 3. Git hooks. `lefthook install` is idempotent, so re-running setup.sh is safe.
echo "==> registering the git hooks"
pixi run hooks-install

# 4. opencode, into BUN_INSTALL rather than the pixi prefix, so it is on PATH for
#    ordinary shells and not only for `pixi run` ones. This deliberately does NOT call
#    the `opencode-install` pixi task: that one symlinks into /usr/local/bin, which the
#    non-root devcontainer user cannot write, and its ~/.local/bin fallback is not on
#    PATH here — so in a container only the BUN_INSTALL route actually works. Pinned:
#    the model catalog is refreshed independently of the CLI version, so the two can
#    move without either being wrong.
echo "==> installing opencode"
pixi run env BUN_INSTALL="$BUN_INSTALL" bun install --global --no-audit --no-fund opencode-ai@1.18.33

# bashrc rather than bash_profile: an interactive devcontainer shell is started without
# a login flag, so bash_profile is skipped.
grep -q 'HOME/.bun/bin' "$HOME/.bashrc" 2>/dev/null ||
  printf '\nexport PATH="$HOME/.bun/bin:$PATH"\n' >>"$HOME/.bashrc"
export PATH="$BUN_INSTALL/bin:$PATH"

opencode --version

# Refreshing needs the model catalog, not provider credentials. OpenCode may fall back
# to its bundled list even when the fetch fails, so a zero exit status is not evidence
# of a download — hence the wording below.
if opencode models --refresh >/dev/null 2>&1; then
  echo "OpenCode model refresh attempted; rerun 'opencode models --refresh' if offline."
else
  echo "OpenCode model refresh unavailable; rerun 'opencode models --refresh' when online." >&2
fi

echo
echo "devcontainer ready. Try:"
echo "  pixi run gates      # the check list that must pass"
echo "  pixi run test       # every package's tests, one turbo fan-out"
echo "  pixi run backlog    # the task backlog (note the trailing -- for arguments)"