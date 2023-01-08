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

provider "aws" {
  region = var.region
  alias  = "rbh-network-prod"
  assume_role {
    # role_arn = var.assume_role_arn
    role_arn = "arn:aws:iam::414508995086:role/RBHAdminRole"
  }
}

provider "aws" {
  region = var.region
  alias  = "rbh-dataplatform-prod"
  assume_role {
    # role_arn = var.assume_role_arn
    role_arn = "arn:aws:iam::430911549125:role/RBHAdminRole"
  }
}

provider "aws" {
  region = var.region
  alias  = "robinhood-pam-nonprod"
  assume_role {
    # role_arn = var.assume_role_arn
    role_arn = "arn:aws:iam::176841248351:role/RBHAdminRole"
  }
}

provider "aws" {
  region = var.region
  alias  = "rbh-src"
  assume_role {
    role_arn = var.role_arn
  }
}

provider "aws" {
  region = var.region
  alias  = "rbh-dst"
  assume_role {
    # role_arn = var.assume_role_arn
    role_arn = var.role_arn_dst
  }
}