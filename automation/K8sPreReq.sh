#!/bin/bash

HOST_IPS="10.74.240.100 10.74.240.101 10.74.240.102"
HOST_LOGIN=root

systemctl stop firewalld
systemctl disable firewalld

setenforce 0
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config

swapoff -a
systemctl daemon-reload
systemctl restart kubelet

echo copy the key to the nodes

for HOST in $HOST_IPS 
do
  echo $HOST
  cat ~/.ssh/id_rsa.pub | ssh $HOST_LOGIN@$HOST "cat - >> ~/.ssh/authorized_keys"

done

exit
echo "Getting KubeSpray 2.6

wget https://github.com/kubernetes-incubator/kubespray/archive/v2.6.0.tar.gz
tar xf v2.6.0.tar.gz && cd kubespray-2.6.0

yum --enablerepo=extras install epel-release

yum install -y python-pip python36 iproute wget nfs-utils

cp -r inventory/local/ inventory/mycluster && rm -f inventory/mycluster/hosts.ini

#declare -a IPS=(10.74.240.100 10.74.240.101 10.74.240.102)
declare -a IPS=($HOST_IPS)
CONFIG_FILE=inventory/mycluster/hosts.ini /usr/bin/python3.6m contrib/inventory_builder/inventory.py ${IPS[@]}


ansible-playbook -b --become-user=root -v -i  inventory/mycluster/hosts.ini --user=root cluster.yml --flush-cache
