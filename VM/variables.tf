variable "subscriptionID" {
    type = string
    description = "this is for our resource group"
}

variable "resourceGroupName" {
  type = string
  description = "this is the name of our resource group"
}

variable "location" {
  type = string
  description = "location of our resource group"
}

variable "network_interface_id" {
  type = string
}