variable "company" {
  description = "Company name"
  type        = string
  default     = "rbh"
}
variable "terraform_service_account" {
  description = "The service account to use for the organisation level terraform"
  type        = string
  default     = "org-terraform@prj-b-seed-2400.iam.gserviceaccount.com"
}
variable "prefix" {
  type        = string
  description = "Used inside subnets objects for naming"
  default     = ""
}
variable "tenant_name" {
  type        = string
  description = "Used for naming"
  default     = ""
}
# /*
#   VPN
# project_a-router_a-bgp_ip
variable "router_a_peer_a" {
  type        = string
  default     = "169.254.0.1"
  description = "Cloud Router BGP IP and BGP peer IP must be in the same /30 subnet. Make sure that they aren't the network or broadcast address of the subnet."
}
# project_b-router_b-bgp-ip
variable "router_b_peer_a" {
  type        = string
  default     = "169.254.0.2"
  description = "Cloud Router BGP IP and BGP peer IP must be in the same /30 subnet. Make sure that they aren't the network or broadcast address of the subnet."
}
# project_a-router_b-bgp-ip
variable "router_a_peer_b" {
  type        = string
  default     = "169.254.1.1"
  description = "Cloud Router BGP IP and BGP peer IP must be in the same /30 subnet. Make sure that they aren't the network or broadcast address of the subnet."
}
# project_a-router_b-bgp_ip
variable "router_b_peer_b" {
  type        = string
  default     = "169.254.1.2"
  description = "Cloud Router BGP IP and BGP peer IP must be in the same /30 subnet. Make sure that they aren't the network or broadcast address of the subnet."
}
variable "region" {
  default     = "ap-southeast-1"
  description = "Region where tunnels will be created"
}
variable "asn_1" {
  default     = 64514
  description = "Used for vpn peer"
}
variable "asn_2" {
  default     = 64515
  description = "Used for vpn peer"
}
variable "create_advertised_ip_ranges" {
  type    = bool
  default = false
}
variable "advertised_ip_ranges_a" {
  type    = list(string)
  default = []
}
variable "advertised_ip_ranges_b" {
  type    = list(string)
  default = []
}
variable "environment" {
  description = "Name of the environment"
  type        = string
  default     = ""
}
variable "workload_bucket" {
  type        = string
  description = "name of the workload bucket"
}
variable "platform_bucket" {
  type        = string
  description = "name of the platform bucket"
}
variable "project" {
  description = "Name of the project"
}
variable "advertised_route_priority" {
  default     = 1000
  description = "priority of routes advertised to this BGP peer"
}
# variable "min_receive_interval" {
#   default     = 1000
#   description = "The minimum interval, in milliseconds, between BFD control packets transmitted to the peer router"
# }
# variable "min_transmit_interval" {
#   default     = 1000
#   description = "The minimum interval, in milliseconds, between BFD control packets received from the peer router."
# }
# variable "multiplier" {
#   default     = 5
#   description = "The number of consecutive BFD packets"
# }
# variable "session_initialization_mode" {
#   type        = string
#   default     = "ACTIVE"
#   description = "The BFD session initialization mode for this BGP peer"
# }

# variable "cloud_router_id" {
#   # type        = string
#   description = "cloud_router name"
# }

# variable "cloud_router_name" {
#   # type        = string
#   description = "ha_gateway_name name"
# }
# variable "ha_gateway_id" {
#   # type        = string
#   description = "cloud_router name"
# }

# variable "ha_gateway_name" {
#   # type        = string
#   description = "ha_gateway_name name"
# }
variable "other_suffix" {
  type        = string
  description = "any other suffix to add to name of the resource"
  default     = ""
}