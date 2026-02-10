# dashboard-template

## Deployment + Tracking
- [ ] Ensure `values.yaml` uses correct namespace + hostname
- [ ] Ensure Plausible `data-domain` matches production hostname

## Branding + Content
- [x] Replace remaining "Simple Site" / "simple-template" references in UI copy
- [x] Update footer contact email + GitHub link
- [x] Replace `public/favicon.svg` and add a site-specific logo if needed

## Validation
- [x] Run `cd site && npm ci && npm run build`
- [x] Run `cd site && npm run preview` and smoke test locally
- [ ] Smoke test production: `https://dashboard-template.buildville.cloud`

## CI/CD Blockers
- [ ] Fix GitHub Actions secrets for registry push (`BUILDVILLE_REGISTRY_USERNAME` / `BUILDVILLE_REGISTRY_PASSWORD`)
- [ ] Ensure cluster has working image pull secret (`buildville-registry-credentials`) so pods can pull `registry.buildville.cloud/buildville/dashboard-template:*`
