variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "jenkins_user_name" {
  default = "jenkins"
}

variable "jenkins_user_password" {
  default = "jenkins"
}

variable "jenkins_name" {
  default = "jenkins"
}

variable "jenkins_instance_type" {
  default     = "t2.micro"
  description = "AWS Instance Type"
}

variable "ami" {
  default     = "ami-0ed9277fb7eb570c9"
  description = "AWS AMI"
}

variable "jenkins_key_name" {
  default     = "key_pair_name"
  description = "SSH Key in AWS Account"
}