# Offline sandbox (orphan branch)

Built 2026-10-03T22:28:25Z from commit `3c2e10b` for platform `linux-64`.
`pixi.lock` sha256 `99d4b45762318bad6dfb5ac6174670fc241b68bd81dd558c5aceddd97f332570`.

The verified self-bootstrap binary is stored at `.pixi-sandbox/tools/linux-64/pixi-sandbox`. The branch root intentionally contains documentation only.

| env | platform | packed | unpacked | files |
| --- | --- | ---: | ---: | ---: |
| `bun` | linux-64 | 47.0 MiB | 171.4 MiB | 34 |
| `default` | linux-64 | 641.2 MiB | 2784.3 MiB | 401 |

## Restore on the disconnected machine

```bash
./.pixi-sandbox/tools/linux-64/pixi-sandbox doctor --branch-location . --verify
./.pixi-sandbox/tools/linux-64/pixi-sandbox restore --branch-location . --output-path <project> --force
# then, from <project> with no network, use pixi as the sole entrypoint:
pixi install --frozen --offline
pixi run --frozen -- cargo build --offline
```

Every manifest blob is verified before it is written into the working tree.
