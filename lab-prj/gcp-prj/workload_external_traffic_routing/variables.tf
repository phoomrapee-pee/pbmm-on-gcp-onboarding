variable "terraform_service_account" {
  description = "The service account to use for the organisation level terraform"
  type        = string
}

variable "platform_bucket" {
  type        = string
  description = "name of the platform bucket"
}

variable "project" {
  description = "Name of the project"
  type        = string
}

variable "company" {
  description = "Name of the company"
  type        = string
}

variable "environment" {
  description = "Name of the environment"
  type        = string
  default     = ""
}

variable "url_map" {
  description = "URL map data for the routing rules"
  type = object({
    # use_default_on_no_rule_match = bool
    host_rule_list = list(object({
      rule_name = string
      # use_default_on_no_path_match = bool
      host_list = list(string)
      path_rule_list = optional(list(object({
        id        = string
        path_list = list(string)
      })))
    }))
  })
}