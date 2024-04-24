terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}
  
provider "aws" {
  region = var.region
}

resource "aws_instance" "my_instance-01"{
  ami = data.aws_ami.amazon-image
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
  depends_on = [aws_s3_bucket.my_bucket]
}

resource "aws_eip" "my_eip" {
  instance = aws_instance.my_instance-01.id
}

locals {
  name_tags = {
    Name = "${var.ins}"
  }
}

variable "region"{
  default = "ap-northeast-2"
}

variable "instance_name"{
  default = "webserver-vm"
}

output "ip_addr" {
  value = aws_instance.my_instance-01.private_ip
}

data "aws_ami" "amazon-image" {
  most_recent = true
  owner = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*x86_64-ebs"]
  }
}

