#!/bin/bash


MAIN_FOLDER=`dirname $BASH_SOURCE`

. $MAIN_FOLDER/scripts/include.sh

$MAIN_FOLDER/scripts/preReqInstaller.sh


clear

logData "Deploy and setup TixChange on K8s."

logData " *********"
logData "1. Make sure HOST_IP field is updated in config.ini and yes it is IP not host name"
logData "2. Make sure ssh key is setup among all your nodes to connect from this box without passwd"
logData "3. Make sure you have 40G available in /opt/"
logData "4. Make sure you run this as root"
logData "5. Script assumes the install folder is $INSTALL_FOLDER"
logData " *********"

logData "Enter to proceed. Ctrl-C to terminate"

read input


case $1 in 
   -p) 
     logData "Installing the Pre-Reqs. May take some time"
     $BASEDIR/scripts/preReqInstaller.sh
     ;;
   -a) 
     logData " Installing all the components"
     $BASEDIR/scripts/preReqInstaller.sh
     $BASEDIR/scripts/K8sInstaller.sh	
     $BASEDIR/scripts/umaInstaller.sh
     $BASEDIR/scripts/tixChangeInstaller.sh
     $BASEDIR/scripts/jmeterInstaller.sh
     ;;
   -k) 
     logData " Installing just the K8s components"
     $BASEDIR/scripts/K8sInstaller.sh	
     ;;
   -u) 
     logData " Installing just the UMA components"
     $BASEDIR/scripts/umaInstaller.sh
     ;;
   -t) 
     logData " Installing just the TixChange components"
     $BASEDIR/scripts/tixChangeInstaller.sh
     ;;
   -j) 
     logData " Installing just the Jmeter components"
     $BASEDIR/scripts/jmeterInstaller.sh
     ;;
   *) 
     logData "Not a valid option"
     Usage
     ;;     
esac

exit

clear

logData "Deploy and setup TixChange on K8s." 

logData " *********"
logData "1. Make sure HOST_IP field is updated in config.ini and yes it is IP not host name"
logData "2. Make sure ssh key is setup among all your nodes to connect from this box without passwd"
logData "3. Make sure you have 40G available in /opt/"
logData "4. Make sure you run this as root"
logData "5. Script assumes the install folder is $INSTALL_FOLDER"
logData " *********"

logData "Enter to proceed. Ctrl-C to terminate"

read input




logData " disabling firewall, SELinux off etc"
systemctl stop firewalld
systemctl disable firewalld

setenforce 0
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config

swapoff -a
systemctl daemon-reload
systemctl restart kubelet

logData "Getting KubeSpray "

#wget https://github.com/kubernetes-sigs/kubespray/archive/master.zip
wget https://github.com/kubernetes-sigs/kubespray/archive/release-2.10.zip


rm -rf $INSTALL_FOLDER
mkdir -p $INSTALL_FOLDER
cp -rf ../ $INSTALL_FOLDER
cd $INSTALL_FOLDER

ESCAPE_INSTALL_FOLDER=$(echo "$INSTALL_FOLDER" | sed 's/\//\\\//g')
sed 's/DOCKER_STORAGE_FOLDER/'$ESCAPE_INSTALL_FOLDER\\/DockerStorage'/' all.yml

#unzip master.zip &&  mv kubespray-master kubespray && cd kubespray
unzip release-2.10.zip &&  mv kubespray-release-2.10 kubespray && cd kubespray


# needed for pip
yum --enablerepo=extras install epel-release

export LC_ALL=C

yum install -y python-pip python36 iproute wget nfs-utils

logData "Installing the requirements for Kubespray"
sleep 1

export LC_ALL=C

which pip
pip -V

sleep 2

pip install -r requirements.txt

sleep 1
rm -fr inventory/mycluster
cp -r inventory/local/ inventory/mycluster && rm -f inventory/mycluster/hosts.ini


#declare -a IPS=(10.74.240.100 10.74.240.101 10.74.240.102)
declare -a IPS=($HOST_IPS)
CONFIG_FILE=inventory/mycluster/hosts.yml /usr/bin/python3.6m contrib/inventory_builder/inventory.py ${IPS[@]}

cp -f ../automation/*.yml inventory/mycluster/group_vars/
cp -f ../automation/ansible.cfg .

### KubeSpray install

ansible-playbook -b --become-user=root -v -i  inventory/mycluster/hosts.yml --user=root cluster.yml --flush-cache


kubectl label node node3 node-role.kubernetes.io/worker=worker

logData "*****"
logData "K8s install is done... see the output of kubectl get nodes - if this doesnt look right pls Ctrl-C and debug"


kubectl get nodes

read INPUT

### Helm Install


### UMA install

## TixCange Helm Install


### Jmeter Install

#wget https://www-eu.apache.org/dist//jmeter/binaries/apache-jmeter-5.1.1.tgz
#tar xvf apache-jmeter-5.1.1.tgz

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04-0.el7_6.x86_64/jre
export JMETER_HOME=/opt/ca/jmeter/apache-jmeter-5.1.1
