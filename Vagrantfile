# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
    config.vm.box = "remram/ubuntu-1604-amd64-x"

    config.vm.provider "virtualbox" do |v|
        #v.gui = true
        v.memory = 2048
    end

    config.vm.network "forwarded_port", guest: 8000, host: 8000
    config.vm.synced_folder ".", "/home/vagrant/reprozip-examples"

    config.vm.provision "shell", path: "install.sh", privileged: false
end
