# locals {
#   terraform_service_account = "prj-bootstrap-terraform@prj-bootstrap-096957.iam.gserviceaccount.com"
# }
# # terraform_service_account = "prj-bootstrap-terraform@prj-bootstrap-096957.iam.gserviceaccount.com"

# provider "google" {
#   alias = "impersonate"

#   scopes = [
#     "https://www.googleapis.com/auth/cloud-platform",
#     "https://www.googleapis.com/auth/userinfo.email",
#   ]
# }

# data "google_service_account_access_token" "default" {
#   provider               = google.impersonate
#   target_service_account = local.terraform_service_account
#   scopes                 = ["userinfo-email", "cloud-platform"]
#   lifetime               = "600s"
# }

# provider "google" {
#   access_token = data.google_service_account_access_token.default.access_token
# }

# provider "google-beta" {
#   access_token = data.google_service_account_access_token.default.access_token
#   # // for creating users in cloud identity
#   # billing_project       = var.billing_project
#   # user_project_override = true
# }

provider "google" {
  # credentials = file("credentials_techx.json")
  access_token = "ya29.a0Aa4xrXORdj3rYSLBVPhAyyuwHdrc-kYa5TFqYlXkg9u7v3wJjXT5RDdCTtMnOjw9geA5UIbX8XVkeKaAf1EtNwmgrfOY6kDP4aAazngU3C-87pPTpJ5emn31JOpzzSKRTPIXLocdnYbMlt8ClX6ktMr1O00EY5jRewUxF20aCgYKATASARESFQEjDvL96BHs_ms704yVb_QaEr4pKg0174"
  # credentials = file("credentials_lab.json")
  # credentials_lab = file("credentials_lab.json")
  # access_token = "ya29.a0Aa4xrXNEw41EegHSyFmOgHWc46lRMVEz9Xp4V8Igs3itTu8atogrS6oyUlnKS-oC7Jcbv9uNX_9LZMKTtrXaujNEdHxOZNbkpwVlU0x-LertQhioSuyu-7zDV5f1QzdGI72mjC8SY7IJ_PAgJynPv4WWyxij59FXlaktaCgYKATASARISFQEjDvL9PSZIxrTgw_-PF3-BefHa4w0171"
  project     = "scbtechx-sharedvpc-nonprod"
  # project = "lab2-360510"
  region      = "asia-southeast1"
  zone        = "asia-southeast1-b"
}