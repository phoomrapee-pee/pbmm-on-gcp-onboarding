terraform {
  required_version = "> 0.13.0"
  backend "gcs" {
    prefix = ""
    bucket = ""
  }
}

data "terraform_remote_state" "platform_org_setup" {
  backend = "gcs"
  config = {
    prefix                      = "prd/org_setup"
    bucket                      = var.platform_bucket
    impersonate_service_account = var.terraform_service_account
  }
}

data "terraform_remote_state" "platform_hub_network" {
  backend = "gcs"
  config = {
    prefix                      = var.environment == "prd" ? "prd/hub_network" : "np/hub_network"
    bucket                      = var.platform_bucket
    impersonate_service_account = var.terraform_service_account
  }
}

data "terraform_remote_state" "platform_dns" {
  backend = "gcs"
  config = {
    prefix                      = var.environment == "prd" ? "prd/dns" : "np/dns"
    bucket                      = var.platform_bucket
    impersonate_service_account = var.terraform_service_account
  }
}

data "terraform_remote_state" "palo_alto_instance_group" {
  backend = "gcs"
  config = {
    prefix                      = var.environment == "prd" ? "prd/palo_alto_instance_group" : "np/palo_alto_instance_group"
    bucket                      = var.platform_bucket
    impersonate_service_account = var.terraform_service_account
  }
}