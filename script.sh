#!/bin/bash

# Provisioning script by Jon, email web@evada.co.uk for more information.
echo "Running Dream 2016 Provisioning Script. Press any key to continue..."

# Throw a default password in for the mysql install. 
# Seeing as this is a dev environment it doesn't matter. (Ports aren't even exposed)
sudo debconf-set-selections <<< 'mysql-server \
 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server \
 mysql-server/root_password_again password root'

apt-get update && \
apt-get install -y apache2 php5 libapache2-mod-php5 mysql-server-5.5 php5-mysql git

# Clear out the dream root dir
rm -rf /var/www/*

# Set the locale to stop Ubuntu whinging
sudo locale-gen en_GB.UTF-8

# Perms
sudo chown -R www-data:www-data /var/www

# Give www-data shell access (to download the site)
sudo chsh -s /bin/bash www-data

# Generate an SSH key, then print to console for installation in GitLab.
cat /dev/zero | sudo -u www-data ssh-keygen -q -N ""

echo "####################################################"
echo "#         ATTENTION DREAM 16 DEVELOPERS            #"
echo "#     The key below should be copied in it's       #"
echo "#     entirety for reference. This needs to be     #"
echo "#     added to your Evada GitLab account, under    #"
echo "#     Profile --> SSH Keys.                        #"
echo "#                                                  #"
echo "####################################################"
echo ""
echo ""
echo ""

cat /var/www/.ssh/id_rsa.pub

echo ""
echo ""
echo ""

# Final sweep
chown -R www-data:www-data /var/www

echo "---------------------------------------------------"
echo "                      Ta da!"
echo "---------------------------------------------------"
echo "The VM is configured. Now we need to install the codebase, and"
echo "perform database migrations to get this box up and running."
echo "Once the above key is safely copied into your Evada GitLab account,"
echo "(and you have the correct access to the Website repository), run"
echo "the install.sh script using the command 'bash install.sh'"