output "fwd" {
  value = aws_route53_resolver_rule.fwd
}

output "fwd_association" {
  value = aws_route53_resolver_rule_association.fwd_association
}

output "aws_ram_resource_share" {
  value = aws_ram_resource_share.sender_share
}

output "aws_ram_resource_association" {
  value = aws_ram_resource_association.default
}

output "aws_ram_principal_association" {
  value = aws_ram_principal_association.sender_invite
}