data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631"] # Bitnami
}

resource "aws_instance" "blog2" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type
  vpc_security_group_ids= [aws_security_group.first_security_group.id]

  tags = {
    Name = "EC2INSTANCE2"
  }
}

resource "aws_vpc" "default" {}


resource "aws_security_group" "first_security_group"{

  name        = "allow HTTPS"
  description = "Allow HTTPS inbound traffic"
   vpc_id = aws_vpc.default.id
  
  ingress {
    description = "allow HTTPS traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "https"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }

}

  lifecycle {
   create_before_destroy = true
  }


