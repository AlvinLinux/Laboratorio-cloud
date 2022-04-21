provider "aws" {
	region = var.region
	profile = var.perfil
}

resource "aws_instance" "instalacion-instancia-terraform-ec2" {
	ami = var.ami
	instance_type = "t2.micro"
	key_name = "practico-networking"
	vpc_security_group_ids=[aws_security_group.test-terraform-sg.id]
}

resource "aws_security_group" "test-terraform-sg" {
	name = "allow_ssh"
	description = "Allow SSH inbound traffic"
	vpc_id      = var.vpc

ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_SSH"
  }
}
