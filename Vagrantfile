# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/contrib-jessie64"

  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y curl apt-transport-https ca-certificates software-properties-common

    curl -fsSL https://yum.dockerproject.org/gpg | apt-key add -
    add-apt-repository "deb https://apt.dockerproject.org/repo/ debian-$(lsb_release -cs) main"

    apt-get update
    apt-get install -y docker-engine python3-pip

    pip3 install docker-compose

    echo 'cd /vagrant' >> /home/vagrant/.bashrc
  SHELL
end
