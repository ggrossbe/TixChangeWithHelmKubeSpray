#!/bin/bash
SCRIPTS_FOLDER=`dirname $BASH_SOURCE`
. $SCRIPTS_FOLDER/include.sh

wget https://github.com/kubernetes-sigs/kubespray/archive/release-2.10.zip


ESCAPE_INSTALL_FOLDER=$(echo "$INSTALL_FOLDER" | sed 's/\//\\\//g')
sed 's/DOCKER_STORAGE_FOLDER/'$ESCAPE_INSTALL_FOLDER\\/DockerStorage'/' all.yml

rm -rf $INSTALL_FOLDER/$KUBESPRAY_FOLDER

#unzip master.zip &&  mv kubespray-master kubespray && cd kubespray
unzip release-2.10.zip &&  mv kubespray-release-2.10 $INSTALL_FOLDER/$KUBESPRAY_FOLDER 

cd $INSTALL_FOLDER/$KUBESPRAY_FOLDER

export LC_ALL=C

logMsg "Installing Kubespray pre-preq "

/usr/local/bin/pip install -r requirements.txt

sleep 2
rm -fr inventory/mycluster
cp -r inventory/local/ inventory/mycluster && rm -f inventory/mycluster/hosts.ini


export LC_ALL=C

which pip
pip -V

declare -a IPS=($HOST_IPS)
CONFIG_FILE=inventory/mycluster/hosts.yml /usr/bin/python3.6m contrib/inventory_builder/inventory.py ${IPS[@]}

cd -

cp -f $SCRIPTS_FOLDER/*.yml  $INSTALL_FOLDER/$KUBESPRAY_FOLDER/inventory/mycluster/group_vars/
cp -f $SCRIPTS_FOLDER/ansible.cfg  $INSTALL_FOLDER/$KUBESPRAY_FOLDER 

cd -

exit

### KubeSpray install

ansible-playbook -b --become-user=root -v -i  inventory/mycluster/hosts.yml --user=root cluster.yml --flush-cache

cd -

kubectl label node node3 node-role.kubernetes.io/worker=worker

logMsg "*****"
logMsg "K8s install is done... see the output of kubectl get nodes - if this doesnt look right pls Ctrl-C and debug"


kubectl get nodes

logMsg "ensure everything looks good"
