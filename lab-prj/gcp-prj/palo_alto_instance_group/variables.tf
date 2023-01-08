variable "terraform_service_account" {
  description = "The service account to use for the organisation level terraform"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "company" {
  description = "Name of the company"
  type        = string
}
variable "platform_bucket" {
  type        = string
  description = "name of the platform bucket"
}
variable "environment" {
  description = "Name of the environment"
  type        = string
  default     = ""
}

variable "network_id" {
  type = string
}

variable "instance_group_list" {
  type = list(any)
}