# 🚀 Nginx Ingress Controller

This guide helps you deploy Nginx on a Kubernetes cluster using Helm, with customizable settings.

Ingress is the Kubernetes-native way to expose services by hostname.

---

## ✅ 1. Install Ingress Controller (e.g., NGINX)

LINK USED -> https://kubernetes.github.io/ingress-nginx/deploy/#azure

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.13.0/deploy/static/provider/cloud/deploy.yaml
```

## 📦 2. Update Helm Repositories

```bash
helm repo update
```

## ✅ 3. Create an Ingress for ArgoCD

```yaml
# argocd-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: argocd-ingress
  namespace: argocd
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
    #cert-manager.io/cluster-issuer: letsencrypt-prod
spec:
  ingressClassName: nginx
  rules:
  - host: argocd.stefan-albu.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: argocd-server
            port:
              number: 80
#   tls:
#   - hosts:
#     - argocd.stefan-albu.com
#     - www.argocd.stefan-albu.com
#     secretName: argocd-tls

```