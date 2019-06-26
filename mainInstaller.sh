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
     ### NOT IMPLETED###

     logMsg "Installing the Pre-Reqs. May take some time"
     $MAIN_FOLDER/scripts/preReqInstaller.sh
     ;;
   a) 
     logMsg " Installing all the components"

     stopCleanupServices a

     cd $INSTALL_SCRIPT_FOLDER
     $MAIN_FOLDER/scripts/preReqInstaller.sh
	
     cd $INSTALL_SCRIPT_FOLDER
     $MAIN_FOLDER/scripts/K8sInstaller.sh	

     sleep 5 

     #echo "3pwd is $PWD"
     #cd $INSTALL_SCRIPT_FOLDER
     #cleanInstallHelmClient

     sleep 10
     #echo "5pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER
     installTixChangeHelm

     sleep 10
     #echo "4pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER
     installUMA

     logMsg "Waiting few seconds for app to startup"
     sleep 15
     #echo "6pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER
     installAndRunSelenium

     logMsg "******"
     logMsg ""
     logMsg ""
     logMsg ""
     logMsg "*** Update your /etc/hosts with following IP"
     logMsg "$TIX_IP $UC1_URL"
     logMsg "$TIX_IP $UC2_URL"
     logMsg "This is a Blue/Green deployment - with UC1 running on $UC1_URL/jtixchange_web/shop/index.shtml and UC2 $UC2_URL/jtixchange_web/shop/index.shtml"
     logMsg "*** Selenium is generating load for both. Access TixChange from browser at $UC1_URL/jtixchange_web/shop/index.shtml"
     logMsg ""
     logMsg ""
     logMsg "******"
     ;;

   k) 
     ### NOT IMPLETED###

     stopCleanupServices a

     cd $INSTALL_SCRIPT_FOLDER
     $MAIN_FOLDER/scripts/preReqInstaller.sh

     read input
     cd $INSTALL_SCRIPT_FOLDER
     $MAIN_FOLDER/scripts/K8sInstaller.sh
     ;;
   u) 
     ### NOT IMPLETED###

     stopCleanupServices u

     logMsg " Installing just the UMA components"
     installUMA
     ;;
   t) 
     stopCleanupServices t

     logMsg " Installing just the TixChange components"
     installTixChangeHelm
     ;;
   s) 
     stopCleanupServices s

     logMsg " Installing just the selenium components"
     installAndRunSelenium
     ;;
   j) 
     ### DEPRECATED in favor if Selenium

     stopCleanupServices j

     logMsg " Installing just the Jmeter components"
     installAndRunJmeter
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

