provider "aws" {
  region = var.region
}

provider "aws" {
  region = var.region
  alias  = "rbh-network-nonprod"
  assume_role {
    # role_arn = var.assume_role_arn
    role_arn = "arn:aws:iam::728459525782:role/RBHAdminRole"
  }
}

provider "aws" {
  region = var.region
  alias  = "rbh-dataplatform-nonprod"
  assume_role {
    # role_arn = var.assume_role_arn
    role_arn = "arn:aws:iam::642661817018:role/RBHAdminRole"
  }
}