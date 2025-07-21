✅ Step-by-step: Enable TLS on ArgoCD

1. Install cert-manager

kubectl create namespace cert-manager

helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set installCRDs=true

2. Then follow steps found on this link -> https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/#create-a-test-clusterissuer-and-a-certificate


