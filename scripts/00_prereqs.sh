#!/usr/bin/env bash
set -euo pipefail

: "${PROJECT_ID:?Set PROJECT_ID}"
: "${REGION:?Set REGION}"
: "${ZONE:?Set ZONE}"
: "${AR_REPO:=apps}"

echo "[*] Enabling required APIs..."
gcloud services enable container.googleapis.com artifactregistry.googleapis.com --project "$PROJECT_ID"

echo "[*] Creating Artifact Registry (if not exists)..."
gcloud artifacts repositories create "$AR_REPO"       --repository-format=docker --location="$REGION"       --description="App images" || echo "Repository may already exist."

echo "[*] Configuring Docker auth for Artifact Registry..."
gcloud auth configure-docker "${REGION}-docker.pkg.dev" --quiet
