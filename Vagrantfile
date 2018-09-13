# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
  $script = <<-SCRIPT
  cd /vagrant/provisioning   
  awk merge.awk resolv.conf /etc/resolv.conf 
  rsync -aP apt/archives/*.deb /var/cache/apt/archives/
  SCRIPT
  config.vm.provision "shell" :inline $script
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
  end
end