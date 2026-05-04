variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  default = "10.0.2.0/24"
}

variable "app_private_subnet_1_cidr" {
  default = "10.0.11.0/24"
}

variable "app_private_subnet_2_cidr" {
  default = "10.0.12.0/24"
}

variable "db_private_subnet_1_cidr" {
  default = "10.0.21.0/24"
}

variable "db_private_subnet_2_cidr" {
  default = "10.0.22.0/24"
}

variable "availability_zone_1" {
  default = "us-east-1a"
}

variable "availability_zone_2" {
  default = "us-east-1b"
}