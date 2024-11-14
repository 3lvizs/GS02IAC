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
EOF

# Reinicia o Apache para aplicar as mudanças
systemctl restart apache2
