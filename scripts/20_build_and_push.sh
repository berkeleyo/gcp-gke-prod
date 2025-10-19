#!/usr/bin/env bash
set -euo pipefail

: "${PROJECT_ID:?Set PROJECT_ID}"
: "${REGION:?Set REGION}"
: "${AR_REPO:=apps}"
: "${IMAGE:=sample}"
: "${TAG:=v0.1.0}"

IMAGE_URI="${REGION}-docker.pkg.dev/${PROJECT_ID}/${AR_REPO}/${IMAGE}:${TAG}"

echo "[*] Building ${IMAGE_URI} ..."
cat > Dockerfile <<'EOF'
FROM gcr.io/distroless/base-debian12
WORKDIR /app
# Demo: tiny HTTP server with busybox
COPY --from=busybox:latest /bin/busybox /bin/busybox
EXPOSE 8080
CMD ["/bin/busybox","httpd","-f","-p","8080","-h","/app"]
EOF

docker build -t "${IMAGE_URI}" .
docker push "${IMAGE_URI}"

echo "[*] Built and pushed ${IMAGE_URI}"
