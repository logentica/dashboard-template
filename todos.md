# dashboard-template

## Deployment + Tracking
- [ ] Ensure `values.yaml` uses correct namespace + hostname
- [ ] Ensure Plausible `data-domain` matches production hostname

## Branding + Content
- [ ] Replace remaining "Simple Site" / "simple-template" references in UI copy
- [ ] Update footer contact email + GitHub link
- [ ] Replace `public/favicon.svg` and add a site-specific logo if needed

## Validation
- [ ] Run `cd site && npm ci && npm run build`
- [ ] Run `cd site && npm run preview` and smoke test locally
- [ ] Smoke test production: `https://dashboard-template.buildville.cloud`

## CI/CD Blockers
- [ ] Fix GitHub Actions secrets for registry push (`BUILDVILLE_REGISTRY_USERNAME` / `BUILDVILLE_REGISTRY_PASSWORD`)
- [ ] Ensure cluster has working image pull secret (`buildville-registry-credentials`) so pods can pull `registry.buildville.cloud/buildville/dashboard-template:*`
