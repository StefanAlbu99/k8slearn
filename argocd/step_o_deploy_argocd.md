# 🚀 ArgoCD Deployment with Helm (Full Guide)

This guide helps you deploy ArgoCD on a Kubernetes cluster using Helm, with customizable settings.

---

## 📦 1. Add the Argo Helm Repo

```bash
helm repo add argo https://argoproj.github.io/argo-helm
```

## 📦 2. Update Helm Repositories

```bash
helm repo update
```

## 📄 3. Save Default Values to Customize

```bash
helm show values argo/argo-cd > argocd-default-values.yaml
```

## 📄 4. Edit whatever you want to change from the default argocd values file

```bash
touch ./my-argo-cd-values.yaml
```

## ✅ 5. Step-by-step: Minimal ArgoCD Helm Install
### You already added the repo, so now:

```bash
helm install argocd argo/argo-cd -n argocd -f my-argo-cd-values.yaml --create-namespace
```

## Output after running install command

helm install argocd argo/argo-cd -n argocd -f my-argo-cd-values.yaml --create-namespace
NAME: argocd
LAST DEPLOYED: Sat Jul 19 19:21:24 2025
NAMESPACE: argocd
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
In order to access the server UI you have the following options:

1. kubectl port-forward service/argocd-server -n argocd 8080:443

    and then open the browser on http://localhost:8080 and accept the certificate

2. enable ingress in the values file `server.ingress.enabled` and either
      - Add the annotation for ssl passthrough: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-1-ssl-passthrough
      - Set the `configs.params."server.insecure"` in the values file and terminate SSL at your ingress: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-2-multiple-ingress-objects-and-hosts


After reaching the UI the first time you can login with username: admin and the random password generated during the installation. You can find the password by running:

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

(You should delete the initial secret afterwards as suggested by the Getting Started Guide: https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli)