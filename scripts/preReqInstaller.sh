#!/bin/bash

SCRIPTS_FOLDER=`dirname $BASH_SOURCE`
. $SCRIPTS_FOLDER/include.sh

logData " disabling firewall, SELinux off etc"
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

