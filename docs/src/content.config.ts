// Starlight 0.42 reads its pages through the content-layer loader rather than a
// `src/content/config.ts` collection definition; this file is the whole of it.
// Keep the collection named `docs` — the `slug` entries in astro.config.mjs's
// sidebar resolve against it.

import { defineCollection } from "astro:content";
import { docsLoader } from "@astrojs/starlight/loaders";
import { docsSchema } from "@astrojs/starlight/schema";

export const collections = {
  docs: defineCollection({ loader: docsLoader(), schema: docsSchema() }),
};
