# geoaiworkbench

> Controlled empirical comparison of three paradigms for LLM-driven GIS automation.

**This repository is configuration and orchestration only.** The three Python packages
under `python/` are scaffolds: manifests, imports, one version test each, and no
benchmark logic. Nothing here runs a benchmark. The comparison itself belongs to a
different repository; this one is the environment those results would be measured in,
and that measurement is only credible if the environment is reproducible — which is
what all of the below is for.

## The packages

| Package | What it is | What it is not |
| --- | --- | --- |
| `python/geoai-core` | Manifests, the import, the version test. | Any shared implementation. |
| `python/geoai-mcp` | The package that will carry an MCP server. | An MCP server, or any tools. |
| `python/geoai-bench` | A Typer/Rich console script (`geoai-bench`). | A benchmark harness. |

All three are **path source dependencies** of the root environment, so `pixi install`
materialises them into `.pixi/envs/default` and `import geoai_core` works from any
command in the project. `pixi run verify-packages` is the gate that proves it.

There are two Pixi environments and the split is forced, not tidy: QGIS pins `icu78.3`
and bun pins `icu75.1`, and no `icu` satisfies both. `default` carries QGIS, Python and
the git instruments; `bun` carries bun and nothing else. `pixi install --all` installs
both, and every task knows which one it needs.

## Start here

```bash
pixi install --frozen --all  # both environments; --frozen makes a stale lockfile an error
pixi run gates               # every check that must pass before a commit lands
```

Everything else is a `pixi run` task. `pixi run --help` lists them; the ones that
matter first:

| Task | What it does |
| --- | --- |
| `pixi run gates` | The check list. Lints, tests, version agreement, package registration, publish resolution. |
| `pixi run ci` | `gates` plus the format-drift rewrite, the built packages, and coverage. Same script the lefthook `pre-push` hook and CI run. |
| `pixi run test` | Every package's tests, as one turbo fan-out. |
| `pixi run -e bun bun x turbo …` | Any bun command, in the bun environment. |
| `pixi run sandbox-restore` | Reconstruct the environment offline from its git branch. |
| `pixi run backlog -- <args>` | The task backlog. The `--` is required. |

## How it fits together

```
pixi.toml          two environments, every task, and the single owner of the check list
├── default/       QGIS, the Python toolchain, convco/lefthook/actionlint/taplo
├── bun/           bun, and nothing else. The only JavaScript runtime:
│                  `bun run` / `bun x`, never node_modules/.bin
├── python/*/      three packages, registered as [package] path source dependencies.
│                  Their scripts run `pixi run -e default -- …`, because turbo lives
│                  in the bun environment and the interpreter does not (see AGENTS.md)
├── turbo.json     the fan-out
├── biome          JSON and TypeScript, scoped by .gitignore
├── taplo          pixi.toml and .pixi-sandbox.toml only (scripts/lint-toml.sh)
└── .pixi-sandbox.toml   what the offline transport contains, reviewed in the open
```

`AGENTS.md` is the file to read before changing any of it. Most of the non-obvious
decisions in this repository — why two environments, why every nested `pixi run` names
`-e`, why Python caching is off, why the coverage scripts set `COVERAGE_FILE`, why
`package.json` lists `python` twice — are recorded there with the reasoning, because JSON
and TOML cannot carry it themselves.

## Offline by construction

The claim this repository makes is that a machine with no network can reconstruct a
working environment from a git branch. [pixi-sandbox](https://github.com/Archont561/pixi-sandbox)
owns that surface, and this repository uses three of its tasks rather than a second CI
workflow of its own:

- `pixi run sandbox-plan` validates the reviewed publish plan (both environments, one
  branch, linux-64) and runs in its own CI job, because a malformed contract should not
  wait behind a QGIS solve.
- `pixi run sandbox-pack` then `pixi run sandbox-doctor` packs a transport and verifies
  every declared byte against it, locally.
- `.github/workflows/publish-sandbox.yml` does the real publish, on a push that touched
  an input of the snapshot. Every third-party action is pinned to a 40-character commit
  SHA, which `pixi run lint-actions` (actionlint) enforces.

## Development

`.devcontainer/` builds the whole thing: the locked environment, the Bun workspace, the
git hooks, and opencode on `PATH`. There is no Node.js in it, deliberately — every
`.bin` entry in `node_modules` carries a `node` shebang this project does not provide.

Commit messages are conventional-commit and checked by `convco` through a git hook, so
the format is decided for you by what failed.

## Licence

GPL-2.0-or-later.
