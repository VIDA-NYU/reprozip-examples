# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
	config.vm.box = "bento/ubuntu-15.04"
        
        config.vm.provider "virtualbox" do |vb|
            vb.name = "reprozip-examples"
            # vb.gui = true
        end

        config.vm.network "forwarded_port", guest: 8000, host: 8111

        config.vm.synced_folder ".", "/home/vagrant/reprozip-examples"

        config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

	config.vm.provision "shell", path: "install.sh"
end
