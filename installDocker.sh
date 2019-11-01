#!/bin/sh

set -x

exec > installDocker.log 2>&1

function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true 
  else
    false
  fi
}

package='wget'

isinstalled $package
if [[ $? -ne 0 ]] 
  then 
    sudo yum -y -q install $package	 		
fi


wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-19.03.4-3.el7.x86_64.rpm
wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-cli-19.03.4-3.el7.x86_64.rpm

sudo yum install -y -q containerd.io-1.2.6-3.3.el7.x86_64.rpm
sudo yum install -y -q docker-ce-cli-19.03.4-3.el7.x86_64.rpm
sudo yum install -y -q docker-ce-19.03.4-3.el7.x86_64.rpm

rm -f containerd.io-1.2.6-3.3.el7.x86_64.rpm docker-ce-cli-19.03.4-3.el7.x86_64.rpm docker-ce-19.03.4-3.el7.x86_64.rpm

sudo groupadd docker
sudo usermod -aG docker $USER

sudo systemctl enable docker
sudo systemctl start docker

echo "You need to re-logging to groupadd take effect !"
