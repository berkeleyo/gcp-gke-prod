# 🧰 RUNBOOK — GKE Service Operations

> Redacted. Replace placeholders <> with environment values. No tenant/org identifiers present.

## On‑Call Quick Links
- GKE workloads: `kubectl -n <ns> get pods`
- Logs: Cloud Logging → `resource.type=k8s_container AND resource.labels.namespace_name=<ns>`
- Metrics: Cloud Monitoring Dashboards
- Deploys: GitHub Actions / Cloud Build history

---

## 1) Access

```bash
gcloud container clusters get-credentials <cluster-name> --zone <zone> --project <project-id>
kubectl config set-context --current --namespace=<ns>
```

Use **Workload Identity** for in‑cluster to-GCP auth. Avoid long‑lived keys.

---

## 2) Routine Health Checks

```bash
kubectl get nodes -o wide
kubectl get pods -o wide
kubectl get deploy,svc,ingress
kubectl describe pod <pod>
kubectl logs -f deploy/<name>
```

- SLO: <99.9%> monthly availability for service endpoint.
- Error Budget policy: throttle rollouts if burned >50% mid‑window.

---

## 3) Deployment

- Rollouts via CI (`kubectl apply -f k8s/`)
- Verify new ReplicaSet is healthy (`kubectl rollout status deploy/<name>`)
- If issues: **rollback** (`kubectl rollout undo deploy/<name>`)

---

## 4) Incident Response

1. Page on‑call
2. Capture timeline + impact (start UTC, scope, user effect)
3. Collect logs, metrics, recent changes
4. Mitigate (scale out, rollback, feature flag)
5. Comms (status page / stakeholders)
6. Post‑mortem within 72h

---

## 5) Backups & Restore

- Store manifests in git.
- Use regional GKE and multi‑zone node pools.
- If using Cloud SQL / stateful stores: schedule automated backups and test restores quarterly.

---

## 6) Cost Guardrails

- Request/limit per Pod set.
- Cluster autoscaler on; set max nodes.
- Use Artifact Registry cleanup policies.
- Monitor egress costs via dashboards.

---

## 7) Security

- Pod Security Standards: baseline/restricted.
- Network Policies: default‑deny + egress allow‑list.
- Image scanning and signed images (Cosign recommended).
- Service Accounts with least‑privilege; no static keys.
- Regular dependency updates.

---

## 8) Change Management

- PRs require review + CI green.
- Tag releases; keep CHANGELOG.
- Freeze windows respected for peak periods.
