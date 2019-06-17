#!/bin/bash

MAIN_FOLDER=`dirname $BASH_SOURCE`

. $MAIN_FOLDER/scripts/include.sh

#$MAIN_FOLDER/scripts/preReqInstaller.sh


clear

logMsg "Deploy and setup TixChange on K8s."

logMsg " *********"
logMsg "1. Make sure HOST_IP field is updated in config.ini"
logMsg "2. Make sure ssh key is setup among all your nodes to connect from this box without passwd"
logMsg "3. Make sure you have 40G available in the install folder ($INSTALLATION_FOLDER) volume"
logMsg "4. Make sure you run this as root"
logMsg " *********"

logMsg "Press y to proceed"

read INPUT

OPTION=""

if [ X$INPUT != "Xy" ]; then
  logMsg "Did not get \"y\". exiting ..." 
  exit
else 
  logMsg "Choose your option and press enter"
  Usage

  read OPTION
fi


case $OPTION in 
   p) 
     logMsg "Installing the Pre-Reqs. May take some time"
     $MAIN_FOLDER/scripts/preReqInstaller.sh
     ;;
   a) 
     logMsg " Installing all the components"

     emptyInstallFolders a

     echo "1pwd is $PWD"
     cd $INSTALL_SCRIPT_FOLDER
     $MAIN_FOLDER/scripts/preReqInstaller.sh
	
     echo "2pwd is $PWD"
     cd $INSTALL_SCRIPT_FOLDER
     #$MAIN_FOLDER/scripts/K8sInstaller.sh	

     echo "3pwd is $PWD"
     cd $INSTALL_SCRIPT_FOLDER
     cleanInstallHelmClient

     echo "4pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER
     installUMA

     echo "5pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER
     installTixChangeHelm

     echo "6pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER
     installAndRunJmeter 
     ;;
   k) 
     emptyInstallFolder -k

     logMsg " Installing just the K8s components"
     $MAIN_FOLDER/scripts/K8sInstaller.sh	
     ;;
   u) 
     emptyInstallFolder -u

     logMsg " Installing just the UMA components"
     $MAIN_FOLDER/scripts/umaInstaller.sh
     ;;
   t) 
     emptyInstallFolder -t

     logMsg " Installing just the TixChange components"
     $MAIN_FOLDER/scripts/tixChangeInstaller.sh
     ;;
   j) 
     emptyInstallFolder -j

     logMsg " Installing just the Jmeter components"
     $MAIN_FOLDER/scripts/jmeterInstaller.sh
     ;;
   c) 
     logMsg "Clean All. Are you sure ??" 
     logMsg "Press Enter to continue or Ctrl-C"
     
     read INPUT
    
     cleanUp 
     ;;
   *) 
     logMsg "Not a valid option"
     Usage
     ;;     
esac

