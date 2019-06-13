#!/bin/bash
. ./config.ini

LOG " disabling firewall, SELinux off etc"
systemctl stop firewalld
systemctl disable firewalld

setenforce 0
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config

swapoff -a
systemctl daemon-reload
systemctl restart kubelet

rm -rf $INSTALL_FOLDER
mkdir -p $INSTALL_FOLDER
cp -rf ../ $INSTALL_FOLDER
cd $INSTALL_FOLDER

