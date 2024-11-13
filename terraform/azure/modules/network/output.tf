output "rgname" {
 value = azurerm_resource_group.rg.name
}

output "rglocation" {
 value = azurerm_resource_group.rg.location
}

output "vnet" {
 value = azurerm_virtual_network.vnet.id
}

output "snvnetpub1a" {
 value = azurerm_subnet.snvnetpub1a.id
}

output "snvnetpub1b" {
 value = azurerm_subnet.snvnetpub1b.id
}



