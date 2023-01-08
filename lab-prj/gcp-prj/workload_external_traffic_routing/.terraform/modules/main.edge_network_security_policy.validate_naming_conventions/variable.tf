variable "environment" {
  description = "Environment the resource belongs to"
  default = ""
}
variable "location" {
  description = "Region or Zone the resource belongs to"
  default     = null
}
variable "resource_type" {
  description = "TF Resource type of the resource"
}
variable "prefix" {
  description = "Prefix of the resource"
  default = ""
}
variable "tenant_name" {
  description = "Tenant name of the resource"
  default = ""
}
variable "job" {
  description = "The job is used to identify resources of the same type but with different roles"
  default     = ""
}