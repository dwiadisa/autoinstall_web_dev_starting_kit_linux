# Auto Install Developer Tools

This script automates the installation of a complete development environment on a Debian-based system (e.g., Ubuntu). It installs and configures essential tools for web development, including Apache, MySQL, PHP, phpMyAdmin, Visual Studio Code, Git, and Composer.

## Prerequisites

- A Debian-based Linux distribution (e.g., Ubuntu).
- Root or sudo privileges.
- Internet connection for downloading packages.

## Installation Instructions

1. **Download the Script**  
   Save the script as `install-dev-tools.sh` or download it from the repository.

2. **Make the Script Executable**  
   Run the following command to make the script executable:
   ```bash
   chmod +x install-dev-tools.sh
   ```

3. **Run the Script as Root**  
   Execute the script with sudo privileges:
   ```bash
   sudo ./install-dev-tools.sh
   ```

4. **Follow the On-Screen Instructions**  
   The script will:
   - Update system packages.
   - Install Apache, MySQL, PHP, phpMyAdmin, Visual Studio Code, Git, and Composer.
   - Configure MySQL with a default root password (`root`).
   - Set up PHP with optimized settings (e.g., memory limit, file upload size).
   - Create a test PHP page at `http://localhost`.

## Post-Installation

After the script completes, you can access the following:

- **Local Web Server**: `http://localhost`  
  Displays a confirmation page showing the installed tools.
- **phpMyAdmin**: `http://localhost/phpmyadmin`  
  Log in with:
  - Username: `root`
  - Password: `root`
- **MySQL**:
  - Username: `root`
  - Password: `root`
- **Installed Tools**:
  - Apache Web Server
  - MySQL Database
  - PHP (with extensions: mysql, cli, curl, gd, mbstring, xml, zip, json)
  - phpMyAdmin
  - Visual Studio Code
  - Git
  - Composer

## Usage

- **Start Developing**: Use Visual Studio Code to write code, Git for version control, and Composer for PHP dependency management.
- **Manage Database**: Access phpMyAdmin (`http://localhost/phpmyadmin`) to manage MySQL databases.
- **Test PHP Applications**: Place your PHP files in `/var/www/html` and access them via `http://localhost`.

## Troubleshooting

- **Apache Not Running**: Check status with `systemctl status apache2` and start it with `systemctl start apache2`.
- **MySQL Access Issues**: Ensure the root password is `root` or reset it using `mysql_secure_installation`.
- **phpMyAdmin Not Accessible**: Verify that `/etc/phpmyadmin/apache.conf` is included in `/etc/apache2/apache2.conf` and restart Apache (`systemctl restart apache2`).
- **VS Code Installation Fails**: Ensure an internet connection and check the Microsoft repository URL.

## Notes

- The script sets a default MySQL root password (`root`). Change it for security in production environments.
- PHP settings are configured with:
  - `memory_limit = 256M`
  - `upload_max_filesize = 64M`
  - `post_max_size = 64M`
- The test page (`/var/www/html/index.php`) confirms the setup.

## Credits

Created by: @YourChannelName
