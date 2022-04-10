# Azure  terraform providers

provider "azurerm" {
  version = "3.0"
  subscription_id = var.subscriptionID
  features {
    
  }
}

# Create NSG
resource "azurerm_network_security_group" "cloudskillsSG" {
  name                = "cloudskillsSG"
  location            = var.location
  resource_group_name = var.resourceGroupName
}

# Create network security Rule  - port 80
resource "azurerm_network_security_rule" "port80" {
  name                        = "allow80"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "80"
  resource_group_name         = azurerm_network_security_group.cloudskillsSG.resource_group_name
  network_security_group_name = azurerm_network_security_group.cloudskillsSG.name
}

# Create network security Rule - PORT 443
resource "azurerm_network_security_rule" "port443" {
  name                        = "allow443"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 443
  source_address_prefix       = "*"
  destination_address_prefix  = "80"
  resource_group_name         = azurerm_network_security_group.cloudskillsSG.resource_group_name
  network_security_group_name = azurerm_network_security_group.cloudskillsSG.name
}


# Create vNet 
resource "azurerm_virtual_network" "cloudskills-vnet" {
  name                = "cloudskills-vnet"
  location            = var.location
  resource_group_name = var.resourceGroupName
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    "env" = "staging"
  }

}


# Create SubNet
resource "azurerm_subnet" "cloudskills-subnet" {
  name                 = "test-subnet"
  resource_group_name  = azurerm_network_security_group.cloudskillsSG.name
  virtual_network_name = azurerm_virtual_network.cloudskills-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

 # Create Azure Public IP
resource "azurerm_public_ip" "cloudskills-public_ip" {
  name                = "cloudskills-public-ip"
  resource_group_name = var.resourceGroupName
  location            = var.location
  allocation_method   = "Static"
  ip_version = "IPv4"

  tags = {
    environment = "Production"
  }
}

