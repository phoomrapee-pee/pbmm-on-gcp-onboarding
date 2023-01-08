output "region" {
  value = var.region
}
output "project_a" {
  value = var.project_a
}
output "project_b" {
  value = var.project_b
}
output "network_a" {
  value = module.network_a.network.name
}
output "network_b" {
  value = module.network_b.network.name
}
output "tunnel_1_name" {
  value = module.ha-vpn.tunnel_1_name
}
output "tunnel_2_name" {
  value = module.ha-vpn.tunnel_2_name
}
output "tunnel_3_name" {
  value = module.ha-vpn.tunnel_3_name
}
output "tunnel_4_name" {
  value = module.ha-vpn.tunnel_4_name
}
