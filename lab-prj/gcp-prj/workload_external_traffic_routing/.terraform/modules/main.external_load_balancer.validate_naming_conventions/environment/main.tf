variable "environment" {
  description = "must be a known environment"
  validation {
    condition = (
        contains(["", "np", "dev", "alp", "stg", "pt", "pp", "prd", "prod"], var.environment) == true
      )
    error_message = "The environment must match one of the above values."
  }
}
