output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "app_server_1_id" {
  value = aws_instance.app_server_1.id
}

output "app_server_2_id" {
  value = aws_instance.app_server_2.id
}

output "ec2_ssm_role_name" {
  value = aws_iam_role.ec2_ssm_role.name
}