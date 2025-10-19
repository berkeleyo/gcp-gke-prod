# CUTOVER_CHECKLIST

- [ ] CAB approved change with backout plan
- [ ] Target release tagged and images present in Artifact Registry
- [ ] Ingress and DNS prepared (TTL lowered if external DNS)
- [ ] Secrets created in Secret Manager and mounted/injected
- [ ] Baseline runbooks reviewed, SLO monitors green
- [ ] Feature flags / config maps staged
- [ ] `kubectl apply -f k8s/` to progressive environments
- [ ] Smoke tests passed; health checks green
- [ ] Post‑deploy verification signed off
- [ ] Update status page and notify stakeholders
