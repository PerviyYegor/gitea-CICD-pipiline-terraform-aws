locals {
  gh_repo_url = "https://github.com/${var.gh_owner_name}/${var.gh_repo_name}.git"
}
variable "gh_owner_name" {
  type        = string
  default = "PerviyYegor"
}

variable "gh_repo_name" {
  type        = string
  default = "gitea"
}

variable "gr_branch" {
  type        = string
   default = "main"
}

variable "gh_token" {
  type        = string
  //you can insert you token here or use $ export TF_VAR_gh_token="<token>"
  #default = "****"
}

variable "gitea-environment" {
  type        = string
}

variable "gitea-application" {
  type        = string
}