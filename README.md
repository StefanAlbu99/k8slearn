## 📖 Project Overview

This repository demonstrates modern infrastructure deployment on Azure using best practices with OpenTofu and GitOps with ArgoCD.  
The goal is to provide a quick and reproducible way to set up:

- A complete Azure infrastructure, including AKS (Azure Kubernetes Service).  
- A GitOps-driven Kubernetes environment, where ArgoCD manages operators, apps, and configurations using the App-of-Apps pattern.

## 🎯 Objectives

- Show how to combine Infrastructure as Code (IaC) (OpenTofu) with GitOps (ArgoCD).  
- Deliver a ready-to-use baseline for deploying cloud-native workloads on AKS.  
- Automate both the infra layer (Azure resources) and the app layer (Kubernetes manifests).  
- Provide a structure that can easily scale across environments (dev/test/prod).

---

### 📝 Step-by-Step Guide

1. **Bootstrap Terraform backend**  
   - Create the **storage account** and **Service Principal (SP)** for storing your `.tfstate` file.  
   - Script: [`bootstrap-tfstate-setup.sh`](./bootstrap-tfstate-setup)

2. **Setup GitHub Actions pipeline**  
   - Configure the `.github/workflows` file to run OpenTofu and apply the infrastructure.  

3. **Configure OpenTofu files**  
   - Create the modules and main OpenTofu files using `azurerm` provider.  
   - Set up resources such as AKS, networking, and storage according to your project needs.  

> ⚡ This is the current workflow. More steps (like ArgoCD setup, app deployment, and additional security for state files) will be added as the project evolves.
