variable "project_name" {
  description = "platform/tenant name"
}

variable "company" {
  type = string
}
variable "project" {
  description = "The project ID to create the resources in."
  type        = string
}
variable "other_suffix" {
  type        = string
  description = "any other suffix to add to name of the resource"
  default     = ""
}
variable "environment" {
  type    = string
  default = ""
}
variable "job" {
  type        = string
  description = "purpose of the resource"
  default     = ""
}
variable "security_policy" {
  description = "Security policy configuration"
  type        = map(any)
}