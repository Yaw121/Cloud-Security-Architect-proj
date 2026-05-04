output "vpc_id" {
  value = aws_vpc.secVPC.id
}

output "public_subnets" {
  value = [
    aws_subnet.publicSubnet1.id,
    aws_subnet.publicSubnet2.id
  ]
}

output "app_private_subnets" {
  value = [
    aws_subnet.app_subnet_1.id,
    aws_subnet.app_subnet_2.id
  ]
}

output "db_private_subnets" {
  value = [
    aws_subnet.db_subnet_1.id,
    aws_subnet.db_subnet_2.id
  ]
}