# Azrue Terraform Providers

provider "azurerm" {
  version = "3.0"
  subscription_id = var.subscriptionID
  features {
    
  }
}


resource "azurerm_resource_group" "CloudSkillsRG2022" {
  name = "CloudSkillsRG2022"
  location = var.location
  
}

# Create Linux Virtual Machine
resource "azurerm_virtual_machine" "cloudskillsdevVM" {
    name = "cloudskillsvm"
    location = azurerm_resource_group.CloudSkillsRG2022.location
    resource_group_name = azurerm_resource_group.CloudSkillsRG2022.name
    network_interface_ids = [ "${var.network_interface_id}" ]
    vm_size = "Standard_D1_v2"

    storage_image_reference {
          publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
    }

    storage_os_disk {
      name = "disk1"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }

    os_profile {
      computer_name = "cloudskillsdev01"
      admin_password = "azureuser"
      admin_username = "Pa$$Word1"
      
          }

          os_profile_linux_config {
            disable_password_authentication = false
          }
}



