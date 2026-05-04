provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./modules/network"

  vpc_cidr_block             = var.vpc_cidr_block
  public_subnet_1_cidr       = var.public_subnet_1_cidr
  public_subnet_2_cidr       = var.public_subnet_2_cidr
  app_private_subnet_1_cidr  = var.app_private_subnet_1_cidr
  app_private_subnet_2_cidr  = var.app_private_subnet_2_cidr
  db_private_subnet_1_cidr   = var.db_private_subnet_1_cidr
  db_private_subnet_2_cidr   = var.db_private_subnet_2_cidr
  availability_zone_1        = var.availability_zone_1
  availability_zone_2        = var.availability_zone_2
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.network.vpc_id
}

module "database" {
  source = "./modules/database"

  db_subnet_ids = module.network.db_private_subnets
}