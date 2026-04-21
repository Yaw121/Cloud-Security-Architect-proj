provider "aws" {
    region = "us-east-1"
  
}

resource "aws_vpc" "cloud_security_vpc" {
    cidr_block = "10.0.0.0/16"
    subnet {
        cidr_block = "10.0.1.0/24"
     subnet_type = "public"
     subnet {
        cidr_block = "10.0.2.0/24"
        subnet_type = "private"
        subnet_name = "private-subnet"
     }
     subnet {
        cidr_block = "10.0.3.0/24"
        subnet_type = "public"
        subnet_name = "public-subnet"
     }
     route_table {
        route_table_name = "public-route-table"
        route {
            cidr_block = "
}
