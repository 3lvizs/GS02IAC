resource "azurerm_resource_group" "rg" {
    name     = "rggs02"
    location = "eastus"
}

resource "azurerm_virtual_network" "vnet" {
    name                = "vnet"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "snvnetpub1a" {
    name                 = "snvnetpub1a"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "snvnetpub1b" {
    name                 = "snvnetpub1b"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "nsgvnet" {
    name                = "nsgvnet"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    security_rule {
        name                       = "AllowInternetSshInbound"
        priority                   = 1011
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
    }
    security_rule {
        name                       = "AllowHttpInbound"
        priority                   = 1012
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
    }
}

resource "azurerm_subnet_network_security_group_association" "nsgsnvnetpub1a" {
    subnet_id                 = azurerm_subnet.snvnetpub1a.id
    network_security_group_id = azurerm_network_security_group.nsgvnet.id
}

resource "azurerm_subnet_network_security_group_association" "nsgsnvnetpub1b" {
    subnet_id                 = azurerm_subnet.snvnetpub1b.id
    network_security_group_id = azurerm_network_security_group.nsgvnet.id
}
