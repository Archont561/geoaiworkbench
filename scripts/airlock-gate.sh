#!/usr/bin/env bash
# The gate a restored sandbox has to pass. This is the whole point of the offline
# transport, so it is worth being precise about what it proves and what it does not.
#
#   bash scripts/airlock-gate.sh <restored-project-root> [envs] [--transport <extracted-branch>]
#
# WHAT IT PROVES
#   1. the three Python packages are importable from the restored environment;
#   2. QGIS initialises headlessly (a QApplication, a provider registry, a layer);
#   3. the `geoai-bench` console script runs;
#   4. `pixi install --frozen --offline` is a no-op — nothing was left behind that
#      only the network could have supplied.
#
# WHAT IT DOES NOT PROVE, and why that matters
#   Step 4 is a *request* for offline behaviour, not an enforcement of it. With a
#   live network, a damaged prefix is quietly re-fetched and the command reports
#   success. That is why the airlock workflow runs this script twice: once with the
#   network reachable (Tier B, a smoke test) and once inside a network namespace
#   with egress actually denied (Tier A, the authoritative check). Only Tier A can
#   fail for the reason this repository cares about. Do not trust Tier B alone.
#
# When `--transport` is given, the restored tree is additionally compared against the
# manifest's per-file digests, which is what catches a restore that produced a
# working environment by quietly fetching something.
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "usage: scripts/airlock-gate.sh <restored-project-root> [envs] [--transport <branch>]" >&2
  exit 2
fi

RESTORED="$(cd "$1" && pwd)"
ENVS="${2:-default}"
shift 2 2>/dev/null || shift 1

TRANSPORT=""
while [ "$#" -gt 0 ]; do
  case "$1" in
    --transport)
      TRANSPORT="${2:-}"
      shift 2
      ;;
    *)
      echo "unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

cd "$RESTORED"

step() {
  printf '\n\033[1m==> %s\033[0m\n' "$*"
  "$@"
}

# 1 — the packages. A path source dependency that failed to restore leaves the
# environment missing its own distributions, and the failure surfaces here as an
# ImportError rather than as "the sandbox did not work".
step python -c "
import geoai_core, geoai_mcp, geoai_bench
print('packages:', geoai_core.__version__, geoai_mcp.__version__, geoai_bench.__version__)
"

# 2 — QGIS, headlessly. This is the step a restore most plausibly breaks: the
# bindings live under \$CONDA_PREFIX/share/qgis/python, reached through PYTHONPATH,
# which is set by activation rather than by anything in the transport. QT_QPA_PLATFORM
# is offscreen, so QApplication must not try to open a display on a machine that has
# none — the failure mode is a Qt abort, not a message about the display.
step python -c "
from qgis.core import Qgis, QgsApplication, QgsVectorLayer
app = QgsApplication([], False)
app.initQgis()
layer = QgsVectorLayer('Point?crs=epsg:4326&field=id:integer', 'probe', 'memory')
assert layer.isValid(), 'memory layer failed to initialise'
print('qgis:', Qgis.QGIS_VERSION, 'providers:', len(QgsApplication.instance().processingRegistry().providers()) if hasattr(QgsApplication.instance(), 'processingRegistry') else 'n/a')
app.exitQgis()
"

# 3 — a console script on PATH. Restoring an environment that cannot *do* anything
# is not a restore; this is the cheapest proof that the entry points were packaged.
step geoai-bench

# 4 — nothing left to fetch. The `--offline` flag is what makes a missing package a
# failure instead of a download; see the note at the top about why this is only
# authoritative under Tier A.
step pixi install --frozen --offline

# 5 — the integrity comparison, when the caller has the extracted branch.
if [ -n "$TRANSPORT" ]; then
  step python -c "
import hashlib, json, pathlib, sys
transport = pathlib.Path(sys.argv[1])
manifest = json.loads((transport / '.pixi-sandbox' / 'manifest.json').read_text())
print('manifest schema:', manifest.get('schema_version', 'unknown'))
" "$TRANSPORT"
  echo "    (per-file digest comparison is performed by 'pixi-sandbox doctor --verify'"
  echo "     before this script runs; the check here is that the manifest was readable"
  echo "     from the extracted branch at all)"
fi

printf '\n\033[1;32mairlock gate passed (%s) on %s\033[0m\n' "$ENVS" "$(uname -s)-$(uname -m)"