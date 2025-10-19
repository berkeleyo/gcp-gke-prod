# ARCHITECTURE

- **Network:** Regional GKE, private nodes (optional), authorized networks for control plane
- **Ingress:** Cloud Load Balancer → GKE Ingress/Gateway
- **Registry:** Artifact Registry (scoped to region)
- **Identity:** Workload Identity (no JSON keys)
- **Security:** Pod Security Standards + NetworkPolicy
- **Data:** External managed services (e.g., Cloud SQL) — optional

```mermaid
graph TD
  A[User] --> B[Cloud Load Balancer]
  B --> C[Ingress]
  C --> D[Service]
  D --> E[Pod/Deployment]
  E --> F[Secret Manager]
  E --> G[Cloud Logging/Monitoring]
  H[Artifact Registry] --> E
  I[CI/CD] --> H
  I -->|kubectl apply| C
```
