# terraform-sdx-project

## Terraform version
Terraform version in this project: "v1.12.2


1. 
- terraform init: Can be used for starting the Terraform project. Downloads the necessardy files.
- terraform plan: Shows the changes that have been made.
terraform apply: applies the changes to create or update the infrastrucure.

2. 
- terraform fmt: formats the code for enhance readibility and consistency
- terraform validate: checks syntax errors and validates th configuration
- terraform refresh: updates the file with the real infrastructure state.

3. 
- main.tf: Main file that contains the definitions.
- variables.tf: File that contains the definitions of the variables.
- outputs.tf: Should be sed for getting output from the resources that have been made.

4. 
- HCL (Hashicorp Configuration Language): Langage that Terraform is using which is human-readible.

5. 
- resource block: it consists of a keyword, resource type, and local name.

6. 
- module: it is a container for multiple resources that are used together. enables the user to not repeat itself. practical.

7. 
- provider: a plugin that Terraform to interact with APIs of cloud platforms. *e.g. Azure

8. 
- terraform.tfstate: terraform uses this file to track the resources and their properties.

9. 
- difference between variables.tf and terraform.tfvars: while variables.tf declare the variables and their types, terraform.tfvars assigns values to those variables.

10. 
- Vnet (Virtual Network): a private network in Azure.
- Subnet: segment in a VNet.
- NSG (Network Security Group): set of rules to control inbound and outbound traffic.

11. 
- Public IP: accessible from the internet
- Private IP: only accessible within internal network.

12. 
- What does it mean to assign an NSG to a subnet instead of a VM?: when assigned to a subnet, the rules applies to all resources within that subnet.


 


-- Problems:
1. Computer could not find the path to my SSH key file because it did not exist. 
- I changed "-b 4096" with -t ed25519" because it creates more modern and safer keys.

2. Eveything was working except the fact that IP adress did not work.
- I made sure that two IP adresses are the same from looking manually from Azure portal. (Azure portal and the output)
- I added inbound rules to Network Security Groups (HTTP: 80 and SSH: 22).
- I checked if Apache is set to my computer or not (by ordering the terminal "ssh sdxuser@<public_ip>")


-- In order to start the project, 
 First, login to your Azure account by typing to terminal:
 az login

 Then, write those to terminal, respectively:
 terraform init
 terraform plan
 terraform apply

 If you want to delete the resources:
 terraform destroy

