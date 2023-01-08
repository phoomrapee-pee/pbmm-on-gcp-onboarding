# Terraform Network Module

This submodule is part of the the `terraform-google-network` module. It creates the cloud-nat resources.


## Usage

Basic usage of this submodule is as follows:

```hcl
module "vpc" {
    source  = "terraform-google-modules/network/google//modules/routes"
    version = "~> 2.0.0"

    project_id   = "<PROJECT ID>"
    network_name = "example-vpc"

    delete_default_internet_gateway_routes = false

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        },
        {
            name                   = "app-proxy"
            description            = "route through proxy to reach app"
            destination_range      = "10.50.10.0/24"
            tags                   = "app-proxy"
            next_hop_instance      = "app-proxy-instance"
            next_hop_instance_zone = "us-west1-a"
        },
    ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bgp | n/a | <pre>object({<br>    asn               = number<br>    advertise_mode    = optional(string)<br>    advertised_groups = optional(list(string))<br>    advertised_ip_ranges = optional(list(object({<br>      range       = string<br>      description = optional(string)<br>    })))<br>  })</pre> | n/a | yes |
| department\_code | Code for department, part of naming module | `string` | n/a | yes |
| description | n/a | `string` | n/a | yes |
| environment | S-Sandbox P-Production Q-Quality D-development | `string` | n/a | yes |
| location | location for naming and resource placement | `string` | `"asia-southeast1"` | no |
| network\_name | The name of the network to attach to this router | `any` | n/a | yes |
| project\_id | The ID of the project where the routes will be created | `any` | n/a | yes |
| region | n/a | `string` | n/a | yes |
| router\_name | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| routers | The created routers resources |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


### Routes Input

The routes list contains maps, where each object represents a route. For the next_hop_* inputs, only one is possible to be used in each route. Having two next_hop_* inputs will produce an error. Each map has the following inputs (please see examples folder for additional references):

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The name of the route being created  | string | - | no |
| description | The description of the route being created | string | - | no |
| tags | The network tags assigned to this route. This is a list in string format. Eg. "tag-01,tag-02"| string | - | yes |
| destination\_range | The destination range of outgoing packets that this route applies to. Only IPv4 is supported | string | - | yes
| next\_hop\_internet | Whether the next hop to this route will the default internet gateway. Use "true" to enable this as next hop | string | `"false"` | yes |
| next\_hop\_ip | Network IP address of an instance that should handle matching packets | string | - | yes |
| next\_hop\_instance |  URL or name of an instance that should handle matching packets. If just name is specified "next\_hop\_instance\_zone" is required | string | - | yes |
| next\_hop\_instance\_zone |  The zone of the instance specified in next\_hop\_instance. Only required if next\_hop\_instance is specified as a name | string | - | no |
| next\_hop\_vpn\_tunnel | URL to a VpnTunnel that should handle matching packets | string | - | yes |
| priority | The priority of this route. Priority is used to break ties in cases where there is more than one matching route of equal prefix length. In the case of two routes with equal prefix length, the one with the lowest-numbered priority value wins | string | `"1000"` | yes |