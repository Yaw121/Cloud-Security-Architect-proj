resource "aws_iam_role" "ec2_ssm_role" {
  name = "three-tier-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "three-tier-ec2-instance-profile"
  role = aws_iam_role.ec2_ssm_role.name
}

data "aws_subnet" "app_subnet" {
  id = var.app_subnet_ids[0]
}

resource "aws_lb" "app_alb" {
  name               = "three-tier-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_security_group_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "three-tier-alb"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "three-tier-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_subnet.app_subnet.vpc_id

  health_check {
    path    = "/"
    matcher = "200"
  }

  tags = {
    Name = "three-tier-app-tg"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_instance" "app_server_1" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.app_subnet_ids[0]
  vpc_security_group_ids      = [var.app_security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  associate_public_ip_address = false

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "<h1>App Server 1 - Private Tier</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "private-app-server-1"
  }
}

resource "aws_instance" "app_server_2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.app_subnet_ids[1]
  vpc_security_group_ids      = [var.app_security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  associate_public_ip_address = false

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "<h1>App Server 2 - Private Tier</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "private-app-server-2"
  }
}

resource "aws_lb_target_group_attachment" "app_server_1_attach" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app_server_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "app_server_2_attach" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app_server_2.id
  port             = 80
}