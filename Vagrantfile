# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  config.vm.box = "ol76"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
      # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end

  # config.vm.provision "shell" do |db|
  #   db.path = "db-tier/mysql_setup.sh"
  # end

  config.vm.provision "shell" do |wp|
    wp.path = "vmsimgs/wordpress/provision.sh"
  end

end
