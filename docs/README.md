# docs

The documentation site: [Astro](https://astro.build) +
[Starlight](https://starlight.astro.build), published to GitHub Pages at
<https://archont561.github.io/geoaiworkbench/>.

It is a member of the root Bun workspace, so it needs no separate install and carries
no lockfile of its own — `bun.lock` at the repository root is the single resolution
record for every member.

## Commands

```bash
pixi run docs-dev       # dev server, http://localhost:4321/geoaiworkbench/
pixi run docs-build     # astro check && astro build → docs/dist/
pixi run docs-preview   # serve the built output
```

All three go through turbo (`--filter=@geoaiworkbench/docs`) so the build shares the
repository's task cache. `pixi run build` builds this site along with everything
else.

Without pixi — supported, but pixi is what CI runs and what pins the toolchain:

```bash
bun install --frozen-lockfile
bun run --cwd docs dev
```

## Structure

```
docs/
├── astro.config.mjs      site, base, sidebar, and the version substitution
├── turbo.json            the only package whose build has cacheable outputs
├── tsconfig.json         extends astro/tsconfigs/strict
├── public/favicon.svg
└── src/
    ├── content.config.ts the `docs` collection (Starlight's loader + schema)
    ├── content/docs/     the pages
    ├── components/       landing-page pieces
    ├── styles/custom.css the accent ramp and the grid primitives
    └── assets/logo.svg
```

## Two rules

**The site is served from a subpath.** `astro.config.mjs` sets
`base: "/geoaiworkbench"`, because GitHub Pages serves a project site under the
repository name. Link between pages with relative Markdown links, and add sidebar
entries with `slug` rather than `link` — both are `base`-aware and both are validated
at build time. A root-absolute `/repository/packages/` 404s in production; a
hardcoded `/geoaiworkbench/repository/packages/` breaks the moment the site moves.
`base` applies to the dev server too, which is why `http://localhost:4321/` is a 404
and `/geoaiworkbench/` is the home page.

**No page states a release number.** `pixi run docs-build` exports `GEOAI_VERSION`
from `scripts/version.ts`; `astro.config.mjs` exposes it as
`import.meta.env.GEOAI_VERSION`. A bare `bun run build` falls back to `dev`.

## Deployment

[`.github/workflows/docs.yml`](../.github/workflows/docs.yml) builds on pull requests
and publishes on pushes to `main` that touch the docs or their inputs. GitHub Pages
must be switched to the Actions source once by an admin (*Settings → Pages → Build
and deployment → Source: GitHub Actions*), or the deploy job fails with *"Get Pages
site failed"*.

The published output in `dist/` is plain static files, so it would equally serve from
Netlify, Vercel or Cloudflare Pages — keep `site`/`base` in `astro.config.mjs` in
step with wherever it is hosted.
