#!/bin/bash


MAIN_FOLDER=`dirname $BASH_SOURCE`


. $MAIN_FOLDER/scripts/include.sh

#$MAIN_FOLDER/scripts/preReqInstaller.sh


clear

cat $MAIN_FOLDER/version.txt

echo ""

sleep 2

rm -rf $INSTALLATION_FOLDER/logs/ 2> /dev/null
mkdir -p $INSTALLATION_FOLDER/logs 2> /dev/null

if [ X$1 != "Xt" ]; then

	logMsg "Deploy and setup TixChange on K8s."

	logMsg " *********"
	logMsg "1. Make sure HOST_IP field is updated in config.ini"
	logMsg "2. Make sure ssh key is setup among all your nodes to connect from this box without passwd"
	logMsg "3. Make sure you have 40G available in the install folder ($INSTALLATION_FOLDER) volume"
	logMsg "4. Make sure you run this as root"
        logMsg ""
	logMsg "####5. Delete SaaS, TixChange and AWS Mgmt Mod (if present), Delete EMEA_... and NA_... universes created by auto tix####"
	logMsg "6. Domain Specific OI service creation scripts are available in OIServiceScript folder. Run then separately for OI services"
        logMsg ""
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

else 
	OPTION=t
fi



 if [ X"$TIXCHANGE_MYSQL_RDS_HOSTNAME1" == "X" ]; then
    TIXCHANGE_MYSQL_RDS_HOSTNAME1=tixchange-mysql-conn-svc-1
    TIXCHANGE_MYSQL_RDS_HOSTNAME2=tixchange-mysql-conn-svc-2
 fi

