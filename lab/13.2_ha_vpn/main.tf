locals {
  workload_network_project_id = {
    np  = data.terraform_remote_state.workload_org_setup.outputs.project_network_np_id
    prd = data.terraform_remote_state.workload_org_setup.outputs.project_network_prd_id
  }

  workload_network_self_link = {
    np  = data.terraform_remote_state.workload_network.outputs.workload_spoke_network.id
    prd = data.terraform_remote_state.workload_network.outputs.workload_spoke_network.id
  }

  platform_network_project_id = {
    np  = data.terraform_remote_state.platform_org_setup.outputs.project_network_np_id
    prd = data.terraform_remote_state.platform_org_setup.outputs.project_network_prd_id
  }
  trusted_hub_network_self_link = {
    np  = data.terraform_remote_state.hub_network.outputs.trusted_hub_network.id
    prd = data.terraform_remote_state.hub_network.outputs.trusted_hub_network.id
  }
  trusted_hub_cloud_router = {
    np  = data.terraform_remote_state.hub_network.outputs.cloud_router
    prd = data.terraform_remote_state.hub_network.outputs.cloud_router
  }
}

module "ha-vpn" {
  source = "../module-lab/ha-vpn2"
  ##source       = "git::https://gitlab.com/scbtechx/pv-infra/fundamental-services/terraform-modules/gcp/components/network/ha-vpn.git?ref=tags/1.0.0"
  project_a    = local.workload_network_project_id[var.environment]
  network_a    = local.workload_network_self_link[var.environment]
  project_b    = local.platform_network_project_id[var.environment]
  network_b    = local.trusted_hub_network_self_link[var.environment]
  service_name = "vpn"
  region       = var.region
  environment  = var.environment
  prefix       = var.prefix
  tenant_name  = var.tenant_name
  project      = var.project
  other_suffix = "to-hub"
  cloud_router_id = local.trusted_hub_cloud_router[var.environment].router_hub.id
  cloud_router_name = local.trusted_hub_cloud_router[var.environment].router_hub.name
  ha_gateway_id = local.trusted_hub_cloud_router[var.environment].ha_gateway_hub.id
  ha_gateway_name = local.trusted_hub_cloud_router[var.environment].ha_gateway_hub.name



  router_a_peer_a = var.router_a_peer_a
  router_a_peer_b = var.router_a_peer_b
  router_b_peer_b = var.router_b_peer_b
  router_b_peer_a = var.router_b_peer_a

  // ASN value
  asn_1 = var.asn_1
  asn_2 = var.asn_2

  advertised_route_priority = var.advertised_route_priority

  create_advertised_ip_ranges = true
  // advertised_ip_ranges_a: spoke network to hub network
  advertised_ip_ranges_a = var.advertised_ip_ranges_a
  // advertised_ip_ranges_b: hub network to spoke network
  advertised_ip_ranges_b = var.advertised_ip_ranges_b

}
