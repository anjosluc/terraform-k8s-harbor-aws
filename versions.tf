terraform {
  required_version = ">= 0.12.7"

  required_providers {
    helm = ">= 2.3.0"
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.59.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.2.0"
    }
    harbor = {
      source = "BESTSELLER/harbor"
      version = "3.7.1"
    }
    
  }
  
}