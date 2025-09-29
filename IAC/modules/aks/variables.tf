variable "org" {
  description = "Organization or project name prefix"
  type        = string
}

variable "env" {
  description = "Environment: dev, staging, prod"
  type        = string
}

variable "location_short" {
  description = "Azure region short code (e.g., eus, weu)"
  type        = string
}

variable "location" {
  description = "Full Azure region name"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in default node pool"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "VM size for nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}