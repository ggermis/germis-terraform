provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

data "aws_route53_zone" "main" {
  name         = local.domain_name
  private_zone = false
}

terraform {
  backend "s3" {
    region  = "eu-central-1"
    bucket  = "germis-terraform-state"
    key     = "website.tfstate"
    encrypt = "true"
  }
}
