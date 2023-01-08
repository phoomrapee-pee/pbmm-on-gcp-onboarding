module "network_a" {
  source = "../../../../vpc"
  project = {
    project_id = var.project_a
  }

  env         = var.env
  prefix      = var.prefix
  tenant_name = var.tenant_name
}
module "network_b" {
  source = "../../../../vpc"
  project = {
    project_id = var.project_b
  }

  env         = var.env
  prefix      = var.prefix
  tenant_name = var.tenant_name
}
module "ha-vpn" {
  source = "../../../../ha-vpn"

  project_a = var.project_a
  network_a = module.network_a.network.id

  project_b = var.project_b
  network_b = module.network_b.network.id

  env         = var.env
  prefix      = var.prefix
  tenant_name = var.tenant_name

  # project_a-router_a-bgp_ip
  router_a_peer_a = var.router_a_peer_a
  # project_b-router_b-bgp-ip
  router_b_peer_a = var.router_b_peer_a

  # project_b-router_b-bgp-ip
  router_a_peer_b = var.router_a_peer_b
  # project_a-router_b-bgp_ip
  router_b_peer_b = var.router_b_peer_b
}
