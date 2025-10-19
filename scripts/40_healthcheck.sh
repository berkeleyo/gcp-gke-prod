#!/usr/bin/env bash
set -euo pipefail

: "${NAMESPACE:=prod}"

echo "[*] Objects"
kubectl -n "${NAMESPACE}" get deploy,svc,ingress -o wide

echo "[*] Pods"
kubectl -n "${NAMESPACE}" get pods -o wide

echo "[*] Recent events"
kubectl -n "${NAMESPACE}" get events --sort-by='.lastTimestamp' | tail -n 20
