# HashiCorp Vault Deployment

This document provides details about the HashiCorp Vault deployment in the Kubernetes cluster.

## Deployment Details

- **Namespace**: `vault`
- **Deployment Directory**: `/root/vault-deployment`
- **Vault Version**: 1.20.0
- **External Access**: NodePort service on port 30820

## Access Information

- **Vault URL**: http://192.168.56.11:30820
- **Root Token**: Located in `/root/vault-deployment/vault-init.json`
- **Unseal Key**: Located in `/root/vault-deployment/vault-init.json`

## Important Files

- **Vault Config**: `/root/vault-deployment/vault-config.yaml`
- **Vault Deployment**: `/root/vault-deployment/vault-deployment-fixed.yaml`
- **Vault Service**: `/root/vault-deployment/vault-service.yaml`
- **Initialization Data**: `/root/vault-deployment/vault-init.json`
- **Test Script**: `/root/vault-deployment/test-vault.sh`

## Storage

Vault is using a hostPath volume at `/opt/vault-data` on the node where the pod is running.

## Accessing Vault

You can access Vault using the following methods:

1. **Using the Vault CLI**:
   ```bash
   export VAULT_ADDR=http://192.168.56.11:30820
   export VAULT_TOKEN=$(cat /root/vault-deployment/vault-init.json | jq -r '.root_token')
   vault status
   ```

2. **Using the Web UI**:
   Open a browser and navigate to http://192.168.56.11:30820/ui
   Use the root token from the initialization file to log in.

3. **Using the API**:
   ```bash
   curl -H "X-Vault-Token: $(cat /root/vault-deployment/vault-init.json | jq -r '.root_token')" \
     http://192.168.56.11:30820/v1/sys/health
   ```

## Security Considerations

- The current deployment uses HTTP instead of HTTPS. For production use, configure TLS.
- The root token should be securely stored and only used for initial setup.
- Consider setting up authentication methods like Kubernetes auth, LDAP, etc.
- Implement proper policies to restrict access to secrets.

## Backup and Recovery

- The unseal key and root token in `/root/vault-deployment/vault-init.json` are critical for recovery.
- Make sure to back up this file securely.
- The Vault data is stored in `/opt/vault-data` on the node. Consider backing up this directory.

## Next Steps

1. Enable secrets engines (e.g., KV, AWS, Database)
2. Configure authentication methods
3. Set up policies for access control
4. Configure audit logging
5. Set up auto-unseal for production use
