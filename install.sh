#!/bin/bash
echo "Setting up the local domain dream16.local..."
sudo -s 'echo "192.168.33.19 dream16.local" >> /etc/hosts'

echo "Grabbing the latest code from Evada..."

read -p "Evada Code Email: " uname
stty -echo
read -p "Evada Code Password: " passw; echo
stty echo

echo "Thanks, we're attempting to authenticate and install the website..."

vagrant ssh -c "sudo su - www-data -c 'cd /var/www && \
  ssh-keyscan code.private.evada.co.uk >> ~/.ssh/known_hosts && \
  echo -e \"machine code.private.evada.co.uk\nlogin ${uname}\npassword ${passw}\" >> ~/.netrc && \
  git clone http://code.private.evada.co.uk/rsc-dream/Website.git html' && \
  mysql -u root -proot -e 'CREATE DATABASE wordpress;' && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_commentmeta.sql && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_comments.sql && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_links.sql && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_options.sql && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_postmeta.sql && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_posts.sql && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_revisr.sql && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_term_relationships.sql && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_term_taxonomy.sql && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_terms.sql && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_usermeta.sql && \
  mysql -u root -proot wordpress < /var/www/html/wp-content/uploads/revisr-backups/revisr_wp_users.sql"
  # git clone git@code.private.evada.co.uk:rsc-dream/Website.git dream'"

cp ./website/wp-config-sample.php ./website/wp-config.php
perl -pi -e 's/database_name_here/wordpress/g' ./website/wp-config.php
perl -pi -e 's/username_here/root/g' ./website/wp-config.php
perl -pi -e 's/password_here/root/g' ./website/wp-config.php
echo -e "define('WP_HOME','http://dream16.local');\ndefine('WP_SITEURL','http://dream16.local');" >> ./website/wp-config.php

# echo -e \"Host code.private.evada.co.uk\n\tStrictHostKeyChecking no\n\" >> ~/.ssh/config && \
echo "WordPress configured."
open http://dream16.local
