# Website

| Folder | What | Deployed |
|---|---|---|
| [`v1/`](v1/) | loupe.mx as it is live today | Yes: `.github/workflows/site.yml` deploys it on pushes to `main` that touch `site/v1/` |
| [`v2/`](v2/) | The redesign, with the Private AI preview (`/private-ai/`) | No: built on pull requests to check it, never deployed. Its `wrangler.jsonc` has its own name and no routes |

Both are independent Astro projects with their own `package.json`; see each folder's README.

```sh
cd site/v2
npm ci
npm run dev                    # http://localhost:4321
npm run build && npx astro preview
```

When v2 replaces v1, copy `v1/worker-www/` and the `routes` in `v1/wrangler.jsonc` into it, point `site.yml` at `site/v2`, and update the paths in `app/screenshots/screenshots_test.dart`, `tool/screenshots.sh` and `marketing/creative/`.
