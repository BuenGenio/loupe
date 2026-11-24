# Website

| Folder | What | Deployed |
|---|---|---|
| [`v1/`](v1/) | Archived previous design | No: retained for reference; excluded from automatic deployment |
| [`v2/`](v2/) | Production site, with the Private AI preview (`/private-ai/`) | Yes: `.github/workflows/site.yml` deploys it on pushes to `main` that touch `site/v2/` and rebuilds daily |

Both are independent Astro projects with their own `package.json`. Use v2 for website changes; see its [README](v2/README.md).

```sh
cd site/v2
npm ci
npm run dev                    # http://localhost:4321
npm run build && npx astro preview
```

The production Worker is still named `loupe-site`, serving `loupe.mx`, so its existing secret bindings remain in use. The separate `loupe-www-redirect` Worker redirects `www.loupe.mx` to the apex and lives in `v2/worker-www/`. Deploy both from v2; the v1 Wrangler configuration is historical and must not be used for production updates.
