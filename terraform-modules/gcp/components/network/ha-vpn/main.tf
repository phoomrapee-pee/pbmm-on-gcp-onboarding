module "validate_naming_conventions" {
  source      = "git::https://gitlab.com/scbtechx/pv-infra/fundamental-services/terraform-modules/components/utils/naming_convention.git?ref=main"
  environment = var.environment
  prefix      = var.prefix
  tenant_name = var.tenant_name

  resource_type = "google_compute_ha_vpn_gateway"
}

locals {
  environment_abbr = module.validate_naming_conventions.environment_abbr
  //  prefix             = var.prefix
  location_abbr      = module.validate_naming_conventions.location_abbr
  resource_type_abbr = module.validate_naming_conventions.resource_type_abbr
  suffix             = module.validate_naming_conventions.suffix
  other_key          = var.other_suffix != "" ? "-${var.other_suffix}" : ""
  env_key            = var.environment != "" ? "-${local.environment_abbr}" : ""
  //  tenant_name        = var.tenant_name
}

resource "random_password" "shared_secret" {
  length  = 16
  special = false
}
/*
  A
*/
resource "google_compute_ha_vpn_gateway" "ha_gateway_a" {
  project = var.project_a
  region  = var.region
  name    = "gtw-${var.company}-${var.project}-${var.service_name}${local.env_key}${local.other_key}"
  network = var.network_a
}
resource "google_compute_router" "router_a" {
  project = var.project_a
  region  = var.region
  name    = "rtr-${var.company}-${var.project}-${var.service_name}${local.env_key}${local.other_key}"
  network = var.network_a
  bgp {
    asn = var.asn_1
  }
}
resource "google_compute_vpn_tunnel" "proj_a_tunnel_a" {
  project               = var.project_a
  name                  = "tnl1-${var.company}-${var.project}-${var.service_name}${local.env_key}${local.other_key}"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha_gateway_a.id
  # peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha_gateway_b.id
  peer_gcp_gateway = var.ha_gateway_id
  shared_secret         = random_password.shared_secret.result
  router                = google_compute_router.router_a.id
  vpn_gateway_interface = 0
}
resource "google_compute_vpn_tunnel" "proj_a_tunnel_b" {
  project               = var.project_a
  name                  = "tnl2-${var.company}-${var.project}-${var.service_name}${local.env_key}${local.other_key}"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha_gateway_a.id
  # peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha_gateway_b.id
  peer_gcp_gateway = var.ha_gateway_id
  shared_secret         = random_password.shared_secret.result
  router                = google_compute_router.router_a.id
  vpn_gateway_interface = 1
}
resource "google_compute_router_interface" "router_a_tnl_a" {
  project    = var.project_a
  # name       = "router-a-interface-a"
  name       = "rtrinf1-${var.company}-${var.project}${local.other_key}"
  router     = google_compute_router.router_a.name
  region     = var.region
  ip_range   = "${var.router_b_peer_a}/30"
  vpn_tunnel = google_compute_vpn_tunnel.proj_a_tunnel_a.name
}
resource "google_compute_router_interface" "router_a_interface_b" {
  project    = var.project_a
  # name       = "router-a-interface-b"
  name       = "rtrinf2-${var.company}-${var.project}${local.other_key}"
  router     = google_compute_router.router_a.name
  region     = var.region
  ip_range   = "${var.router_b_peer_b}/30"
  vpn_tunnel = google_compute_vpn_tunnel.proj_a_tunnel_b.name
}
resource "google_compute_router_peer" "router_a_peer_a" {
  project = var.project_a
  #name            = "router-a-peer-a"
  name                      = "rtrpr1-${var.company}-${var.project}-hub-${var.service_name}${local.env_key}"
  router                    = google_compute_router.router_a.name
  region                    = var.region
  peer_ip_address           = var.router_a_peer_a
  peer_asn                  = var.asn_2
  advertised_route_priority = var.advertised_route_priority
  interface                 = google_compute_router_interface.router_a_tnl_a.name

  advertise_mode    = "CUSTOM"
  advertised_groups = ["ALL_SUBNETS"]
  dynamic "advertised_ip_ranges" {
    #    for_each = var.create_advertised_ip_ranges == true ? [1] : []
    for_each = var.advertised_ip_ranges_a
    content {
      range       = advertised_ip_ranges.value
      description = ""
    }
  }
  # bfd {
  #   min_receive_interval        = var.min_receive_interval
  #   min_transmit_interval       = var.min_transmit_interval
  #   multiplier                  = var.multiplier
  #   session_initialization_mode = var.session_initialization_mode
  # }

}
resource "google_compute_router_peer" "router_a_peer_b" {
  project                   = var.project_a
  # name                      = "${var.company}-${var.project}-${var.service_name}${local.env_key}-rtr-a-peer-b"
  name                      = "rtrpr2-${var.company}-${var.project}-hub-${var.service_name}${local.env_key}"
  router                    = google_compute_router.router_a.name
  region                    = var.region
  peer_ip_address           = var.router_a_peer_b
  peer_asn                  = var.asn_2
  advertised_route_priority = var.advertised_route_priority
  interface                 = google_compute_router_interface.router_a_interface_b.name

  advertise_mode    = "CUSTOM"
  advertised_groups = ["ALL_SUBNETS"]
  dynamic "advertised_ip_ranges" {
    #    for_each = var.create_advertised_ip_ranges == true ? [1] : []
    for_each = var.advertised_ip_ranges_a
    content {
      range       = advertised_ip_ranges.value
      description = ""
    }
  }
  # bfd {
  #   min_receive_interval        = var.min_receive_interval
  #   min_transmit_interval       = var.min_transmit_interval
  #   multiplier                  = var.multiplier
  #   session_initialization_mode = var.session_initialization_mode
  # }
}

