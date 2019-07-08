#!/bin/bash
SCRIPTS_FOLDER=`dirname $BASH_SOURCE`

. $SCRIPTS_FOLDER/../config.ini
#. $SCRIPTS_FOLDER/../em/commonEMFunctions



INSTALL_SCRIPT_FOLDER=$PWD/$SCRIPTS_FOLDER/..

KUBESPRAY_FOLDER=kubespray
TIXCHANGE_FOLDER=tixChangeHelm
HELM_FOLDER=helmInstaller
HELM_RBAC_YAML=helm-rbac-config.yaml
UMA_FOLDER=uma
SELENIUM_FOLDER=selenium
SELENIUM_UC=runSeleniumUC
UC1_URL=uc1.jtixchange.com
UC2_URL=uc2.jtixchange.com
TIXCHANGE_NAMESPACE1=tixchange-v1
TIXCHANGE_NAMESPACE2=tixchange-v2
LOG_FILE=$INSTALLATION_FOLDER/TixChangeInstallerLog`date +%Y_%m_%d_%H_%M_%S`.log
EM_FOLDER=em
EM_SETUP_SCRIPT=setupEMSideConfigurations.sh
EM_UNIVERSE1_NAME="WestCoast-DataCenter-Jtix"


TIX_IP=` ip a |grep -E -e eth[0-9]+ -e ens[0-9]+|sed -n '/inet/,/brd/p'|awk '{ print $2 }'|awk -F/ '{print $1 }'`

logMsg () {
        echo "**** $1" | tee $LOG_FILE
        
}


stopDeleteUMA () {

  if [ -d "$INSTALLATION_FOLDER" ]; then


      cd $INSTALLATION_FOLDER
   
      #ensure folder exists again
      if [ $? -eq 0 ]; then
         cd $UMA_FOLDER
  	 logMsg "Deleting UMA"
  	 helm delete uma --purge
         cd ..
  	 rm -rf $UMA_FOLDER
      
  	 sleep 5

      fi
  fi
  cd $INSTALL_SCRIPT_FOLDER

}


stopDeleteKubeSpray () {

  if [ -d "$INSTALLATION_FOLDER" ]; then


      cd $INSTALLATION_FOLDER
  
      #ensure folder exists again
      if [ $? -eq 0 ]; then
         cd $KUBESPRAY_FOLDER
         logMsg "Deleting Kubespray"

	 ansible-playbook -b --become-user=root -v -i  inventory/mycluster/hosts.yml --user=root reset.yml --flush-cache

         cd ..
         rm -rf $KUBESPRAY_FOLDER

         sleep 5

      fi
  fi

  cd $INSTALL_SCRIPT_FOLDER
}


stopDeleteTixChange () {

  logMsg "Stopping and Deleteing Tixchange and its components"

  if [ -d "$INSTALLATION_FOLDER" ]; then


      cd $INSTALLATION_FOLDER
 
      #ensure folder exists again
      if [ $? -eq 0 ]; then
         cd $TIXCHANGE_FOLDER
         logMsg "Deleting tixchange"

         helm delete tixchange --purge
         helm delete tixchange --purge 2> /dev/null

         cd ..
         rm -rf $TIXCHANGE_FOLDER

         sleep 5

      fi
  fi

  cd $INSTALL_SCRIPT_FOLDER

}


stopDeleteSelenium () {

  if [ -d "$INSTALLATION_FOLDER" ]; then


      cd $INSTALLATION_FOLDER
     
      #ensure folder exists again
      if [ $? -eq 0 ]; then
         cd $SELENIUM_FOLDER
         logMsg "Deleting Selenium"
         
         PID=`ps -ef |grep -i sele|grep -v grep|awk '{ print $2}'`
         kill -9 $PID
         npm uninstall -g  selenium-side-runner  --unsafe-perm=true --allow-root
         npm uninstall -g  chromedriver --unsafe-perm=true --allow-root
         cd ..
         rm -rf $SELENIUM_FOLDER
                
         sleep 5
                
      fi
  fi            
                
  cd $INSTALL_SCRIPT_FOLDER
}



