output "tunnel_1_name" {
  value = google_compute_vpn_tunnel.proj_a_tunnel_a.name
}
output "tunnel_2_name" {
  value = google_compute_vpn_tunnel.proj_a_tunnel_b.name
}
output "tunnel_3_name" {
  value = google_compute_vpn_tunnel.proj_b_tunnel_a.name
}
output "tunnel_4_name" {
  value = google_compute_vpn_tunnel.proj_b_tunnel_b.name
}
