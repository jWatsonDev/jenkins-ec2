
# Standup Jenkins

## Prerequisites 
* Terraform CLI 
* AWS CLI 
* AWS CLI connected to your account (i.e. aws configure)
* Key Pair 

## Install 
* Download key pair from AWS and place PEM in resources folder
* Update jenkins_key_name variable to your key pair name
* Execute the following commands 
  `terraform plan` - to see what will get created (deploy plan)
  `terraform apply` - once confirmed, execute the plan 
* Now, login! http://your-ec2-private-ip:8080
  UN/PW will be what you made it. Default UN is jenkins and default PW is jenkins.

## Remove
* If you're done with it all, delete everything with
  `terraform **destroy`**
