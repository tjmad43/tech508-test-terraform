provider "aws" {
    region = var.app_region
}

# create databse instance first
resource "aws_instance" "db" {
    ami = var.db_ami_id
    instance_type = var.instance_type
    associate_public_ip_address = false
    subnet_id = aws_subnet.private_subnet.id

    vpc_security_group_ids = [
    aws_security_group.allow_27017.id]
    key_name = var.ssh_key

    tags = {
        Name = var.db_vm_name
    }
}

# create app instance
resource "aws_instance" "app" {
    ami = var.app_ami_id
    instance_type = var.instance_type
    associate_public_ip_address = true
    subnet_id = aws_subnet.public_subnet.id

    vpc_security_group_ids = [
    aws_security_group.allow_22_3000_80.id]
    key_name = var.ssh_key

    tags = {
        Name = var.app_vm_name
    }
    user_data = <<-EOF
              #!/bin/bash
              export DB_HOST=mongodb://${aws_instance.db.private_ip}:27017/posts
              cd repo/app
              pm2 stop all
              pm2 start app.js
              EOF
}