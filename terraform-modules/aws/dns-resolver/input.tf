variable "environment" {
  description = "Environment type"
  default     = ""
  type        = string
}

variable "job" {
  description = "Resource role functional job description"
  default     = ""
  type        = string
}

variable "company" {
  description = "Company Name"
  default     = "rbh"
  type        = string
}

# variable "domain_name" {
#   description = "domain DNS Project Name"
#   default     = []
#   type        = set(string)
# }

variable "other_suffix" {
  description = "Any other value to append at the end of the resource name"
  default     = ""
  type        = string
}

variable "endpoint_type" {
  description = "Endpoint Type"
  type        = string
}

variable "associated_vpc_id" {
  description = "Associated VPC ID for shareinfra nonprod"
  default     = []
  type        = set(string)
}
# "associated_vpc_id": [
# 	"vpc-0c76494bcc2a055ab",
# 	"vpc-075cf9d08ab83b95e",
# 	"vpc-08ee2c2d96cdcdbc0"
# ],

variable "share_associated_vpc_id" {
  description = "Associated VPC ID for another nonprod"
  default     = []
  type        = set(string)
}

variable "common_tags" {
  type = map(string)
}

# variable "region" {
#   type = string
# }

variable "dns_name" {
  type        = string
  description = "name of the managed zone"
  default     = ""
}

variable "rule_type" {
  type = string
}

variable "resolver_endpoint_id" {
  description = "Inbound/Outbound endpoints "
  type        = string
}
# "resolver_endpoint_id" : "rslvr-out-1f0398246ea5468ab",

variable "target_gcp_ip_address" {
  description = "target_ip_address"
  default     = []
  type        = list(string)
}

# "target_gcp_ip_address": [
#   "172.25.228.5",
#   "172.25.240.6"
# ],
# variable "zone_name" {
#   type = string
# }

# variable "ram_resource_association" {
#   description = "ram_resource_association"
#   default     = []
#   type        = list(string)
# }

variable "ram_resource_association" {
  description = "ram_resource_association"
  default     = ""
  type = string
}

# variable "aws_accounts"{
#   type = list(map())
# }