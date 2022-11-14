# provider "aws" {
#   region = var.region
# }

# provider "aws" {
#   region = var.region
#   assume_role {
#     role_arn = var.assume_role_arn
#   }
# }

# provider "aws" {
#   region = var.region
#   alias = "network-prod"
#   assume_role {
#     role_arn = var.assume_role_arn
#   }
# }

# provider "aws" {
#   region = var.region
#   alias = "aella-network-nonprod"
#   assume_role {
#     role_arn = var.assume_role_arn
#   }
# }
# provider "aws" {
#   region = var.region
#   alias = "rbh-network-nonprod"
#   assume_role {
#     # role_arn = var.assume_role_arn
#     role_arn = "arn:aws:iam::728459525782:role/RBHAdminRole"
#   }
# }
# provider "aws" {
#   region = var.region
#   alias = "rbh-dataplatform-nonprod"
#   assume_role {
#     # role_arn = var.assume_role_arn
#     role_arn = "arn:aws:iam::642661817018:role/RBHAdminRole"
#   }
# }

# provider "aws" {
#   alias = "nonbank-nonprod"
#   region = var.region
#   assume_role {
#     role_arn = "arn:aws:iam::476109445501:role/AellaAdminRole"
#   }
# }

# provider "aws" {
#   alias = "nonbank-prod"
#   region = var.region
#   assume_role {
#     role_arn = "arn:aws:iam::082372545318:role/AellaAdminRole"
#   }
# }
terraform {
  backend "s3" {
    key      = "platform/terraform_resolver.tfstate"
    role_arn = "arn:aws:iam::728459525782:role/RBHAdminRole"
  }
}