stopDeletelAll () {

  stopDeleteSelenium
  stopDeleteTixChange
  stopDeleteUMA
  stopDeleteKubeSpray

  rm -rf $INSTALLATION_FOLDER/*

    
}

stopDeleteAppComponents () {

  stopDeleteSelenium
  stopDeleteTixChange
  stopDeleteUMA
}


Usage () {
  echo "Options: "
  echo "  a : install all (K8s,Helm, UMA, TixChange, Selenium)"
  #echo "  p : run the pre-req"
   echo "  r : re-install & run just app components (helm, uma, tixchange, selenium)"
   echo "  u : install & run just uma"
   echo "  t : install & run just tixChange"
  echo "  s : install & run just selenium"
  echo "  e : EM side configuration: Setup Universes, import mgmt module etc"
  echo "  c : cleanup and unintsall everything"

}


installUMA () {
   logMsg "Installing UMA using Helm"

   if [ ! -d $INSTALLATION_FOLDER/$UMA_FOLDER ]; then
     mkdir -p $INSTALLATION_FOLDER/$UMA_FOLDER
   fi


   cp -rf $UMA_FOLDER/* $INSTALLATION_FOLDER/$UMA_FOLDER

   cd $INSTALLATION_FOLDER/$UMA_FOLDER

   ESCAPED_APM_MANAGER_URL_1=$(echo "$APM_MANAGER_URL_1"| sed 's/\//\\\//g')
   sed -i 's/agentManager_url_1.*$/agentManager_url_1: '$ESCAPED_APM_MANAGER_URL_1'/' values.yaml

   sed -i 's/agentManager_credential.*$/agentManager_credential: '$APM_MANAGER_CREDENTIAL'/' values.yaml
   sed -i 's/cluster_name.*$/cluster_name: '$UMA_K8S_CLUSTER_NAME'/' values.yaml

   helm install  . --name uma --namespace caaiops
   
   helm list
   kubectl get pods -n caaiops

   cd -
   
   logMsg " UMA done "

   sleep 5 
}


installTixChangeHelm () {
   logMsg "Installing TixChange using Helm"

   #deleting tixchange one more time just to be sure
   helm delete tixchange --purge 2>/dev/null
   sleep 5
   #kubectl delete configmap default-basnippet --namespace=$TIXCHANGE_NAMESPACE1 
   #kubectl delete configmap jtixchange-pbd --namespace=$TIXCHANGE_NAMESPACE2 
   #kubectl delete configmap jtixchange-pbd --namespace=$TIXCHANGE_NAMESPACE1 

  if [ ! -d $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER ]; then
    mkdir -p $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER
  fi


   cp -rf $TIXCHANGE_FOLDER/* $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER
   cp -rf $SCRIPTS_FOLDER/default.basnippet $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER
   cp -rf $SCRIPTS_FOLDER/jtixchange.pbd  $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER

   echo $BA_SNIPPET > $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER/default.basnippet

   cd $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER

   #sed -i 's/SNIPPET_STRING/'$BA_SNIPPET'/' template/tix_configmap_apm.yaml

   #logMsg "***IGNORE the 3 errors related to configmap below"
   helm install  . --name tixchange 

   logMsg ""
   kubectl create configmap default-basnippet --namespace=$TIXCHANGE_NAMESPACE1 --from-file=./default.basnippet
   kubectl create configmap jtixchange-pbd --namespace=$TIXCHANGE_NAMESPACE2 --from-file=./jtixchange.pbd
   kubectl create configmap jtixchange-pbd --namespace=$TIXCHANGE_NAMESPACE1 --from-file=./jtixchange.pbd
    
   helm list 
   kubectl get pods -n $TIXCHANGE_NAMESPACE1
   kubectl get pods -n $TIXCHANGE_NAMESPACE2
   
   cd -

   logMsg " Tixchange  done "


   UPDATE_HOSTS_FILE=`grep uc1.jtixchange.com /etc/hosts`
   
   if [ X"$TIX_IP" != "X" ]; then
  
     if [ X"$UPDATE_HOSTS_FILE" == "X" ]; then
       echo "$TIX_IP $UC1_URL" >> /etc/hosts
       echo "$TIX_IP $UC2_URL" >> /etc/hosts
     fi
   else
     logMsg "*** ERROR: IP address could not be update in /etc/hosts. Pls add IP to HOST manually"
   fi

   sleep 5
}


installAndRunSelenium () {

  logMsg "Install and Run Selenium"

  if [ ! -d $INSTALLATION_FOLDER/$SELENIUM_FOLDER ]; then
    mkdir -p $INSTALLATION_FOLDER/$SELENIUM_FOLDER
  fi

  cp $SCRIPTS_FOLDER/TixChangeSelenimum*.side $INSTALLATION_FOLDER/$SELENIUM_FOLDER
  cp $SCRIPTS_FOLDER/$SELENIUM_UC $INSTALLATION_FOLDER/$SELENIUM_FOLDER

  cd $INSTALLATION_FOLDER/$SELENIUM_FOLDER

  yum install -y gcc-c++ make
  curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -
   
  sudo yum -y install nodejs
  
  yum install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

  logMsg "installing selenium-side-runner"
  npm install -g selenium-side-runner

  logMsg "Uninstall and installing chromedriver"
  npm uninstall -g  chromedriver@74 --unsafe-perm=true --allow-root
  npm install -g  chromedriver@74 --unsafe-perm=true --allow-root

  sleep 10

  logMsg "configuring the use cases"
  ESCAPED_APM_SAAS_URL=$(echo "$APM_SAAS_URL"| sed 's/\//\\\//g')
  sed -i 's/APM_SAAS_URL/'$ESCAPED_APM_SAAS_URL'/' $SELENIUM_UC
  sed -i 's/APM_API_TOKEN/'$APM_MANAGER_CREDENTIAL'/' $SELENIUM_UC

   TIXCHANGE_WEB_POD=`kubectl get pods -n $TIXCHANGE_NAMESPACE1 |grep -v NAME |awk '{print $1}'|grep web`
   TIXCHANGE_WS_POD=`kubectl get pods -n $TIXCHANGE_NAMESPACE1 |grep -v NAME |awk '{print $1}'|grep ws`

   sed -i 's/TIX_WEB_INSTANCE1/'$TIXCHANGE_WEB_POD'/' $SELENIUM_UC
   sed -i 's/TIX_WS_INSTANCE1/'$TIXCHANGE_WS_POD'/' $SELENIUM_UC


  chmod 755 runS*
  nohup ./$SELENIUM_UC 2>&1 &   

  
  cd -
}

setEMSideConfiguration () {

  logMsg "configuring the EM Common Functions"

 
  if [ -d $INSTALLATION_FOLDER/$EM_FOLDER ]; then
    rm -rf $INSTALLATION_FOLDER/$EM_FOLDER
  fi

  mkdir -p $INSTALLATION_FOLDER/$EM_FOLDER

  cp -f $EM_FOLDER/* $INSTALLATION_FOLDER/$EM_FOLDER/

  cd $INSTALLATION_FOLDER/$EM_FOLDER

  ESCAPED_APM_SAAS_URL=$(echo "$APM_SAAS_URL"| sed 's/\//\\\//g')
  sed -i 's/APM_SAAS_URL/'$ESCAPED_APM_SAAS_URL'/' $EM_SETUP_SCRIPT
  sed -i 's/APM_API_TOKEN/'$APM_API_TOKEN'/' $EM_SETUP_SCRIPT
  sed -i 's/SAAS_USER_ID/'$SAAS_USER_ID'/' $EM_SETUP_SCRIPT
  sed -i 's/EM_UNIVERSE1_NAME/'$EM_UNIVERSE1_NAME'/' $EM_SETUP_SCRIPT


  TIXCHANGE_WEB_POD=`kubectl get pods -n $TIXCHANGE_NAMESPACE1 |grep -v NAME |awk '{print $1}'|grep web`
  TIXCHANGE_WS_POD=`kubectl get pods -n $TIXCHANGE_NAMESPACE1 |grep -v NAME |awk '{print $1}'|grep ws`
  
  sed -i 's/TIX_WEB_INSTANCE1/'$TIXCHANGE_WEB_POD'/' $EM_SETUP_SCRIPT
  sed -i 's/TIX_WS_INSTANCE1/'$TIXCHANGE_WS_POD'/' $EM_SETUP_SCRIPT

  ##UNIVERSE_ID=`getUniverseIDFromName "$EM_UNIVERSE1"`

  #logMsg " UNIVERSE ID is $UNIVERSE_ID"

  #sed -i 's/UNIVERSE_ID/'$UNIVERSE_ID'/' $EM_SETUP_SCRIPT

  ./$EM_SETUP_SCRIPT
  
  cd -
}



if [ "$EUID" -ne 0 ]
  then logMsg "Please run as root"
  exit
fi

