variable "access_key" {}
variable "secret_key" {}
variable "region" {
  type = string
  default = "ap-northeast-1"
}

terraform {
  required_version = ">= 0.11.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "onokatio-tfstate" # 作成したS3バケット
    region = "ap-northeast-1"
    key = "kdev-aws-terraform.tfstate"
    profile = "kdev"
    encrypt = true
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
    //access_key = "${var.access_key}"
    //secret_key = "${var.secret_key}"
    region = "${var.region}"
    profile = "kdev"
}

