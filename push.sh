#!/bin/bash
set -euo pipefail

# Dashboard Template - Container Build and Push Script
# Usage: ./push.sh [--dry-run]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Configuration
REGISTRY="registry.buildville.cloud"
DRY_RUN=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Extract configuration from values.yaml
# Prefer yq, fall back to python (PyYAML) for portability.
if command -v yq &> /dev/null; then
  IMAGE_REPO=$(yq '.image.repository' values.yaml)
  CURRENT_TAG=$(yq '.image.tag' values.yaml)
  SITE_NAME=$(yq '.site.name' values.yaml)
else
  read -r IMAGE_REPO CURRENT_TAG SITE_NAME < <(python3 - <<'PY'
import yaml
with open('values.yaml','r') as f:
    v=yaml.safe_load(f)
print(v['image']['repository'], v['image']['tag'], v.get('site',{}).get('name',''))
PY
  )
fi

# Increment tag
NEW_TAG=$((CURRENT_TAG + 1))
IMAGE="${IMAGE_REPO}:${NEW_TAG}"

echo "================================================"
echo "Dashboard Template - Build & Push"
echo "================================================"
echo "Site:     $SITE_NAME"
echo "Image:    $IMAGE"
echo "Dry Run:  $DRY_RUN"
echo "================================================"

# Build the site
echo ""
echo "Step 1: Building Astro site..."
cd site
npm ci
npm run build
cd ..

# Build Docker image
echo ""
echo "Step 2: Building Docker image..."
docker build -t "$IMAGE" -f site/docker/Dockerfile site/

if [ "$DRY_RUN" = true ]; then
    echo ""
    echo "Dry run mode - skipping push and values.yaml update"
    exit 0
fi

# Push to registry
echo ""
echo "Step 3: Pushing to registry..."
docker push "$IMAGE"

# Update values.yaml
echo ""
echo "Step 4: Updating values.yaml..."
if command -v yq &> /dev/null; then
  yq -i ".image.tag = \"$NEW_TAG\"" values.yaml
else
  python3 - <<PY
import yaml
p='values.yaml'
with open(p,'r') as f:
    v=yaml.safe_load(f)
v['image']['tag']=str(${NEW_TAG})
with open(p,'w') as f:
    yaml.safe_dump(v,f,sort_keys=False)
PY
fi

echo ""
echo "================================================"
echo "Build complete!"
echo "Image pushed: $IMAGE"
echo "values.yaml updated with tag: $NEW_TAG"
echo ""
echo "Next steps:"
echo "  1. git add values.yaml"
echo "  2. git commit -m 'chore: bump image tag to $NEW_TAG'"
echo "  3. git push"
echo "================================================"
