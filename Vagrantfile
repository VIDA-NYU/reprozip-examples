# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
    config.vm.box = "vida-nyu/ubuntu-16.04-upstart"

    config.vm.provider "virtualbox" do |vb|
        vb.name = "reprozip-examples"
        # vb.gui = true
    end

    config.vm.network "forwarded_port", guest: 8000, host: 8000
    config.vm.synced_folder ".", "/home/vagrant/reprozip-examples"

    config.vm.provision "shell", path: "install.sh", privileged: false
end
