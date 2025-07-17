#!/bin/bash

# Set Vault address
export VAULT_ADDR=http://192.168.56.11:30820

# Set root token
export VAULT_TOKEN=$(cat /root/vault-deployment/vault-init.json | jq -r '.root_token')

# Test Vault status
echo "Testing Vault status..."
curl -s $VAULT_ADDR/v1/sys/health | jq

# Test Vault authentication
echo -e "\nTesting Vault authentication..."
curl -s -H "X-Vault-Token: $VAULT_TOKEN" $VAULT_ADDR/v1/sys/mounts | jq
