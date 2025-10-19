#!/usr/bin/env bash
set -euo pipefail

: "${PROJECT_ID:?Set PROJECT_ID}"
: "${ZONE:?Set ZONE}"
: "${CLUSTER_NAME:=gke-sample}"

echo "[*] Deleting cluster ${CLUSTER_NAME} ..."
gcloud container clusters delete "$CLUSTER_NAME" --zone "$ZONE" --project "$PROJECT_ID" --quiet || true
