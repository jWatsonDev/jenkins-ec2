terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_security_group" "security_group_jenkins" {
  name        = "security_group_${var.jenkins_name}"
  description = "Allows all traffic"

  # SSH
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  # HTTP
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  # Jenkins Java Network Launch Protocol (JNLP)
  ingress {
    from_port = 50000
    to_port   = 50000
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  # Allow All Egress 
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
  instance_type   = var.jenkins_instance_type
  security_groups = ["${aws_security_group.security_group_jenkins.name}"]
  ami             = var.ami
  key_name        = var.jenkins_key_name

  # Add jenkins_startup.sh
  provisioner "file" {
    connection {
      user        = "ec2-user"
      host        = aws_instance.jenkins.public_ip
      timeout     = "1m"
      private_key = file("resources/${var.jenkins_key_name}.pem")
    }
    source      = "resources/jenkins_startup.sh"
    destination = "/home/ec2-user/jenkins_startup.sh"
  }

  # Add jobmaster.xml
  provisioner "file" {
    connection {
      user        = "ec2-user"
      host        = aws_instance.jenkins.public_ip
      timeout     = "1m"
      private_key = file("resources/${var.jenkins_key_name}.pem")
    }
    source      = "resources/jobmaster.xml"
    destination = "/home/ec2-user/jobmaster.xml"
  }

  # Install Jenkins 
  provisioner "remote-exec" {
    connection {
      user        = "ec2-user"
      host        = aws_instance.jenkins.public_ip
      timeout     = "1m"
      private_key = file("resources/${var.jenkins_key_name}.pem")
    }
    inline = [
      "chmod +x /home/ec2-user/jenkins*.sh",
      "/home/ec2-user/jenkins_startup.sh ${var.jenkins_user_name} ${var.jenkins_user_password}"
    ]
  }
}