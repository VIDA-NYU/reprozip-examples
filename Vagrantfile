# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
    config.vm.provider "virtualbox" do |v|
        #v.gui = true
        v.memory = 2048
    end

    # Build VM from this repository, by mounting files and running install.sh
    config.vm.define "dev", autostart: false do |m|
        m.vm.box = "remram/ubuntu-1604-amd64-x"

        m.vm.network "forwarded_port", guest: 8000, host: 8001
        m.vm.synced_folder ".", "/home/vagrant/reprozip-examples"

        m.vm.provision "shell", path: "install.sh", privileged: false
    end

    # Download pre-built image from OSF.io and run that
    config.vm.define "prebuilt", autostart: false do |m|
        m.vm.box = "remram/ubuntu-1604-amd64-x"
        m.vm.box_url = "https://files.osf.io/v1/resources/8uxpv/providers/osfstorage/57ed7933b83f6901ee94b1dd?direct=true&action=download"

        m.vm.network "forwarded_port", guest: 8000, host: 8000
    end
end
