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
   a) 

     stopDeletelAll

     cd $INSTALL_SCRIPT_FOLDER
     $MAIN_FOLDER/scripts/preReqInstaller.sh
	
     cd $INSTALL_SCRIPT_FOLDER
     $MAIN_FOLDER/scripts/K8sInstaller.sh	


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

     logMsg ""
     logMsg ""
     logMsg ""
     logMsg "************************"
     logMsg ""
     logMsg ""
     logMsg ""
     logMsg "1. Update your laptop (where you are running the browser) /etc/hosts with following IP"
     logMsg "    $TIX_IP $UC1_URL"
     logMsg "    $TIX_IP $UC2_URL"
     logMsg "  *** NOTE: if you see urls and no IPs above then update /etc/hosts manually ***"
     logMsg "2. This is a Blue/Green deployment - with UC1 running on $UC1_URL/jtixchange_web/shop/index.shtml and UC2 $UC2_URL/jtixchange_web/shop/index.shtml"
     logMsg "3. Selenium is generating load for both. Access TixChange from browser at $UC1_URL/jtixchange_web/shop/index.shtml"
     logMsg ""
     logMsg ""
     logMsg "************************"
     ;;

   r)

     stopDeleteAppComponents

     logMsg " Now Re-installing just the Application components (Tixchange, UMA, Selenium) "

     sleep 10
     #echo "pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
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
     ;;
   u) 

     stopDeleteUMA

     logMsg " Installing just the UMA components"
     installUMA
     ;;
   t) 

     stopDeleteTixChange

     logMsg " Installing just the TixChange components + Selenium"
     installTixChangeHelm
    
     sleep 10 
     logMsg " re-installaing Selenium"
     stopDeleteSelenium
     sleep 5
     installAndRunSelenium
     ;;
   s) 
     stopDeleteSelenium

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
    
     stopDeletelAll
     ;;
   *) 
     logMsg "Not a valid option"
     Usage
     ;;     
esac

