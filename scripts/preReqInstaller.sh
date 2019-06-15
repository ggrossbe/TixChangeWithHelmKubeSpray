#!/bin/bash

SCRIPTS_FOLDER=`dirname $BASH_SOURCE`
. $SCRIPTS_FOLDER/include.sh


for HOST in $HOST_IPS;
do 
   logMsg "running yum update -y in all the packages "
   
   ssh root@$HOST "yum update -y"

   logMsg " disabling firewall, SELinux off etc"
   systemctl stop firewalld
   systemctl disable firewalld

   setenforce 0
   sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config

   swapoff -a
   systemctl daemon-reload
   systemctl restart kubelet
   
   #rm -rf $INSTALL_FOLDER
   mkdir -p $INSTALL_FOLDER
   cp -rf $SCRIPTS_FOLDER/../ $INSTALL_FOLDER
   cd $INSTALL_FOLDER

done
