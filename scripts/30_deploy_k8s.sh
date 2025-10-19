#!/usr/bin/env bash
set -euo pipefail

: "${PROJECT_ID:?Set PROJECT_ID}"
: "${REGION:?Set REGION}"
: "${AR_REPO:=apps}"
: "${TAG:=v0.1.0}"
: "${NAMESPACE:=prod}"

kubectl get ns "${NAMESPACE}" >/dev/null 2>&1 || kubectl apply -f k8s/namespace.yaml --filename - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: ${NAMESPACE}
  labels:
    app.kubernetes.io/part-of: sample-service
EOF

sed -e "s#<ns>#${NAMESPACE}#g"         -e "s#<REGION>-docker.pkg.dev/<PROJECT_ID>/<AR_REPO>/sample:<TAG>#${REGION}-docker.pkg.dev/${PROJECT_ID}/${AR_REPO}/sample:${TAG}#g"         k8s/deployment.yaml | kubectl apply -f -

sed -e "s#<ns>#${NAMESPACE}#g" k8s/service.yaml | kubectl apply -f -
sed -e "s#<ns>#${NAMESPACE}#g" k8s/ingress.yaml | kubectl apply -f -

echo "[*] Waiting for rollout..."
kubectl -n "${NAMESPACE}" rollout status deploy/sample-deployment --timeout=180s
