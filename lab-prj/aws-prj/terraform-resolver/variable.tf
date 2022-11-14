variable "environment" {
  type        = string
  description = "Environment type"
  default     = ""
}

# variable "job" {
#   description = "Resource role functional job description"
#   default     = ""
#   type        = string
# }

variable "company" {
  description = "Company Name"
  default     = "rbh"
  type        = string
}

# variable "project_name" {
#   default     = ""
#   description = "Project Name"
#   type        = string
# }

# variable "endpoint_type" {
#   description = "Endpoint Type"
#   type        = string
# }

# variable "resolver_endpoint_id" {
#   description = "Inbound/Outbound endpoints "
#   type        = string
# }

variable "common_tags" {
  type = map(string)
}

variable "region" {
  type = string
}

# variable "zone_name" {
#   type = string
# }

variable "domain_name_object" {
  description = "data"
  type = list(object({
    job                   = string
    dns_name              = string
    endpoint_type         = string
    rule_type             = string
    resolver_endpoint_id  = string
    target_gcp_ip_address = list(string)
    associated_vpc_id     = set(string)
    # ram_resource_association = list(string)
    ram_resource_association = string
    share_associated_vpc_id  = set(string)
    # aws_src = string
    # aws_dst = string
  }))
}
# variable "aws_accounts"{
#   type = list(map())
#   default = [  
#     { "aws_account_id": "728459525782", "alias" : "rbh-network-nonprod", "role_arn": "arn:aws:iam::728459525782:role/RBHAdminRole"},
#     { "aws_account_id": "642661817018","alias" : "rbh-dataplatform-nonprod","role_arn": "arn:aws:iam::642661817018:role/RBHAdminRole"},
#   ]
#   #   aws_accounts = [
# #     { "aws_account_id": "728459525782", "alias" : "rbh-network-nonprod", "role_arn": "arn:aws:iam::728459525782:role/RBHAdminRole"},
# #     { "aws_account_id": "642661817018","alias" : "rbh-dataplatform-nonprod","role_arn": "arn:aws:iam::642661817018:role/RBHAdminRole"},
# #     ]
# }