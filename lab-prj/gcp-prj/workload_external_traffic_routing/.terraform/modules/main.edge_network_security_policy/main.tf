module "validate_naming_conventions" {
  source        = "git::https://gitlab.com/scbtechx/pv-infra/fundamental-services/terraform-modules/components/utils/naming_convention.git?ref=main"
  resource_type = "google_compute_security_policy"
  environment   = var.environment
}

locals {
  resource_type_abbr = module.validate_naming_conventions.resource_type_abbr
  environment_abbr   = module.validate_naming_conventions.environment_abbr
  env_key            = var.environment != "" ? "-${local.environment_abbr}" : ""
  other_key          = var.other_suffix != "" ? "-${var.other_suffix}" : ""
  job_key            = var.job != "" ? "-${var.job}" : ""
  name               = "${local.resource_type_abbr}-${var.company}-${var.project_name}${local.job_key}${local.env_key}${local.other_key}"
}

resource "google_compute_security_policy" "cloudarmor-security-policy" {
  project     = var.project
  for_each    = var.security_policy
  name        = local.name
  description = each.value.description
  type        = each.value.type

  dynamic "adaptive_protection_config" {
    for_each = each.value.type == "CLOUD_ARMOR" ? [1] : []

    content {
      layer_7_ddos_defense_config {
        enable = each.value.layer_7_ddos_defense_enable
      }
    }
  }

  dynamic "rule" {
    for_each = lookup(each.value, "versioned_expr", [])
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        versioned_expr = rule.value.versioned_expr_name
        config {
          src_ip_ranges = flatten(rule.value.src_ip_ranges)
        }
      }
      description = rule.value.rule_description
    }
  }
  dynamic "rule" {
    for_each = lookup(each.value, "expr", [])
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        expr {
          expression = rule.value.expression
        }
      }
      description = rule.value.rule_description
      preview     = rule.value.preview
    }
  }
}