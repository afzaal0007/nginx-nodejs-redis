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

provider "kubernetes" {
  # Kubernetes provider configuration
  config_path = "~/.kube/config" # Path to your kubeconfig file
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}