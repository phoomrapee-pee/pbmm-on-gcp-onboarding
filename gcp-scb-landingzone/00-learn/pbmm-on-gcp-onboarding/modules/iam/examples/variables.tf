/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


variable "billing_account" {
  description = "Billing account"
}

variable "parent" {
  description = "Organization or Folder"
}
variable "department_code" {
  type        = string
  description = "Code for department, part of naming module"
  default     = "Ut"
}

variable "environment" {
  type        = string
  description = "S-Sandbox P-Production Q-Quality D-development"
  default     = "D"
}

variable "location" {
  type        = string
  description = "location for naming and resource placement"
  default     = "asia-southeast1"
}

variable "owner" {
  type        = string
  description = "Division or group responsible for security and financial commitment."
  default     = "unittest"
}

variable "user_defined_string" {
  type        = string
  description = "User defined string."
  default     = "utvmtest"
}

variable "additional_user_defined_string" {
  type        = string
  description = "Additional user defined string."
  default     = ""
}

variable "organization" {
  description = "Organization to apply changes to in the form of ###########"
  type        = string
  default     = null
}