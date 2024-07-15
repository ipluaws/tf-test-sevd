provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_version = "1.4.6"
  backend "s3" {
    bucket         = "eye-terraform-state-infra"
    key            = "infra/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locks-infra" # Optional, for state locking
  }
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "~> 4.20.0"
#    }
#  }
}

module "vpc" {
  source = "./modules/vpc"
  vpc_name                = var.vpc_name
  vpc_cidr                = var.vpc_cidr
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones      = var.availability_zones
}

module "ecr" {
  source = "./modules/ecr"
  repository_name = var.ecr_repository_name
}

module "ecs" {
  source             = "./modules/ecs"
  cluster_name       = "demo-cluster"
  task_family        = "demo-task"
  container_image    = "${var.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repository_name}:latest"
  service_name       = "demo-service"
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id  = module.alb.security_group_id
  target_group_arn   = module.alb.target_group_arn
}

module "alb" {
  source           = "./modules/alb"
  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_name         = "demo-alb"
  target_group_name = "demo-tg"
}

module "s3" {
  source = "./modules/s3"
  bucket_name = "sevdesk-spa-bucket"
}

module "cloudfront" {
  source              = "./modules/cloudfront"
  s3_bucket_domain_name = module.s3.bucket_domain_name
  s3_bucket_id        = module.s3.bucket_id
  alb_dns_name        = module.alb.alb_dns_name
}

