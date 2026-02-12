# dashboard-template

## Deployment + Tracking
- [x] Ensure `values.yaml` uses correct namespace + hostname
- [x] Ensure Plausible `data-domain` matches production hostname

## Deployment Sync (Prod)
- [ ] ArgoCD sync stuck: cluster deployment still on image `:14` while repo `values.yaml` is `:17`
- [ ] After sync, re-validate `/dashboard` has no console errors (fix is already in repo; prod still shows `deltaPct.toFixed`)

## Branding + Content
- [x] Replace remaining "Simple Site" / "simple-template" references in UI copy
- [x] Update footer contact email + GitHub link
- [x] Replace `public/favicon.svg` and add a site-specific logo if needed

## Validation
- [x] Run `cd site && npm ci && npm run build`
- [x] Run `cd site && npm run preview` and smoke test locally
- [ ] Smoke test production: `https://dashboard-template.buildville.cloud` (currently shows console error on `/dashboard`)

## CI/CD Blockers
- [x] GitHub Actions registry push secrets present (recent runs succeed)
- [ ] Ensure cluster can pull and roll out new tags (prod currently not updating beyond `:14`)
