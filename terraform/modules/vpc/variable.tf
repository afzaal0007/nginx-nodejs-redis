variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs."
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones."
  type        = list(string)
}

variable "rt_cidr_block" {
  description = "The CIDR block for the route table."
  type        = string
}