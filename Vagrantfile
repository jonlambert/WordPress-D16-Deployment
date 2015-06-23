# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.33.19"

  config.vm.provision "shell", path: "script.sh"
  
  config.vm.synced_folder "website", "/var/www/html", :type=> "nfs"
  config.bindfs.bind_folder "/var/www/html", "/var/www/html", {perms: "u=rwx:g=wrx:o=rwx"}
end
