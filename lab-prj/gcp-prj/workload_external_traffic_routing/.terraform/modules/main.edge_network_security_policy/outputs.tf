output "security_policies" {
  description = "Map of cloud armor policies"
  value       = google_compute_security_policy.cloudarmor-security-policy
}