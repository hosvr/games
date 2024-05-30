terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  cloud {
    organization = "mcity"
    workspaces { name = "mcity" }
  }

  required_version = "~> 1.8.0"
}

provider "aws" { region = "us-east-2" }

resource "aws_instance" "mcity" {
  ami                                  = "ami-0ca2e925753ca2fb4"
  instance_type                        = "r7a.xlarge"
  key_name                             = "mcity"
  instance_initiated_shutdown_behavior = "stop"
  vpc_security_group_ids               = [aws_security_group.mcity_sg.id]
  root_block_device {
    volume_size = 25
  }

  user_data                            = file("./config.sh")

  depends_on                           = [aws_security_group.mcity_sg]
}

resource "aws_security_group" "mcity_sg" {
  name        = "mcity-securitygroup"
  description = "Allow traffic to mcity instance"
}

resource "aws_vpc_security_group_ingress_rule" "udp_inbound" {
  security_group_id = aws_security_group.mcity_sg.id
  description       = "Allow inbound traffic"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "2450"
  to_port           = "2500"
  ip_protocol       = "udp"
}

resource "aws_vpc_security_group_ingress_rule" "jho_ssh" {
  security_group_id = aws_security_group.mcity_sg.id
  description       = "Allow inbound ssh"
  cidr_ipv4         = "69.171.204.97/32"
  from_port         = "22"
  ip_protocol       = "tcp"
  to_port           = "22"
}

resource "aws_vpc_security_group_ingress_rule" "bortaz_ssh" {
  security_group_id = aws_security_group.mcity_sg.id
  description       = "Allow inbound ssh"
  cidr_ipv4         = "74.128.201.236/32"
  from_port         = "22"
  ip_protocol       = "tcp"
  to_port           = "22"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.mcity_sg.id
  description       = "Allow all outbound traffic"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_eip" "mcity_eip" {
  instance = aws_instance.mcity.id
  domain   = "vpc"
}

resource "aws_eip_association" "mcity_eip_assoc" {
  instance_id   = aws_instance.mcity.id
  allocation_id = aws_eip.mcity_eip.id
}
