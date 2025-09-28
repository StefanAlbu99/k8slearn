## 🚀 Bootstrap Terraform Backend (Azure)

Before running the OpenTofu pipeline in GitHub Actions, we need to set up the **remote backend** in Azure.

### 🐣 The "Chicken or the Egg" Problem

The OpenTofu `.tfstate` file needs a **storage account** to exist so it can store the state remotely.  
But to create the storage account, we need a **Service Principal (SP)** with proper permissions.  
This creates a dependency loop: we need the SP to create the storage account, but we also need the storage account for the remote backend.

### 🛠 Solution: Bootstrap Script

To solve this, we run a **bootstrap script** (`bootstrap-tfstate-setup.sh`) that:

- 🏗 Creates a **resource group** and **storage account** in Azure.
- 📦 Creates a **blob container** inside the storage account.
- 🔑 Creates a **Service Principal** with **Contributor role**, configured for **OIDC federation**, so OpenTofu in GitHub Actions can authenticate without passwords.
- 📝 Outputs the SP details and the Terraform backend configuration.

> This could of course be done manually, via PowerShell, Terraform, or any scripting language. Using this script is just the approach we’ve chosen for convenience and reproducibility.

### ✅ Why This Setup is Important

- 🌐 **Remote state storage:** keeps the `.tfstate` file in Azure instead of locally.  
- 👥 **Collaboration:** multiple people can safely work on the same project.  
- ⛔ **State locking:** prevents conflicts if multiple `apply` commands are run simultaneously.  
- 🔒 **Security & portability:** work from any machine using OIDC authentication, without storing local secrets.

---

### 🛡 Extra Security Considerations (Future Work)

While this project sets up the remote backend, additional measures can further protect the `.tfstate` file:  

- **Soft delete for the storage account:** ensures that if the storage account or blobs are accidentally deleted, the data can be recovered.  
- **Regular backups of the `.tfstate` file:** a scheduled script could automatically copy the state file daily to another location for redundancy.  

> ⚠️ Note: These measures are **not implemented in this project yet**, but can be added in the future to improve security and resilience if time allows.


---

### 💡 Note

There are many ways to store your `.tfstate` file. If you plan to do it differently, check the [OpenTofu Remote State Management documentation](https://opentofu.org/docs/language/settings/backends/configuration/) to follow any of the recommended setups.


