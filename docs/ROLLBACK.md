# ROLLBACK

**Trigger:** SLO breach, critical errors, or material user impact.

## Options

1. **Kubernetes rollback** (preferred)
   ```bash
   kubectl rollout undo deploy/<name> -n <ns>
   ```

2. **Previous release re‑deploy**
   - Reapply prior `k8s/` manifests (tagged in git)
   - Verify health, scale back traffic

3. **Traffic shift / disable feature**
   - Toggle flags or route traffic to stable service

## Data considerations
- If schema changes occurred, ensure backward compatibility or apply down‑migrations.
- Validate backups before rollback if stateful components exist.

## Comms
- Record timeline, impact, actions, and result.
