- Create a new folder named ansible in your techxxx-test-tf or techxxx-learn-tf repo
- Create 3 folders inside of the ansible folder:

### Folder 1 named controller

In this folder, create Terraform code to create a controller instance:

- Name: techxxx-yourname-ubuntu-2204-ansible-controller
- Size: t3.micro as usual
- Security group: Allow SSH port
- VPC + subnets: Default ones
- Key pair: Use the one you usually use for your AWS instances
- Image: Ubuntu Server 22.04 LTS (free tier eligible)
- User data: Leave it blank - don't run any scripts or user data on it

### Folder 2 named app-node

In this folder, create Terraform code to create an Ansible 'target node' instance (will run the app eventually):

- Name: techxxx-yourname-ubuntu-2204-ansible-target-node-app
- Size: t3.micro as usual
- Security group: Allow SSH, HTTP, port 3000 (the usual for the app)
- VPC + subnets: Default ones
- Key pair: Use the one you usually use for your AWS instances (and the same one as you used on the controller)
- Image: Ubuntu Server 22.04 LTS (free tier eligible), NOT your custom app AMI
- User data: Leave it blank - don't run any scripts or user data on it

### Folder 3 named db-node

In this folder, create Terraform code to create an Ansible 'target node' instance (will run the DB eventually):

- Name: techxxx-yourname-ubuntu-2204-ansible-target-node-db
- Size: t3.micro as usual
- Security group: Allow SSH, Mongo DB (the usual for the DB)
- VPC + subnets: Default ones
- Key pair: Use the one you usually use for your AWS instances (and the same one as you used on the controller)
- Image: Ubuntu Server 22.04 LTS (free tier eligible), NOT your custom DB AMI
- User data: Leave it blank - don't run any scripts or user data on it


### How to test

Make sure:

- You get Terraform to create each of the VMs above
- After Terraform has created each VM, you can SSH into each one
- Before the end of the day, you Terraform destroy each the VMs
- You are now ready for the Ansible topic for Monday