# Create EC2 instance
provider "aws" {
    region = var.app_region
}

resource "aws_instance" "web" {
    ami = var.app_ami_id
    instance_type = var.app_instance_type
    associate_public_ip_address = false

    vpc_security_group_ids = [
    aws_security_group.allow_22_27017.id]
    key_name = var.ssh_key

    tags = {
        Name = var.app_vm_name
    }
}