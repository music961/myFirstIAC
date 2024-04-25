resource "aws_instance" "vm"{
    count = 3
    ami = XXXX
    instance_type = "t2.micro"
    sub_id = module.vpc.public_subnets[count.index]
        tags = {
        Name = "instance-${count.index}"
    }
}
resource "aws_epi" "my_ip" {
    count = 2
    instance = aws_instance.vm[count.index].id
}
output "e_ip" {
    value = aws_eip.my_ip.*.public_ip
}
