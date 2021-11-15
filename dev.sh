#/bin/bash

if [ "$1" == "destroy" ]; then
	vagrant destroy -f
	exit 0
elif [ "$1" == "halt" ]; then
	vagrant halt
	exit 0
fi

if [ ! -f Vagrantfile ]; then
	curl -s -o 'Vagrantfile' https://raw.githubusercontent.com/andy191x/hardhat-vagrant/main/Vagrantfile
	curl -s -o 'vagrant-provision.sh' https://raw.githubusercontent.com/andy191x/hardhat-vagrant/main/vagrant-provision.sh
fi

vagrant up && vagrant ssh -c 'sudo -i'

exit 0
