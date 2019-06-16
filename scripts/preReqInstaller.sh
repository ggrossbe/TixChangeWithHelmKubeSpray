#!/bin/bash

SCRIPTS_FOLDER=`dirname $BASH_SOURCE`
. $SCRIPTS_FOLDER/include.sh


for HOST in $HOST_IPS;
do 
   logMsg "**** running yum update -y on host $HOST"
   
   ssh root@$HOST "yum update -y"

   logMsg "**** disabling firewall, SELinux off etc"
   ssh root@$HOST "systemctl stop firewalld"
   ssh root@$HOST "systemctl disable firewalld"

   ssh root@$HOST "setenforce 0"
   ssh root@$HOST "sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config"

   ssh root@$HOST "swapoff -a"
   ssh root@$HOST "systemctl daemon-reload"
   ssh root@$HOST "systemctl restart kubelet"
   
done

   yum -y --enablerepo=extras install epel-release
   export LC_ALL=C

   yum install -y python-pip python36 iproute wget nfs-utils

   yum install python36-setuptools -y

   easy_install-3.6 pip

   export LC_ALL=C