/*
  B
*/
# resource "google_compute_ha_vpn_gateway" "ha_gateway_b" {
#   project = var.project_b
#   region  = var.region
#   name    = "${var.company}-${var.project}-${var.service_name}${local.env_key}-gtw-2"
#   network = var.network_b
# }
# resource "google_compute_router" "router_b" {
#   project = var.project_b
#   region  = var.region
#   #name    = "${var.prefix}-${var.tenant_name}-${local.envionment_abbr}-rtr-2"
#   name    = "${var.company}-${var.project}-${var.service_name}${local.env_key}-rtr-2"
#   network = var.network_b
#   bgp {
#     asn = var.asn_2
#   }
# }
resource "google_compute_vpn_tunnel" "proj_b_tunnel_a" {
  project               = var.project_b
  name                  = "tnl1-${var.company}-${var.project}-${var.service_name}${local.env_key}"
  region                = var.region
  # vpn_gateway           = google_compute_ha_vpn_gateway.ha_gateway_b.id
  vpn_gateway = var.ha_gateway_name
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha_gateway_a.id
  shared_secret         = random_password.shared_secret.result
  # router                = google_compute_router.router_b.id
  router = var.cloud_router_id
  vpn_gateway_interface = 0
}
resource "google_compute_vpn_tunnel" "proj_b_tunnel_b" {
  project               = var.project_b
  name                  = "tnl2-${var.company}-${var.project}-${var.service_name}${local.env_key}"
  region                = var.region
  # vpn_gateway           = google_compute_ha_vpn_gateway.ha_gateway_b.id
  vpn_gateway = var.ha_gateway_name
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha_gateway_a.id
  shared_secret         = random_password.shared_secret.result
  # router                = google_compute_router.router_b.id
  router = var.cloud_router_id
  vpn_gateway_interface = 1
}
resource "google_compute_router_interface" "router_b_interface_a" {
  project    = var.project_b
  # name       = "router-b-interface-a"
  name       = "rtrinf1-${var.company}-hub-${var.project}"
  # router     = google_compute_router.router_b.name
  router = var.cloud_router_name
  region     = var.region
  ip_range   = "${var.router_a_peer_a}/30"
  vpn_tunnel = google_compute_vpn_tunnel.proj_b_tunnel_a.name
}
resource "google_compute_router_interface" "router_b_interface_b" {
  project    = var.project_b
  # name       = "router-b-interface-b"
  name       = "rtrinf2-${var.company}-hub-${var.project}"
  # router     = google_compute_router.router_b.name
  router = var.cloud_router_name
  region     = var.region
  ip_range   = "${var.router_a_peer_b}/30"
  vpn_tunnel = google_compute_vpn_tunnel.proj_b_tunnel_b.name
}
resource "google_compute_router_peer" "router_b_peer_a" {
  project = var.project_b
  #name            = "router-b-peer-a"
  # name                      = "${var.company}-${var.project}-${var.service_name}${local.env_key}-rtr-b-peer-a"
  name              = "rtrpr1-${var.company}-hub-${var.project}-${var.service_name}${local.env_key}"
  # router                    = google_compute_router.router_b.name
  router = var.cloud_router_name
  region                    = var.region
  peer_ip_address           = var.router_b_peer_a
  peer_asn                  = var.asn_1
  advertised_route_priority = var.advertised_route_priority
  interface                 = google_compute_router_interface.router_b_interface_a.name

  advertise_mode    = "CUSTOM"
  advertised_groups = ["ALL_SUBNETS"]
  dynamic "advertised_ip_ranges" {
    #    for_each = var.create_advertised_ip_ranges == true ? [1] : []
    for_each = var.advertised_ip_ranges_b
    content {
      range       = advertised_ip_ranges.value
      description = ""
    }
  }
  # bfd {
  #   min_receive_interval        = var.min_receive_interval
  #   min_transmit_interval       = var.min_transmit_interval
  #   multiplier                  = var.multiplier
  #   session_initialization_mode = var.session_initialization_mode
  # }
}
resource "google_compute_router_peer" "router_b_peer_b" {
  project = var.project_b
  #name            = "router-b-peer-b"
  # name                      = "${var.company}-${var.project}-${var.service_name}${local.env_key}-rtr-b-peer-b"
  name              = "rtrpr2-${var.company}-hub-${var.project}-${var.service_name}${local.env_key}"
  # router                    = google_compute_router.router_b.name
  router = var.cloud_router_name
  region                    = var.region
  peer_ip_address           = var.router_b_peer_b
  peer_asn                  = var.asn_1
  advertised_route_priority = var.advertised_route_priority
  interface                 = google_compute_router_interface.router_b_interface_b.name

  advertise_mode    = "CUSTOM"
  advertised_groups = ["ALL_SUBNETS"]
  dynamic "advertised_ip_ranges" {
    #    for_each = var.create_advertised_ip_ranges == true ? [1] : []
    for_each = var.advertised_ip_ranges_b
    content {
      range       = advertised_ip_ranges.value
      description = ""
    }
  }
  # bfd {
  #   min_receive_interval        = var.min_receive_interval
  #   min_transmit_interval       = var.min_transmit_interval
  #   multiplier                  = var.multiplier
  #   session_initialization_mode = var.session_initialization_mode
  # }
}
