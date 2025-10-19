#!/usr/bin/env bash
set -euo pipefail

: "${PROJECT_ID:?Set PROJECT_ID}"
: "${REGION:?Set REGION}"
: "${ZONE:?Set ZONE}"
: "${CLUSTER_NAME:=gke-sample}"
: "${NETWORK:=default}"
: "${SUBNET:=default}"

echo "[*] Creating GKE cluster (standard mode)..."
gcloud container clusters create "$CLUSTER_NAME"       --project "$PROJECT_ID" --zone "$ZONE"       --machine-type "e2-standard-4" --num-nodes "2"       --enable-ip-alias --network "$NETWORK" --subnetwork "$SUBNET"       --workload-pool="${PROJECT_ID}.svc.id.goog"       --release-channel "regular"       --quiet

echo "[*] Getting credentials..."
gcloud container clusters get-credentials "$CLUSTER_NAME" --zone "$ZONE" --project "$PROJECT_ID"
