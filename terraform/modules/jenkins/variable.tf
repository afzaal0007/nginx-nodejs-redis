variable "ami" {

  type    = string
  default = "ami-0e53db6fd757e38c7"

}

variable "jenkins_name" {
  description = "The name of the Jenkins server."
  type        = string
  default     = "jenkins"
}

variable "jenkins_ami_id" {
  description = "AMI ID for the Jenkins server."
  type        = string
  default     = "ami-0e53db6fd757e38c7"
}

variable "instance_type" {
  description = "EC2 instance type for Jenkins."
  type        = string
  default     = "t2.micro"
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for the Jenkins server."
  type        = string
  default     = "EKS-Key-PAIR"
}

# variable "vpc_id" {
#   description = "The VPC ID where the Jenkins server will be deployed."
#   type        = string
# }

variable "subnet_id" {
  description = "The subnet ID where the Jenkins server will be deployed."
  type        = string
  default     = "10.0.1.0/24"
}


# modules/jenkins/variables.tf

variable "vpc_id" {
  description = "The ID of the VPC where the Jenkins server will be deployed."
  type        = string
}

// region = ap-south-1

variable "region" {
  description = "The AWS region where the Jenkins server will be deployed."
  type        = string
}


variable "cluster_name" {
  description = "The ID of the EKS cluster where the Jenkins server will be deployed."
  type        = string
}