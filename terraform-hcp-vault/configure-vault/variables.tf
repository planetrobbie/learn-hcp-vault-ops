variable "tfc_org" {
  description = "TFC Org name of the HCP Vault Deployment"
  type        = string
  default     = "yet"
}

variable "tfc_workspace" {
  description = "Workspace name of the HCP Vault deployment"
  type        = string
  default     = "hcp-vault-provision"
}
