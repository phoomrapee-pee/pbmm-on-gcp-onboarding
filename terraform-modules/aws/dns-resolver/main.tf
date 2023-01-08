locals {
  resource_type_abbr = "rslvr"
  env_key            = var.environment
  other_key          = var.other_suffix != "" ? "-${var.other_suffix}" : ""
  job_key            = var.job != "" ? "-${var.job}" : ""
  # name               = "${local.resource_type_abbr}-${var.company}-${var.endpoint_type}-${var.job}${local.job_key}${local.env_key}${local.other_key}"
  # │ Error: "name" cannot be greater than 64 characters
  name        = "${var.company}-${var.endpoint_type}${local.job_key}-${local.env_key}${local.other_key}"
  name_shared = "${var.company}-${var.endpoint_type}${local.job_key}-${local.env_key}${local.other_key}-shared"

  # aws_provider_src = {
  #   nonprod  = local.aws_provider_src
  #   prd      = aws.dst
  # }
  # aws_provider_src = aws.src-prd
  # aws_provider_src = var.environment == "np" ? aws.src : aws.src-prd
  # aws_provider_dst = var.environment == "np" ? aws.dst-prd : aws.dst
}
# project_names = gcp-workload-logging-es
resource "aws_route53_resolver_rule" "fwd" {
  provider = aws.src
  # provider = aws.src[var.environment]
  # provider = local.aws_provider_src
  count                = var.endpoint_type == "inbound" ? 0 : 1
  domain_name          = var.dns_name
  name                 = local.name
  rule_type            = var.rule_type
  resolver_endpoint_id = var.resolver_endpoint_id
  dynamic "target_ip" {
    for_each = toset(var.target_gcp_ip_address)
    content {
      ip = target_ip.value
    }
  }

  tags = merge(
    var.common_tags
    # {
    #   "Name" = var.zone_name
    # }
  )

}

resource "aws_route53_resolver_rule_association" "fwd_association" {
  provider         = aws.src
  for_each         = toset(var.associated_vpc_id)
  resolver_rule_id = aws_route53_resolver_rule.fwd[0].id
  vpc_id           = each.value
}


# ### for RAM---------------------------------
resource "aws_ram_resource_share" "sender_share" {
  count                     = var.share_resource ? 1 : 0
  provider                  = aws.src
  name                      = local.name_shared
  allow_external_principals = true

  tags = merge(
    # var.env_tags,
    var.common_tags,
    # {
    #   Name = "network-account-resource-share"
    # },
  )
}

resource "aws_ram_resource_association" "default" {
  count              = var.share_resource ? 1 : 0
  provider           = aws.src
  resource_arn       = aws_route53_resolver_rule.fwd[0].arn
  # resource_share_arn = aws_ram_resource_share.sender_share.arn
  resource_share_arn = aws_ram_resource_share.sender_share[0].arn
}

resource "aws_ram_principal_association" "sender_invite" {
  # count    = var.share_resource ? 1 : 0
  provider = aws.src
  # principal = "642661817018"
  principal = var.ram_resource_association
  # dynamic "principal" {
  # for_each = toset(var.ram_resource_association)
  # principal = each.value
  # }
  # }
  # resource_share_arn = aws_ram_resource_share.sender_share.arn
  # resource_share_arn = aws_ram_resource_share.sender_share[count.index]
  resource_share_arn = aws_ram_resource_share.sender_share[0].arn
}

resource "aws_ram_resource_share_accepter" "receiver_accept" {
  count    = var.share_resource ? 1 : 0
  provider = aws.dst
  # for_each = var.aws_accounts
  # provider = {
  #   aws = "aws.${each.value.alias}"
  # }
  # receiver_account_id = "642661817018"
  share_arn = aws_ram_principal_association.sender_invite.resource_share_arn
  # share_arn =  aws_ram_principal_association.sender_invite[count.index]
  # share_arn =  aws_ram_principal_association.sender_invite[].resource_share_arn
}

##new 
resource "aws_route53_resolver_rule_association" "example_association" {
  # count            = var.share_resource ? 1 : 0
  provider         = aws.dst
  for_each         = var.share_resource ? toset(var.share_associated_vpc_id): []
  # for_each         = toset(var.share_associated_vpc_id)
  resolver_rule_id = aws_route53_resolver_rule.fwd[0].id
  vpc_id           = each.value

  depends_on = [
    aws_ram_resource_share_accepter.receiver_accept,
  ]
}