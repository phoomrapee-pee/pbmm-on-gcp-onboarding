# Google HA-VPN

HA-VPN

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Example

Basic usage of this module is as follows:

```hcl
module "project_1" {
  source          = "../../../modules//resource/project"
  name            = "${var.prefix}-a"
  folder_id       = module.folder_hub_network.folder.id
  billing_account = var.billing_account

  project_type = "HOST"

  services = ["cloudasset.googleapis.com"]
}

module "network_1" {
  source  = "../../../modules//network/vpc"
  project = module.project_1.project

  env         = var.env
  prefix      = var.prefix
  tenant_name = var.tenant_name
}

module "project_2" {
  source          = "../../../modules//resource/project"
  name            = "${var.prefix}-b"
  folder_id       = module.folder_hub_network.folder.id
  billing_account = var.billing_account

  project_type = "HOST"

  services = ["cloudasset.googleapis.com"]
}

module "network_2" {
  source  = "../../../modules//network/vpc/"
  project = module.project_2.project

  env         = var.env
  prefix      = var.prefix
  tenant_name = var.tenant_name
}

module "ha-vpn" {
  source = "../../modules/network/ha-vpn"

  project_a = local.project_jenkins
  network_a = module.vpc_jenkins.network.id

  project_b = local.project_cloudbuild
  network_b = module.vpc_cloud-build.network.id

  region = var.region

  env         = var.environment
  prefix      = var.prefix
  tenant_name = var.tenant_name

  # project_a-router_a-bgp_ip
  router_a_peer_a = "169.254.0.1"
  # project_b-router_b-bgp-ip
  router_b_peer_a = "169.254.0.2"

  # project_b-router_b-bgp-ip
  router_a_peer_b = "169.254.1.1"
  # project_a-router_b-bgp_ip
  router_b_peer_b = "169.254.1.2"

  asn_1 = 65001
  asn_2 = 65002

  create_advertised_ip_ranges = true
  advertised_ip_ranges_a = "172.16.0.32/28"
  advertised_ip_ranges_b = "192.168.0.0/16"
}

```
