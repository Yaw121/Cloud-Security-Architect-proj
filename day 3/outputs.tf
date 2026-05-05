output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnets" {
  value = module.network.public_subnets
}

output "app_private_subnets" {
  value = module.network.app_private_subnets
}

output "db_private_subnets" {
  value = module.network.db_private_subnets
}

output "web_security_group_id" {
  value = module.security_groups.web_security_group_id
}

output "app_security_group_id" {
  value = module.security_groups.app_security_group_id
}

output "db_security_group_id" {
  value = module.security_groups.db_security_group_id
}

output "db_subnet_group_name" {
  value = module.database.db_subnet_group_name
}

output "alb_dns_name" {
  value = module.compute.alb_dns_name
}

output "rds_endpoint" {
  value = module.database.rds_endpoint
}

output "cloudtrail_bucket_name" {
  value = module.logging.cloudtrail_bucket_name
}

