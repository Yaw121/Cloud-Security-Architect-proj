variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "app_private_subnet_1_cidr" {
  type    = string
  default = "10.0.11.0/24"
}

variable "app_private_subnet_2_cidr" {
  type    = string
  default = "10.0.12.0/24"
}

variable "db_private_subnet_1_cidr" {
  type    = string
  default = "10.0.21.0/24"
}

variable "db_private_subnet_2_cidr" {
  type    = string
  default = "10.0.22.0/24"
}

variable "availability_zone_1" {
  type    = string
  default = "us-east-1a"
}

variable "availability_zone_2" {
  type    = string
  default = "us-east-1b"
}

variable "ami_id" {
  type        = string
  description = "Amazon Linux 2023 AMI ID for us-east-1. Update if needed."
  default     = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "db_username" {
  type    = string
  default = "adminuser"
}

variable "db_password" {
  type        = string
  description = "Database password. For real projects, pass this with terraform.tfvars or environment variables."
  sensitive   = true
}