#------------------------------------------------------------------------------
# To leverage more than one namespace, define a vault provider per namespace
#
#   admin
#    ├── education
#    │   └── training
#    │       └── boundary
#    └── test
#------------------------------------------------------------------------------
#data "terraform_remote_state" "hcp_vault" {
#  backend = "remote"
#  config = {
#   organization = var.tfc_org
#    workspaces = {
#      name = var.tfc_workspace
#    }
#  }
#}

provider "vault" {
  alias     = "admin"
  namespace = "admin"
}

#--------------------------------------
# Create 'admin/education' namespace
#--------------------------------------
resource "vault_namespace" "education" {
  provider = vault.admin
  path     = "education"
}

provider "vault" {
  alias     = "education"
  namespace = "admin/education"
}

#---------------------------------------------------
# Create 'admin/education/training' namespace
#---------------------------------------------------
resource "vault_namespace" "training" {
  depends_on = [vault_namespace.education]
  provider   = vault.education
  path       = "training"
}

provider "vault" {
  alias     = "training"
  namespace = "admin/education/training"
}

#-----------------------------------------------------------
# Create 'admin/education/training/boundary' namespace
#-----------------------------------------------------------
resource "vault_namespace" "boundary" {
  depends_on = [vault_namespace.training]
  provider   = vault.training
  path       = "boundary"
}

provider "vault" {
  alias     = "boundary"
  namespace = "admin/education/training/boundary"
}

#--------------------------------------
# Create 'admin/test' namespace
#--------------------------------------
resource "vault_namespace" "test" {
  provider = vault.admin
  path     = "test"
}

provider "vault" {
  alias     = "test"
  namespace = "admin/test"
}
