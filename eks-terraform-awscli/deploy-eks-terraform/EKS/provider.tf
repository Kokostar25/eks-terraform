
# Configure the AWS Provider
provider "aws" {
  region = var.region
  // profile = "iamadmin-general"
}

data "aws_region" "current" {

}

data "aws_availability_zones" "available" {

}

provider "http" {
    
}