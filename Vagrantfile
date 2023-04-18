# -*- mode: ruby -*-
# vim: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "generic/centos8"
    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
    end
    config.vm.define "otus" do |otus|
        otus.vm.network "private_network", ip: "192.168.57.10",
        virtualbox__intnet: "vboxnet1"
        otus.vm.hostname = "otus"
        otus.vm.provision :shell, :inline => "sed -i 's/enforcing/disabled/g' /etc/selinux/config"
        otus.vm.provision :shell, :inline => "yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y"
        otus.vm.provision :shell, :path => "watchlog.sh"
        otus.vm.provision :shell, :path => "spawn_fcgi.sh"
        otus.vm.provision :shell, :path => "multi_httpd.sh"
    end
end
