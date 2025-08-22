# Terraform

- [Terraform](#terraform)
  - [Creating an EC2 instance](#creating-an-ec2-instance)
    - [Instance setup](#instance-setup)
    - [Security group](#security-group)
    - [Add SG and SSH key](#add-sg-and-ssh-key)
    - [To run](#to-run)
    - [Variables](#variables)
  - [Sparta app \& database deployment](#sparta-app--database-deployment)
    - [App](#app)
  - [Custom VPC](#custom-vpc)


## Creating an EC2 instance
### Instance setup
see main.tf
- define provider
  ```terraform
  provider "aws" {
    region = "eu-west-1"
  }
  ```
- define resource: `resource "aws_instance" "web" {`
- ami to use - AMI ID ami-0c1c30571d2dae5c9 (for ubuntu 22.04 lts)
  - `ami = "ami-0c1c30571d2dae5c9"`
- type of instance to launch - t3.micro
  - `instance_type = "t3.micro"`
- add public IP to instance
  - `associate_public_ip_address = true`
- add tag for name
  - `tags = {
        Name = "tech508-tabitha-tf-first-vm"
    }`

### Security group
see SG.tf


### Add SG and SSH key
- add security group to instance
  - `vpc_security_group_ids = [
    aws_security_group.allow_22_3000_80.id]`
- add ssh key
  - `key_name = "tech508-tabitha-aws"`


### To run
- cd to folder
- `terraform init` to download provider plugins and setup tfstate files
- `terraform plan`
- `terraform apply` to create instance, also does `plan` first
- `terraform destroy` to remove anything created at end of day

**Note:** `terraform fmt` to clean up spacing


### Variables
- `variable "variable_name" {
    default = "value"
    }`
- refer to in code as `var.variable_name`
- file for variables `variable.tf` is gitignored
  - assign variables there so they are not publicly viewable

## Sparta app & database deployment
### App
see create-app-instance
- from basic instance above, change AMI ID and names to be consistent with app
- security group:



## Custom VPC
see tech508-test-terraform create-app-vpc

- follow steps from vpc.md, getting syntax from terraform deocumentation https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#user_data-1

