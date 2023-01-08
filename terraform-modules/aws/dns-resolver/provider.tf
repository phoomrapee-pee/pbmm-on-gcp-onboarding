terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
      # configuration_aliases = [aws.src, aws.src-prd, aws.dst, aws.dst-prd]
      configuration_aliases = [aws.src, aws.dst]
    }
  }
}