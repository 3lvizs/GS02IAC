#Load Balancer

resource "azurerm_public_ip" "publiciplb" {
  name                = "publiciplb"
  location            = var.rglocation
  resource_group_name = var.rgname
  allocation_method   = "Static"
}

resource "azurerm_lb" "lbvnet" {
  name                = "lbazr"
  location            = var.rglocation
  resource_group_name = var.rgname

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.publiciplb.id
  }
}


#vm1 publica

resource "azurerm_public_ip" "vm01_pip_public" {
    name                = "vm01-pip-public"
    location            = var.rglocation
    resource_group_name = var.rgname
    allocation_method   = "Static"
    domain_name_label   = "vm01-pip-public"
}

resource "azurerm_network_interface" "vm01_nic_public" {
    name                = "vm01-nic-public"
    location            = var.rglocation
    resource_group_name = var.rgname
    ip_configuration {
        name                          = "vm01-ipconfig-public"
        subnet_id                     = var.snvnetpub1a
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.vm01_pip_public.id
    }
}

resource "azurerm_virtual_machine" "vm01_public" {
    name                          = "vm01-public"
    location            = var.rglocation
    resource_group_name = var.rgname
    network_interface_ids         = [azurerm_network_interface.vm01_nic_public.id]
    vm_size                       = "Standard_D2s_v3"
    delete_os_disk_on_termination = true
    storage_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }
    storage_os_disk {
        name              = "vm01-os-disk-public"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    os_profile {
    computer_name  = "vm04-public"
    admin_username = "azureuser"
    admin_password = "Password1234!"
    custom_data    = <<-EOF
        #!/bin/bash

        # Atualiza os pacotes e instala o Apache e o PHP
        apt-get update
        apt-get install -y apache2 php

        # Cria um arquivo PHP para mostrar informações da máquina
        cat <<EOF > /var/www/html/info.php
        <?php
        // Exibe o endereço IP da máquina
        echo "Endereço IP: " . \$_SERVER['SERVER_ADDR'] . "<br>";

        // Exibe o nome do host
        echo "Nome do Host: " . gethostname() . "<br>";

        // Exibe informações do sistema operacional
        echo "Sistema Operacional: " . php_uname() . "<br>";

        // Exibe a versão do PHP
        echo "Versão do PHP: " . phpversion() . "<br>";

        // Mostra todas as informações do PHP
        phpinfo();
        ?>
        
        # Reinicia o Apache para aplicar as mudanças
        systemctl restart apache2
    EOF
}

os_profile_linux_config {
    disable_password_authentication = false
}

}

#vm3 publica

resource "azurerm_public_ip" "vm03_pip_public" {
    name                = "vm03-pip-public"
    location            = var.rglocation
    resource_group_name = var.rgname
    allocation_method   = "Static"
    domain_name_label   = "vm03-pip-public"
}

resource "azurerm_network_interface" "vm03_nic_public" {
    name                = "vm03-nic-public"
    location            = var.rglocation
    resource_group_name = var.rgname
    ip_configuration {
        name                          = "vm03-ipconfig-public"
        subnet_id                     = var.snvnetpub1b
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.vm03_pip_public.id
    }
}

resource "azurerm_virtual_machine" "vm03_public" {
    name                          = "vm03-public"
    location            = var.rglocation
    resource_group_name = var.rgname
    network_interface_ids         = [azurerm_network_interface.vm03_nic_public.id]
    vm_size                       = "Standard_D2s_v3"
    delete_os_disk_on_termination = true
    storage_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }
    storage_os_disk {
        name              = "vm03-os-disk-public"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    os_profile {
    computer_name  = "vm04-public"
    admin_username = "azureuser"
    admin_password = "Password1234!"
    custom_data    = <<-EOF
        #!/bin/bash

        # Atualiza os pacotes e instala o Apache e o PHP
        apt-get update
        apt-get install -y apache2 php

        # Cria um arquivo PHP para mostrar informações da máquina
        cat <<EOF > /var/www/html/info.php
        <?php
        // Exibe o endereço IP da máquina
        echo "Endereço IP: " . \$_SERVER['SERVER_ADDR'] . "<br>";

        // Exibe o nome do host
        echo "Nome do Host: " . gethostname() . "<br>";

        // Exibe informações do sistema operacional
        echo "Sistema Operacional: " . php_uname() . "<br>";

        // Exibe a versão do PHP
        echo "Versão do PHP: " . phpversion() . "<br>";

        // Mostra todas as informações do PHP
        phpinfo();
        ?>

        # Reinicia o Apache para aplicar as mudanças
        systemctl restart apache2
    EOF
}

os_profile_linux_config {
    disable_password_authentication = false
}

}





