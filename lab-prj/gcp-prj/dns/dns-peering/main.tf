# resource "google_compute_address" "ip_address" {
#   name = "my-address-test-terraform"
# }

# module "peering_spoke_to_hub" {
#   #source                            = "git::https://gitlab.com/scbtechx/pv-infra/fundamental-services/terraform-modules/components/network/peering.git?ref=tags/1.0.0"
#   source = "../modules-lab/peering"
#   #for_each                          = toset([""])
#   # hub_network                       = each.key
#   hub_network = "https://www.googleapis.com/compute/v1/projects/rbh-platform-network-np-h3t2/global/networks/vpc-rbh-platform-hub-trusted-np"
#   # spoke_network                     = module.spoke_vpc.id
#   spoke_network = 
# }

# locals {
#   hub_network_name = element(reverse(split("/", var.hub_network)), 0)
#   spoke_network_name  = element(reverse(split("/", var.spoke_network)), 0)

#   hub_network_name_array = split("-", local.hub_network_name)
#   hub_network_short_name = join("-",slice(local.hub_network_name_array, 3, length(local.hub_network_name_array)))
#   spoke_network_name_array = split("-", local.spoke_network_name)
#   spoke_network_short_name = join("-",slice(local.spoke_network_name_array, 3, length(local.spoke_network_name_array)))
  
#   hub_to_spoke_peering_name = "${local.hub_network_short_name}-to-${local.spoke_network_short_name}"
#   spoke_to_hub_peering_name = "${local.spoke_network_short_name}-to-${local.hub_network_short_name}"
  
  
# //   hub_network_peering      = "${var.prefix}-${local.hub_network_name}-${local.spoke_network_name}"
# //   hub_network_peering_name = length(local.hub_network_peering) < 63 ? local.hub_network_peering : "${substr(local.hub_network_peering, 0, min(58, length(local.hub_network_peering)))}-${random_string.network_peering_suffix.result}"
# //   spoke_network_peering       = "${var.prefix}-${local.spoke_network_name}-${local.hub_network_name}"
# //   spoke_network_peering_name  = length(local.spoke_network_peering) < 63 ? local.spoke_network_peering : "${substr(local.spoke_network_peering, 0, min(58, length(local.spoke_network_peering)))}-${random_string.network_peering_suffix.result}"
#  }

# resource "random_string" "network_peering_suffix" {
#   upper   = false
#   lower   = true
#   special = false
#   length  = 4
# }

# resource "google_compute_network_peering" "hub_to_spoke_peering" {
#   name                 = "hub_to_spoke_peering_name"
#   network              = "https://www.googleapis.com/compute/v1/projects/rbh-platform-network-np-h3t2/global/networks/vpc-rbh-platform-hub-trusted-np"
#   peer_network         = "https://www.googleapis.com/compute/v1/projects/scbtechx-sharedvpc-nonprod/global/networks/transit-nonprod"
#   export_custom_routes = true
#   import_custom_routes = true

#   export_subnet_routes_with_public_ip = true
#   import_subnet_routes_with_public_ip = true

# }

# resource "google_compute_network_peering" "spoke_to_hub_peering" {
#   name                 = "spoke_to_hub_peering_name"
#   network              = "https://www.googleapis.com/compute/v1/projects/scbtechx-sharedvpc-nonprod/global/networks/transit-nonprod"
#   peer_network         = "https://www.googleapis.com/compute/v1/projects/rbh-platform-network-np-h3t2/global/networks/vpc-rbh-platform-hub-trusted-np"
#   export_custom_routes = true
#   import_custom_routes = true

#   export_subnet_routes_with_public_ip = true
#   import_subnet_routes_with_public_ip = true

# }

# module "dns_peering_zone" {
#   source                = "git::https://gitlab.com/scbtechx/pv-infra/fundamental-services/terraform-modules/products/clouddns-peering-zone.git?ref=tags/1.0.0"
#   company               = "techx"
#   project_name          = "test"
#   environment           = "np"
#   project               = "scbtechx-sharedvpc-nonprod"
#   dns_peering_zone_list = var.dns_peering_zone_list
# }
# resource "google_dns_managed_zone" "peering-zone" {
#   name        = local.name
#   dns_name    = var.dns_name
#   description = var.description
#   project     = var.project
#   visibility  = var.visibility

resource "google_dns_managed_zone" "peering-zone" {
  name        = "test-peering-zone"
  dns_name    = "np.private.gcpppv2.tech."
  description = "Example private DNS peering zone by Terraform"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = "https://www.googleapis.com/compute/v1/projects/scbtechx-sharedvpc-nonprod/global/networks/transit-nonprod"
    }
  }
# network_url": "https://www.googleapis.com/compute/v1/projects/rbh-platform-network-prd-m4wd/global/networks/vpc-rbh-platform-hub-trusted-prd"
  peering_config {
    target_network {
      network_url = "https://www.googleapis.com/compute/v1/projects/rbh-platform-network-np-h3t2/global/networks/vpc-rbh-platform-hub-trusted-np"
      # network_url = "https://www.googleapis.com/compute/v1/projects/scbtechx-sharedvpc-nonprod/global/networks/default"
    }
  }

}
