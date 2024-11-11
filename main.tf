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

data "aws_vpc" "First_Default_VPC" {
  id = var.vpc_id
}

data "aws_subnet" "Subnet_First_Default_VPC" {
  id = var.subnet_id
}

resource "aws_instance" "blog2" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.Subnet_First_Default_VPC.id
  vpc_security_group_ids= [aws_security_group.security_group_2.id]

  tags = {
    Name = "EC2INSTANCE2"
  }
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "security_group_2"{

  name        = "allow HTTPS"
  description = "Allow HTTPS inbound traffic"
  vpc_id = data.aws_vpc.First_Default_VPC.id
  
  ingress {
    description = "allow HTTPS traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
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




