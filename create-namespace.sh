#!/bin/bash
echo "Waiting for vault namespace to be fully deleted..."
while kubectl get namespace vault &>/dev/null; do
  echo "Namespace still exists, waiting 5 seconds..."
  sleep 5
done
echo "Creating vault namespace..."
kubectl create namespace vault
echo "Vault namespace created successfully."
