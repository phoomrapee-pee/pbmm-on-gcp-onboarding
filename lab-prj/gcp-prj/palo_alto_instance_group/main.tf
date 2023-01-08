locals {
  platform_network_project_id = {
    np  = data.terraform_remote_state.platform_org_setup.outputs.project_network_np_id
    prd = data.terraform_remote_state.platform_org_setup.outputs.project_network_prd_id
  }
  unmanaged_instance_group_instances = distinct(flatten([
    for instance_group in var.instance_group_list : [
      for instance_name in instance_group.instance_name_list : {
        group_id      = instance_group.group_id
        instance_name = instance_name
        instance_zone = instance_group.instance_zone
      }
    ]
  ]))
  unmanaged_instance_group_instance_self_link_list = { for k, v in data.google_compute_instance.instance : split("~", k)[0] => v.self_link... }
}

data "google_compute_instance" "instance" {
  for_each = { for entry in local.unmanaged_instance_group_instances : "${entry.group_id}~${entry.instance_name}" => entry }
  name     = each.value.instance_name
  zone     = each.value.instance_zone
  project  = local.platform_network_project_id[var.environment]
}

module "unmanaged_instance_group" {
  source                  = "git::https://gitlab.com/scbtechx/pv-infra/fundamental-services/terraform-modules/components/compute/unmanaged-instance-group.git?ref=tags/1.0.1"
  for_each                = { for instance_group in var.instance_group_list : instance_group.group_id => instance_group }
  job                     = "palo-alto"
  other_suffix            = each.value.instance_zone
  company                 = var.company
  project_name            = var.project_name
  project_id              = local.platform_network_project_id[var.environment]
  environment             = var.environment
  zone                    = each.value.instance_zone
  instance_self_link_list = local.unmanaged_instance_group_instance_self_link_list[each.value.group_id]
  network_id              = var.network_id
  named_ports             = each.value.named_ports
}