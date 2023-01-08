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



organization_config = {
  org_id          = "845220742240" # REQUIRED EDIT Numeric portion only '#############'"
  default_region  = "asia-southeast1" # REQUIRED EDIT Cloudbuild Region - default to na-ne1 or 2
  department_code = "Pt" # REQUIRED EDIT Two Characters. Capitol and then lowercase  ||\  Department code is a two charater upper case lower case code.
  owner           = "phoomrapeeown" # REQUIRED EDIT Used in naming standard
  environment     = "P" # REQUIRED EDIT S-Sandbox P-Production Q-Quality D-development
  location        = "asia-southeast1" # REQUIRED EDIT Location used for resources. Currently asia-southeast1 is available
  labels          = {} # REQUIRED EDIT Object used for resource labels
  # switch out root_node depending on whether you are running directly off the organization or a folder
  #root_node       = "organizations/845220742240" # REQUIRED EDIT format "organizations/#############" or "folders/225610052760##"
  root_node       = "folders/225610052760" # REQUIRED EDIT format "organizations/#############" or "folders/225610052760##"
  
  contacts = {
    "user@email.com" = ["ALL"] # REQUIRED EDIT Essential Contacts for notifications. Must be in the form EMAIL -> [NOTIFICATION_TYPES]
  }
  billing_account = "01FF4E-383D23-F85450" # REQUIRED EDIT Format of ######-######-######
}