case $OPTION in 
   a) 

    logMsg ""
    logMsg "Make sure OI_TOKEN in config.ini is most recent as it changes frequently *** Press ENTER to Proceed or Ctrl-C to exit"
    read 

     stopDeleteAll

     cd $INSTALL_SCRIPT_FOLDER
     $MAIN_FOLDER/scripts/preReqInstaller.sh
	
     cd $INSTALL_SCRIPT_FOLDER
     $MAIN_FOLDER/scripts/K8sInstaller.sh	


     sleep 10
     #echo "5pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER
     installTixChangeHelm

     sleep 10
     setupOpenTracingMonitoring

     sleep 30
     installBPA

     sleep 10
     installPromExporter

     sleep 10
     #echo "4pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER
     installUMA

     logMsg "Waiting few seconds for app to startup"
     sleep 15
     #echo "6pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER

     installAndConfigureSelenium
     sleep 10

     setupJenkins
     sleep 10


     configureEM em1
     configureEM em2

     setup 2
     setupAWSMonitoring

     setup 2
     setupASMMonitoring

     sleep 2
     createUpdateOIServices create

     sleep 2
     setupLogCollector

     runFinalSanityCheck


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
     logMsg "4. Log File is available under $INSTALLATION_FOLDER/logs"
     logMsg "5. You may have to configure Jenkins pipeline project with your own if not on Open Access - pls see auto tix wiki"
     logMsg "6. pls checkin $jenkins/performance-comparator.properties to your git hub MobileProvisioningService/caapm-performance-comparator/properties/ project"
     echo ""
     logMsg "7. add the following public key to your git hub account for jenkins pod to access "
           cat /root/tixchange_jenkins_ssh/id_rsa.pub
     logMsg "     - and run the following from tixchange master (after public key is added to git hub)"
     logMsg "         - curl -H \"Authorization: Basic YWRtaW46YWRtaW4=\" http://localhost:31080/job/Scheduler/build?token=JenkinsSchedulerJobTriggerToken"
     echo ""
     logMsg ""
     logMsg ""
     logMsg "************************"

     
     ;;

   r)

    logMsg ""
    logMsg "Make sure OI_TOKEN in config.ini is most recent as it changes frequently *** Press ENTER to Proceed or Ctrl-C to exit"
    read 

     stopDeleteAppComponents

     logMsg " Now Re-installing just the Application components (Tixchange, UMA, Selenium, EM Side - MM, Univ, Exp View) "

     sleep 10
     #echo "pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER
     installTixChangeHelm

     sleep 10
     setupOpenTracingMonitoring

     sleep 30
     installBPA

     sleep 10
     installPromExporter

     sleep 10
     #echo "4pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER
     installUMA

     logMsg "Waiting few seconds for app to startup"
     sleep 15
     #echo "6pwd is $PWD. $INSTALL_SCRIPT_FOLDER"
     cd $INSTALL_SCRIPT_FOLDER
     installAndConfigureSelenium

     sleep 5
     setupJenkins
     sleep 5

    
     sleep 2
     setupAWSMonitoring
     sleep 2
     setupASMMonitoring
    
     configureEM em1
     configureEM em2

     createUpdateOIServices create

     sleep 2
     setupLogCollector


     runFinalSanityCheck
     ;;
   u) 

     stopDeleteUMA

     logMsg " Installing just the UMA components"
     installUMA
     ;;
   t) 

    logMsg ""
    logMsg "Make sure OI_TOKEN in config.ini is most recent as it changes frequently"
    logMsg ""
    logMsg ""

     sleep 5

     stopDeleteTixChange

     removeOpenTracingMonitoring

     logMsg " Installing just the TixChange components + Selenium + EM side MM,ExpView, Univ"
     installTixChangeHelm

     sleep 10
     setupOpenTracingMonitoring
    
     sleep 30 
     logMsg "reinstall BPA "
     stopDeleteBPA 
     sleep 3
     installBPA

     logMsg " re-installaing Selenium"
     stopDeleteSelenium
     sleep 5
     installAndConfigureSelenium
     sleep 5
     
     configureEM em1
     configureEM em2

     createUpdateOIServices update

     stopDeleteUMA

     logMsg " Installing just the UMA components"
     installUMA

     runFinalSanityCheck
     ;;
   s) 
     stopDeleteSelenium

     logMsg " Installing just the selenium components"
     installAndConfigureSelenium
     
     runFinalSanityCheck
     ;;
   c) 
     logMsg "Clean All. Are you sure ??" 
     logMsg "Press Enter to continue or Ctrl-C"
     
     read INPUT
    
     stopDeleteAll
     ;;
   r_ut)
	logMsg "Stopping UMA and TixChange"
	stopUMA
        sleep 5
       stopTixChange

       logMsg ""
       logMsg ""
       logMsg "######## UMA and TixChange stopped - to start them MANUALLY say for demo run - Once manually started you will have to run \"s\" option to run Selenium"

       logMsg "TixChange Manual Deploy ---> cd /opt/ca/TixChangeK8sDemo/tixChangeHelm; helm install  . --name tixchange"
       logMsg "UMA Manual Deploy ---> cd /opt/ca/TixChangeK8sDemo/uma; helm install  . --name uma --namespace caaiops"
       logMsg ""
 
     ;;
   e)
     logMsg "Setup EM (Universes, Exp Views, mgmt mod). sleep 10sec before starting. Hope agents are already reporting"
     
     
     configureEM em1
     configureEM em2
     
     ;;
   b)
     logMsg "BPA is disabled for now"
     logMsg "installing and configuring HTTPD, BT Listener for BPA"
    
    
     stopDeleteBPA 
     sleep 3
     installBPA
    
     ;;
   o)
    logMsg ""
    logMsg "Make sure OI_TOKEN in config.ini is most recent as it changes frequently *** Press ENTER to Proceed or Ctrl-C to exit"
    read 

     logMsg "Creating OI service modelfor $INDUSTRY - if its already there then it may complaint and exit"

     createUpdateOIServices create

     ;;
   l)
     logMsg "setting up just log Collector"

     setupLogCollector
     ;;
   j)
     logMsg "setting up just Jenkins"
	
     /bin/cp -f /opt/ca/TixChangeK8sDemo/jenkins/jenkins_home/credentials.xml  ./jenkins/jenkins_home/

      removeJenkins
      sleep 5
      setupJenkins

      logMsg "If you are not on Open Access 1 tenant (OPEN-ACCESS) then you may have to configure Jenkins pipeline project to include your git repo. More details in Auto Tix Wiki"
      echo ""
      logMsg "add the following ssh public key to your git hub settings. More info in Auto Tix wiki"
           cat /root/tixchange_jenkins_ssh/id_rsa.pub
     logMsg "     - and run the following from tixchange master (after public key is added to git hub)"
     logMsg "         - curl -H \"Authorization: Basic YWRtaW46YWRtaW4=\" http://localhost:31080/job/Scheduler/build?token=JenkinsSchedulerJobTriggerToken"
      echo ""
      logMsg "pls checkin jenkins/performance-comparator.properties to your git hub MobileProvisioningService/caapm-performance-comparator/properties/ project"
     ;;
   *) 
     logMsg "Not a valid option"
     Usage
     ;;     
esac

