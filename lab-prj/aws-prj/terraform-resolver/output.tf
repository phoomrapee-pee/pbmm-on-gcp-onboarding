output "dns-route53-resolver-rule" {
  description = "dns-route53-resolver in account rbh hub "
  value       = module.dns-route53-resolver
}

# output "dns-route53-resolver-rule-prod" {
#   description = "dns-route53-resolver in account rbh hub-prod rule "
#   value       = module.dns-route53-resolver-prod
# }