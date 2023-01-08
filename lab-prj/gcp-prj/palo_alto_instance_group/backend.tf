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
    prefix = "prd/org_setup"
    bucket =  var.platform_bucket
  }
}

data "terraform_remote_state" "hub_network" {
  backend = "gcs"
  config = {
    prefix = "${var.environment}/hub_network"
    bucket =  var.platform_bucket
  }
}