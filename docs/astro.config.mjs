// @ts-check
import starlight from "@astrojs/starlight";
import { defineConfig } from "astro/config";

// ---------------------------------------------------------------------------
// Published to GitHub Pages as a *project* site by .github/workflows/docs.yml,
// so everything is served under the /geoaiworkbench subpath rather than the
// domain root. `base` applies to `astro dev` too, which is why the dev server
// answers on http://localhost:4321/geoaiworkbench/ and not on /.
//
// Both values are also the reason content never hardcodes an absolute URL: a
// link written as `/geoaiworkbench/guides/…` would break the moment the site
// moved, and a link written as `/guides/…` 404s today. Starlight's `slug`-based
// sidebar entries and relative Markdown links are `base`-aware, so neither
// spelling appears in this repository — see docs/README.md.
// ---------------------------------------------------------------------------
const site = "https://archont561.github.io";
const base = "/geoaiworkbench";

// ---------------------------------------------------------------------------
// The version the site describes comes from the environment, never from a
// literal in a page. `pixi run docs-build` exports GEOAI_VERSION from
// scripts/version.ts — the same script `pixi run version-check` uses to assert
// every manifest agrees — so the number on the site is the number the tree was
// built from. A bare `bun run build` inside docs/ has no such export and falls
// back to "dev": a placeholder that is obviously a placeholder beats a stale
// release tag that looks authoritative.
// ---------------------------------------------------------------------------
const version = process.env.GEOAI_VERSION?.trim() || "dev";

export default defineConfig({
  site,
  base,
  // The preview/dev server is regularly reached through a proxied hostname
  // (Codespaces, a devcontainer port forward, a sandboxed preview URL). Astro
  // rejects unknown Host headers by default, which surfaces as a blank page
  // rather than an error anyone can act on.
  server: {
    host: true,
    allowedHosts: true,
  },
  integrations: [
    starlight({
      title: "geoaiworkbench",
      description:
        "Controlled empirical comparison of three paradigms for LLM-driven GIS automation — and the reproducible environment the comparison is measured in.",
      logo: {
        src: "./src/assets/logo.svg",
        replacesTitle: false,
      },
      favicon: "/favicon.svg",
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/Archont561/geoaiworkbench",
        },
      ],
      editLink: {
        baseUrl: "https://github.com/Archont561/geoaiworkbench/edit/main/docs/",
      },
      customCss: ["./src/styles/custom.css"],
      // Rendered in the footer of every page by Starlight's default layout.
      credits: false,
      lastUpdated: true,
      components: {},
      expressiveCode: {
        themes: ["github-dark", "github-light"],
      },
      sidebar: [
        {
          label: "Start here",
          items: [
            { label: "Introduction", slug: "index" },
            { label: "Installation", slug: "start/installation" },
            { label: "Quickstart", slug: "start/quickstart" },
          ],
        },
        {
          label: "The experiment",
          items: [
            { label: "Three paradigms", slug: "experiment/paradigms" },
            { label: "Metrics", slug: "experiment/metrics" },
          ],
        },
        {
          label: "The repository",
          items: [
            { label: "Two pixi environments", slug: "repository/environments" },
            { label: "The Python packages", slug: "repository/packages" },
            { label: "The task graph", slug: "repository/task-graph" },
            { label: "Offline sandbox", slug: "repository/offline-sandbox" },
          ],
        },
        {
          label: "Reference",
          items: [
            { label: "Pixi tasks", slug: "reference/tasks" },
            { label: "Repository layout", slug: "reference/layout" },
            { label: "Documentation site", slug: "reference/docs-site" },
          ],
        },
      ],
    }),
  ],
  // Exposed to every page and component as `import.meta.env.GEOAI_VERSION`.
  // `vite.define` rather than an `.env` file: the value is derived from the
  // manifest at build time, and a committed `.env` would be a second place the
  // version is written down.
  vite: {
    define: {
      "import.meta.env.GEOAI_VERSION": JSON.stringify(version),
    },
  },
});
