#!/bin/bash
SCRIPTS_FOLDER=`dirname $BASH_SOURCE`

. $SCRIPTS_FOLDER/../config.ini



INSTALL_SCRIPT_FOLDER=$PWD/$SCRIPTS_FOLDER/..

KUBESPRAY_FOLDER=kubespray
TIXCHANGE_FOLDER=tixChangeHelm
HELM_FOLDER=helmInstaller
HELM_RBAC_YAML=helm-rbac-config.yaml
UMA_FOLDER=uma
JMETER_FOLDER=jmeter
SELENIUM_FOLDER=selenium
SELENIUM_UC=runSeleniumUC
UC1_URL=uc1.jtixchange.com
UC2_URL=uc2.jtixchange.com

TIX_IP=` ip a |grep eth0|sed -n '/inet/,/brd/p'|awk '{ print $2 }'|awk -F/ '{print $1 }'`

logMsg () {
        echo "**** $1"
        
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

  if [ -d "$INSTALLATION_FOLDER" ]; then


      cd $INSTALLATION_FOLDER
 
      #ensure folder exists again
      if [ $? -eq 0 ]; then
         cd $TIXCHANGE_FOLDER
         logMsg "Deleting tixchange"

         helm delete tixchange --purge
         helm delete tixchange --purge

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

    
}

cleanUp () {
   
  helm delete tixchange --purge
  helm delete uma --purge

  cd $INSTALLATION_FOLDER/$KUBESPRAY_FOLDER

  ansible-playbook -b --become-user=root -v -i  inventory/mycluster/hosts.yml --user=root reset.yml --flush-cache

  ps -ef |grep jmeter |grep Tix|awk  '{print $2}' | kill -9

  logMsg "Cleaning up all the folders"

  sleep 2

  stopCleanupServices a

  cd $INSTALL_SCRIPT_FOLDER
}


Usage () {
  echo "Options: "
  echo "  a : install all (K8s,Helm, UMA, TixChange, Selenium)"
  echo "  p : run the pre-req"
   echo "  u : install & run just uma"
   echo "  t : install & run just tixChange"
  #echo "  j : install & run just jmeter"
  echo "  s : install & run just selenium"
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
   logMsg "Installing TixChang using Helm"
   kubectl delete configmap default-basnippet --namespace=tixchange-v1 
   kubectl delete configmap jtixchange-pbd --namespace=tixchange-v2 
   kubectl delete configmap jtixchange-pbd --namespace=tixchange-v1 

  if [ ! -d $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER ]; then
    mkdir -p $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER
  fi


   cp -rf $TIXCHANGE_FOLDER/* $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER
   cp -rf $SCRIPTS_FOLDER/default.basnippet $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER
   cp -rf $SCRIPTS_FOLDER/jtixchange.pbd  $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER

   echo $BA_SNIPPET > $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER/default.basnippet

   cd $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER

   #sed -i 's/SNIPPET_STRING/'$BA_SNIPPET'/' template/tix_configmap_apm.yaml

   helm install  . --name tixchange 
   kubectl create configmap default-basnippet --namespace=tixchange-v1 --from-file=./default.basnippet
   kubectl create configmap jtixchange-pbd --namespace=tixchange-v2 --from-file=./jtixchange.pbd
   kubectl create configmap jtixchange-pbd --namespace=tixchange-v1 --from-file=./jtixchange.pbd
    
   helm list 
   kubectl get pods -n tixchange
   kubectl get pods -n tixchangev2
   
   cd -

   logMsg " Tixchange  done "


   UPDATE_HOSTS_FILE=`grep uc1.jtixchange.com /etc/hosts`
   
   if [ X"$UPDATE_HOSTS_FILE" == "X" ]; then
     echo "$TIX_IP $UC1_URL" >> /etc/hosts
     echo "$TIX_IP $UC2_URL" >> /etc/hosts
   fi

   sleep 5
}

installAndRunJmeter () {
  
  logMsg "Installing Jmeter - current folder $PWD "
  logMsg "current folder $PWD. SCRIPT folder is $SCRIPTS_FOLDER "

  if [ ! -d $INSTALLATION_FOLDER/$JMETER_FOLDER ]; then
    mkdir -p $INSTALLATION_FOLDER/$JMETER_FOLDER	
  fi



  cp -f $JMETER_FOLDER/* $INSTALLATION_FOLDER/$JMETER_FOLDER
 
  cd $INSTALLATION_FOLDER/$JMETER_FOLDER

  tar xvf  apache-jmeter-5.1.1.tgz > /dev/null

  SVC_IP=`kubectl get svc -n tixchange |grep webportal|awk '{print $3}'`
  SVC_PORT=`kubectl get svc -n tixchange|grep webportal|awk '{print $5}'|awk -F/ '{print $1}'`

  echo $SVC_IP,$SVC_PORT >jt-ips.csv

  nohup apache-jmeter*/bin/jmeter.sh -n -t TixChange_LoadScript.jmx 2>&1 &

 cd -
}

installAndRunSelenium () {

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
  sed -i 's/APM_API_TOKEN/'$APM_API_TOKEN'/' $SELENIUM_UC

   TIXCHANGE_WEB_POD=`kubectl get pods -n tixchange |grep -v NAME |awk '{print $1}'|grep web`
   TIXCHANGE_WS_POD=`kubectl get pods -n tixchange |grep -v NAME |awk '{print $1}'|grep ws`

   sed -i 's/TIX_WEB_INSTANCE1/'$TIXCHANGE_WEB_POD'/' $SELENIUM_UC
   sed -i 's/TIX_WS_INSTANCE1/'$TIXCHANGE_WS_POD'/' $SELENIUM_UC


  chmod 755 runS*
  nohup ./$SELENIUM_UC 2>&1 &   

  
  cd -
}


if [ "$EUID" -ne 0 ]
  then logMsg "Please run as root"
  exit
fi

