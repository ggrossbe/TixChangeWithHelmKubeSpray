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
     logMsg " Installing all the components"

     emptyInstallFolder -a

     $BASEDIR/scripts/preReqInstaller.sh
     $BASEDIR/scripts/K8sInstaller.sh	
     $BASEDIR/scripts/umaInstaller.sh
     $BASEDIR/scripts/tixChangeInstaller.sh
     $BASEDIR/scripts/jmeterInstaller.sh
     ;;
   -k) 
     emptyInstallFolder -k

     logMsg " Installing just the K8s components"
     $BASEDIR/scripts/K8sInstaller.sh	
     ;;
   -u) 
     emptyInstallFolder -u

     logMsg " Installing just the UMA components"
     $BASEDIR/scripts/umaInstaller.sh
     ;;
   -t) 
     emptyInstallFolder -t

     logMsg " Installing just the TixChange components"
     $BASEDIR/scripts/tixChangeInstaller.sh
     ;;
   -j) 
     emptyInstallFolder -j

     logMsg " Installing just the Jmeter components"
     $BASEDIR/scripts/jmeterInstaller.sh
     ;;
   *) 
     logMsg "Not a valid option"
     Usage
     ;;     
esac

