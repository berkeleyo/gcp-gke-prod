# SECURITY

- **No secrets in git.** Use Secret Manager and CI/CD secret stores.
- **Workload Identity** for GCP API access (no long‑lived keys).
- **Least privilege IAM** for CI and runtime service accounts.
- **Pod Security Standards**: baseline/restricted; avoid privileged Pods.
- **NetworkPolicy**: default deny, explicit egress allow‑list.
- **Image supply chain**: build → scan → sign (consider Cosign), enforce via admission policy.
- **Audit**: enable Audit Logs; review regularly.
- **Dependencies**: update frequently; pin base images.
- **Access**: use IAP/VPN for admin endpoints; MFA enforced via IdP.
