/*
  DEFAULT
*/
variable "project_a" {
  description = "Project A used for the vpn connection"
}

variable "project_b" {
  description = "Project B used for the vpn connection"
}

variable "env" {
  type        = string
  description = "Env variable (1 char) used for subnets naming"
}

variable "prefix" {
  type        = string
  description = "Used inside subnets objects for naming"
}

variable "tenant_name" {
  type        = string
  description = "Used for naming"
}

/*
  VPN
*/
variable "network_a" {
  default     = null
  description = "Network A used for the vpn connection"
}
variable "network_b" {
  default     = null
  description = "Network B used for the vpn connection"
}
variable "region" {
  default     = "us-central1"
  description = "Region where tunnels will be created"
}
# project_a-router_a-bgp_ip
variable "router_a_peer_a" {
  type        = string
  description = "Cloud Router BGP IP and BGP peer IP must be in the same /30 subnet. Make sure that they aren't the network or broadcast address of the subnet."
}
# project_b-router_b-bgp-ip
variable "router_b_peer_a" {
  type        = string
  description = "Cloud Router BGP IP and BGP peer IP must be in the same /30 subnet. Make sure that they aren't the network or broadcast address of the subnet."
}
# project_a-router_b-bgp-ip
variable "router_a_peer_b" {
  type        = string
  description = "Cloud Router BGP IP and BGP peer IP must be in the same /30 subnet. Make sure that they aren't the network or broadcast address of the subnet."
}
# project_a-router_b-bgp_ip
variable "router_b_peer_b" {
  type        = string
  description = "Cloud Router BGP IP and BGP peer IP must be in the same /30 subnet. Make sure that they aren't the network or broadcast address of the subnet."
}