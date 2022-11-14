# locals {
#   aws_accounts = [
#     { "aws_account_id": "728459525782", "alias" : "rbh-network-nonprod", "role_arn": "arn:aws:iam::728459525782:role/RBHAdminRole"},
#     { "aws_account_id": "642661817018","alias" : "rbh-dataplatform-nonprod","role_arn": "arn:aws:iam::642661817018:role/RBHAdminRole"},
#     ]
# }

module "dns-route53-resolver" {
  source                   = "./module-lab/dns-resolver"
  for_each                 = { for domain_name in var.domain_name_object : domain_name.job => domain_name }
  job                      = each.key
  dns_name                 = each.value.dns_name
  endpoint_type            = each.value.endpoint_type
  rule_type                = each.value.rule_type
  resolver_endpoint_id     = each.value.resolver_endpoint_id
  target_gcp_ip_address    = each.value.target_gcp_ip_address
  associated_vpc_id        = each.value.associated_vpc_id
  ram_resource_association = each.value.ram_resource_association
  share_associated_vpc_id  = each.value.share_associated_vpc_id
  # zone_name             = var.zone_name
  aws_accounts = var.aws_accounts
  environment = var.environment
  common_tags = var.common_tags
  providers = {
    aws.src = aws.rbh-network-nonprod
    aws.dst = aws.rbh-dataplatform-nonprod
  }
  # for_each = var.aws_accounts
  # providers = {
  #   aws.src = "aws.${each.value.aws_src}"
  #   aws.dst = "aws.${each.value.alias}"
  # }

}
# module "foo" {
#   source = "./foo"
#   for_each = local.aws_accounts
#   providers = {
#     aws = "aws.${each.value.aws_account_id}"
#   }
#   foo = each.value.foo_value
# }

# if change aws provider name  you can create new module.