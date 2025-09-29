locals {
  rg_name      = "${var.org}-${var.env}-${var.location_short}-rg"
  cluster_name = "${var.org}-${var.env}-${var.location_short}-aks"
  node_rg_name = "${local.rg_name}-nodes" # AKS automatically creates a node RG
  dns_prefix   = "${var.org}-${var.env}-${var.location_short}-dns"
}