terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.98.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.44.0"
    }
  }
}

provider "azurerm" {
  features {}
}
provider "aws" {
  shared_config_files      = ["~/.aws/config"] # $HOME : linux , ~ : windows
  shared_credentials_files = ["~/.aws/credentials"]
}
