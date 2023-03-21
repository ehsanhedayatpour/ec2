provider "aws" {
    region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "sample_ec2" {
  ami                     = data.aws_ami.ubuntu.id
  count			  = "1"
  instance_type           = "t2.micro"
  key_name                = "rootkey"
  vpc_security_group_ids = [aws_security_group.main_sg.id]
}
