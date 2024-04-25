variable "resource_group_location" {
    type = string
    default = "eastus"
    description = "Location of the resource group."
}

variable "username" {
    type = string
    description = "The username for the local account that will be created on the new VM."
    default = "adminuser"
}

variable "ssh_public_key" {
    default = "~/.ssh/terraform-key.pub"
}
