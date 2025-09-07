#!/bin/bash

# Script Auto Install All-in-One untuk Developer


echo -e "\033[1;36m"
echo "╔══════════════════════════════════════════════════╗"
echo "║           AUTO INSTALL DEVELOPER TOOLS           ║"
echo "║      PHP • APACHE • MYSQL • phpMyAdmin           ║"
echo "║         VS Code • Git • Composer                 ║"
echo "╚══════════════════════════════════════════════════╝"
echo -e "\033[0m"

sleep 2

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "\033[1;31mPlease run as root (use sudo)\033[0m"
    exit 1
fi

# Update system
echo -e "\033[1;33m[1/9] Updating system packages...\033[0m"
apt update && apt upgrade -y

# Install Apache
echo -e "\033[1;33m[2/9] Installing Apache Web Server...\033[0m"
apt install -y apache2
systemctl enable apache2
systemctl start apache2

# Install MySQL
echo -e "\033[1;33m[3/9] Installing MySQL Database Server...\033[0m"
apt install -y mysql-server
systemctl enable mysql
systemctl start mysql

# Secure MySQL installation
echo -e "\033[1;33mSecuring MySQL installation...\033[0m"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';"
mysql -e "DELETE FROM mysql.user WHERE User='';"
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "FLUSH PRIVILEGES;"

# Install PHP and extensions
echo -e "\033[1;33m[4/9] Installing PHP and extensions...\033[0m"
apt install -y php libapache2-mod-php php-mysql php-cli php-curl php-gd php-mbstring php-xml php-zip php-json

# Install phpMyAdmin
echo -e "\033[1;33m[5/9] Installing phpMyAdmin...\033[0m"
apt install -y phpmyadmin

# Configure phpMyAdmin with Apache
echo 'Include /etc/phpmyadmin/apache.conf' >> /etc/apache2/apache2.conf
systemctl restart apache2

# Install Visual Studio Code
echo -e "\033[1;33m[6/9] Installing Visual Studio Code...\033[0m"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt update
apt install -y code

# Install Git
echo -e "\033[1;33m[7/9] Installing Git...\033[0m"
apt install -y git

# Install Composer
echo -e "\033[1;33m[8/9] Installing Composer...\033[0m"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

# Configure PHP
echo -e "\033[1;33m[9/9] Configuring PHP and finalizing...\033[0m"
sed -i 's/memory_limit = .*/memory_limit = 256M/' /etc/php/*/apache2/php.ini
sed -i 's/upload_max_filesize = .*/upload_max_filesize = 64M/' /etc/php/*/apache2/php.ini
sed -i 's/post_max_size = .*/post_max_size = 64M/' /etc/php/*/apache2/php.ini

# Create test PHP file
echo "<?php 
echo '<!DOCTYPE html><html><head><title>Installation Success</title><style>body{font-family:Arial,sans-serif;background:#f0f0f0;margin:0;padding:20px;}";
echo ".card{background:white;border-radius:10px;padding:20px;margin:20px auto;max-width:600px;box-shadow:0 4px 8px rgba(0,0,0,0.1);}";
echo "h1{color:#4CAF50;}ul{list-style-type:none;padding:0;}li{padding:8px;background:#f9f9f9;margin-bottom:5px;border-radius:5px;}";
echo ".success{color:#4CAF50;font-weight:bold;}</style></head><body>';";
echo "'<div class=\"card\"><h1>✅ Installation Successful!</h1><p>Your development environment is ready:</p><ul>';";
echo "'<li>Apache Web Server <span class=\"success\">✓</span></li>';";
echo "'<li>MySQL Database <span class=\"success\">✓</span></li>';";
echo "'<li>PHP <span class=\"success\">✓</span></li>';";
echo "'<li>phpMyAdmin <span class=\"success\">✓</span></li>';";
echo "'<li>VS Code <span class=\"success\">✓</span></li>';";
echo "'<li>Git <span class=\"success\">✓</span></li>';";
echo "'<li>Composer <span class=\"success\">✓</span></li>';";
echo "'</ul><p>You can now start developing your projects!</p>';";
echo "'<p><strong>MySQL Root Password:</strong> root</p>';";
echo "'<p><strong>phpMyAdmin:</strong> <a href=\"/phpmyadmin\">http://localhost/phpmyadmin</a></p>';";
echo "'</div></body></html>';"
?>" > /var/www/html/index.php

systemctl restart apache2

# Clean up
apt autoremove -y
rm -f packages.microsoft.gpg

# Display completion message
echo -e "\033[1;32m"
echo "╔══════════════════════════════════════════════════╗"
echo "║          INSTALLATION COMPLETED!                 ║"
echo "║                                                  ║"
echo "║   Your development environment is ready to use!  ║"
echo "╚══════════════════════════════════════════════════╝"
echo -e "\033[0m"

echo -e "\033[1;34m"
echo "Access your local server at: http://localhost"
echo "phpMyAdmin: http://localhost/phpmyadmin"
echo "MySQL username: root"
echo "MySQL password: root"
echo ""
echo "Installed tools:"
echo "- Apache Web Server"
echo "- MySQL Database"
echo "- PHP with extensions"
echo "- phpMyAdmin"
echo "- Visual Studio Code"
echo "- Git"
echo "- Composer"
echo -e "\033[0m"
