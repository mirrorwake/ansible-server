#!/bin/bash
sudo apt install -y wget curl vi openssl git ansible
git clone [PUT REPO HERE]
cd [REPO]
ansible-playbook -i inventory.ini add-k8s-repo.yml
ansible-playbook -i inventory.ini bootstrap-jumpbox.yml
ansible-playbook -i inventory.ini bootstrap-control-planes.yml
ansible-playbook -i inventory.ini bootstrap-workers.yml
ansible-playbook -i inventory.ini
ansible-playbook -i inventory.ini
ansible-playbook -i inventory.ini
