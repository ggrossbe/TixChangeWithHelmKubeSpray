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


