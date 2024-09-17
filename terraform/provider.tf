terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}



# main.tf

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # Ensure kubeconfig is correctly set
  }
}
