# Cloud-Security-Architect-proj

# AWS Three-Tier Architecture with Terraform

- A production-ready, highly available three-tier web application architecture deployed on AWS using Terraform. This project demonstrates infrastructure as code best practices, modular design, and cloud architecture principles.


# AWS Three-Tier Architecture Terraform


## **Features**

- Infrastructure Components

# **VPC Networking**

- Custom VPC with configurable CIDR
- Public subnets for web tier and bastion
- Private subnets for application tier
- Isolated subnets for database tier
- NAT Gateway for private subnet internet access
- VPC Flow Logs for network monitoring

# **Web Tier**

- Auto Scaling Group with Launch Template
- Application Load Balancer with health checks
- Apache web server with reverse proxy
- CloudWatch monitoring and alarms

# Application Tier

- Auto Scaling Group with Launch Template
- Internal Application Load Balancer
- Python Flask REST API
- Target tracking and step scaling policies

# Database Tier

- RDS MySQL with Multi-AZ support
- Automated backups and snapshots
- Secrets Manager integration
- Performance Insights enabled

# Security

- Layered security groups (defense in depth)
- IMDSv2 enforcement on all instances
- Encrypted storage and connections
- SSH hardening on bastion host

# Monitoring & Observability

- CloudWatch Alarms for all tiers
- VPC Flow Logs
- Enhanced RDS monitoring
- Custom CloudWatch metrics
- Centralized logging