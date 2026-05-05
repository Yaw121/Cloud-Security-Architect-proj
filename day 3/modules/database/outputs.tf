output "db_subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group.name
}

output "rds_endpoint" {
  value = aws_db_instance.mysql_db.endpoint
}