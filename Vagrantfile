$script = <<SCRIPT

# update ubuntu (security etc.)
apt-get update

# nodejs
sudo apt-get -y install g++ git git-core nodejs npm

# use https://github.com/visionmedia/n to get latest node+npm
sudo npm install n -g
sudo n stable
node -v

# Install meteor:
curl https://install.meteor.com | /bin/sh

# Install meteorite
sudo -H npm install -g meteorite

## install mongodb ##
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-org

SCRIPT


Vagrant.configure("2") do |config|

  # config.vm.box = "base"
  config.vm.box = "ubuntu-nodejs-server"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.provision :shell, :inline => $script

end
