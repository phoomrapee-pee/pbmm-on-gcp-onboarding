locals {
  platform_network_project_id = {
    np  = data.terraform_remote_state.platform_org_setup.outputs.project_network_np_id
    pt  = data.terraform_remote_state.platform_org_setup.outputs.project_network_np_id
    prd = data.terraform_remote_state.platform_org_setup.outputs.project_network_prd_id
  }
  xlb_certificate_list = {
    np  = ["np-gcpppv-tech"]
    pt  = ["np-gcpppv-tech"]
    prd = ["gcpppv-tech"]
  }
  untrusted_hub_network_id = data.terraform_remote_state.platform_hub_network.outputs.untrusted_hub_network.name
  palo_alto_instance_group = data.terraform_remote_state.palo_alto_instance_group.outputs.unmanaged_instance_group
  managed_zone_name        = data.terraform_remote_state.platform_dns.outputs.public-dns.name
  port_name                = "${var.project}-${var.environment}"
}

module "main" {
  source                   = "git::https://gitlab.com/scbtechx/pv-infra/fundamental-services/terraform-modules/gcp/products/external-traffic-routing.git?ref=tags/1.0.1"
  project_id               = "scbtechx-sharedvpc-nonprod"
  network_id               = "transit-nonprod"	
  environment              = "np"
  project_name             = "techx-apigee"
  company                  = "techx"
  url_map                  = []
  xlb_certificate_list     = [apigee-nonprod-ssl-dev]
  port_name                = "433"
  unmanaged_instance_group = "projects/pex-nonprod/zones/asia-southeast1-b/instanceGroups/test-instance-group-nginx"
  managed_zone_name        = "np.gcpaella.tech."
  backend_security_policy = {
  }
  edge_security_policy = {
  }
}