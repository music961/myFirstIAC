resource "aws_instance" "my_instance-01"{
    ami = data.aws_ami.amazon-image.id
    instance_type = "t2.micro"
    key_name = "web-key"
    vpc_security_group_ids = [
        aws_security_group.my_sg.id
    ]
    user_data = file("webserver.sh")
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("~/Download/pintoDB.pem")
        host = self.public_ip
    }
    provisioner "remote-exec" {
        inline = ["touch /tmp/fileA"]
    }

    tags = {
        Name = "instance-01"
    }
}

data "aws_ami" "amazon-image" {
    most_recent = true
    owner = ["amazon"]
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*x86_64-ebs"]
    }
}