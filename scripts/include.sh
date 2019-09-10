#!/bin/bash
SCRIPTS_FOLDER=`dirname $BASH_SOURCE`

. $SCRIPTS_FOLDER/../config.ini
#. $SCRIPTS_FOLDER/../em/commonEMFunctions



INSTALL_SCRIPT_FOLDER=$PWD/$SCRIPTS_FOLDER/..

BPA_FOLDER=bpa
KUBESPRAY_FOLDER=kubespray
TIXCHANGE_FOLDER=tixChangeHelm
HELM_FOLDER=helmInstaller
HELM_RBAC_YAML=helm-rbac-config.yaml
UMA_FOLDER=uma
SELENIUM_FOLDER=selenium
SELENIUM_UC=runSeleniumUC
#For now keeping this as UC1 as all scripts are in UC1
#SELENIUM_UC2=runSeleniumUC1
UC1_URL=uc1.jtixchange.com
UC2_URL=uc2.jtixchange.com
TIXCHANGE_NAMESPACE1=tixchange-v1
TIXCHANGE_NAMESPACE2=tixchange-v2
LOG_FILE_NAME=TixChangeInstallerLog`date +%Y_%m_%d_%H_%M`.log
LOG_FILE=$INSTALLATION_FOLDER/logs/$LOG_FILE_NAME
EM_FOLDER=em
EM_SETUP_SCRIPT1=setupEMSideConfigurations1.sh
EM_UNIVERSE1_NAME="WestCoast-DataCenter-Jtix"
EM_SETUP_SCRIPT2=setupEMSideConfigurations2.sh
EM_UNIVERSE2_NAME="EastCoast-DataCenter-Jtix"
PROM_NAMESPACE=monitor
PROM_FOLDER=prometheus


TIX_IP=` ip a |grep -E -e eth[0-9]+ -e ens[0-9]+|sed -n '/inet/,/brd/p'|awk '{ print $2 }'|awk -F/ '{print $1 }'`

logMsg () {
        echo "**** $1" | tee -a $LOG_FILE
        
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

stopDeleteBPA () {
	logMsg "***deleting BPA***"
  	
	cd $INSTALLATION_FOLDER/bpa
	kubectl delete -f tix_bpa_deploy_v1.yaml -n tixchange-v1
	cd $INSTALL_SCRIPT_FOLDER
}


installBPA () {
	logMsg "***installing BPA***"
        mkdir $INSTALLATION_FOLDER/bpa 2> /dev/null

  	cp -f $SCRIPTS_FOLDER/../bpa/* $INSTALLATION_FOLDER/bpa

	IS_HTTPS=`echo $BA_SNIPPET|grep https`
	if [ X"IS_HTTPS" == "X" ]; then
		
		DXC_URL="http://"`echo $BA_SNIPPET |awk -F [/] '{print $11}'`
	else
		DXC_URL="https://"`echo $BA_SNIPPET |awk -F [/] '{print $11}'`
        fi

        TENANT_ID=`echo $BA_SNIPPET |awk -F [:/] '{print $11}'`

	TIX_WEB_SVC_IP=`kubectl get svc  -n tixchange-v1|grep -v NAME |grep webp |awk '{print $3}'`


       logMsg "*** BPA TENANT ID $TENANT_ID, DXC URL $DXC_URL, TIX SVC IP $TIX_WEB_SVC_IP**"

        cd $INSTALLATION_FOLDER/bpa

   	ESCAPED_DXC_URL=$(echo "$DXC_URL"| sed 's/\//\\\//g')

        sed -i "s/TIX_IP_VAL/$TIX_WEB_SVC_IP/g" $INSTALLATION_FOLDER/bpa/tix_bpa_deploy_v1.yaml
        sed -i "s/TENANT_ID_VAL/$TENANT_ID/g" $INSTALLATION_FOLDER/bpa/tix_bpa_deploy_v1.yaml
        sed -i "s/DXC_URL_VAL/$ESCAPED_DXC_URL/g" $INSTALLATION_FOLDER/bpa/tix_bpa_deploy_v1.yaml

	kubectl create -f tix_bpa_deploy_v1.yaml -n tixchange-v1

	logMsg "*** BPA proxy and Listener installed - pls configure EM side if not done**"
        cd $INSTALL_SCRIPT_FOLDER
}


stopDeleteApmiaMySQL () {
  logMsg "deleting apmia mysql"
  #kubectl  delete -f $INSTALLATION_FOLDER/apmiaMySQL/apmiaMySql.yaml -n tixchange-v1
}

installApmiaMySQL () {
  logMsg "starting apmia mysql"
  
  mkdir $INSTALLATION_FOLDER/apmiaMySQL 2> /dev/null
 
  cp -f $SCRIPTS_FOLDER/../apmiaMySQL/* $INSTALLATION_FOLDER/apmiaMySQL
  
   ESCAPED_APM_MANAGER_URL_1=$(echo "$APM_MANAGER_URL_1"| sed 's/\//\\\//g')
   sed -i 's/APM_MANAGER_URL_1/'$ESCAPED_APM_MANAGER_URL_1'/' $INSTALLATION_FOLDER/apmiaMySQL/apmiaMySql.yaml
   sed -i 's/APM_MANAGER_CREDENTIAL/'$APM_MANAGER_CREDENTIAL'/' $INSTALLATION_FOLDER/apmiaMySQL/apmiaMySql.yaml

   SQL_SVC_IP=`kubectl get svc -n tixchange-v1|grep mysql|awk '{print $3}'`

   sed -i 's/MY_SQL_SVR_IP/'$SQL_SVC_IP'/' $INSTALLATION_FOLDER/apmiaMySQL/apmiaMySql.yaml

  #kubectl  create -f $INSTALLATION_FOLDER/apmiaMySQL/apmiaMySql.yaml -n tixchange-v1
}


stopDeletePromExporter () {
  logMsg "Deleting Prometheus node exporter "
  kubectl delete -f $SCRIPTS_FOLDER/../$PROM_FOLDER/node-exporter.yaml -n $PROM_NAMESPACE
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

         helm ls
         helm delete tixchange --purge
         sleep 10
         helm delete tixchange --purge 2> /dev/null
         
         helm ls

         cd ..
         rm -rf $TIXCHANGE_FOLDER

         sleep 15

      fi
  fi

 stopDeleteApmiaMySQL

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
         #npm uninstall -g  selenium-side-runner  --unsafe-perm=true --allow-root
         #npm uninstall -g  chromedriver --unsafe-perm=true --allow-root
         #yum remove -y google-chrome
         cd ..
         rm -rf $SELENIUM_FOLDER
                
         sleep 5
                
      fi
  fi            
                
  cd $INSTALL_SCRIPT_FOLDER
}


uninstallSelenium () {
         PID=`ps -ef |grep -i sele|grep -v grep|awk '{ print $2}'`
         kill -9 $PID
         npm uninstall -g  selenium-side-runner  --unsafe-perm=true --allow-root
         npm uninstall -g  chromedriver --unsafe-perm=true --allow-root
         yum remove -y google-chrome
}




stopDeletelAll () {

  stopDeleteSelenium
  uninstallSelenium
  stopDeleteTixChange
  stopDeletePromExporter
  stopDeleteUMA
  stopDeleteBPA
  stopDeleteKubeSpray

  rm -rf $INSTALLATION_FOLDER/*

  mkdir -p $INSTALLATION_FOLDER/logs 2> /dev/null

  LOG_FILE_NAME=TixChangeInstallerLog`date +%Y_%m_%d_%H_%M`.log
  LOG_FILE=$INSTALLATION_FOLDER/logs/$LOG_FILE_NAME  
}

stopDeleteAppComponents () {

  stopDeleteSelenium
  stopDeleteTixChange
  stopDeletePromExporter
  stopDeleteUMA
  stopDeleteBPA
  #rm -rf $INSTALLATION_FOLDER/logs/
}


Usage () {
  echo "Options: "
  echo "  a : install all (K8s,Helm, UMA, TixChange, BPA Selenium, EM side - Universes, Exp View, Mgmt Mod)"
  #echo "  p : run the pre-req"
   echo "  r : re-install & run just app components (helm, uma, tixchange, BPA, selenium, EM side - Universes, Exp View, Mgmt Mod)"
   echo "  u : install & run just uma"
   echo "  t : install & run just tixChange"
  echo "  s : install & run just selenium"
  echo "  e : EM side configuration: Setup Universes, import mgmt module etc"
  echo "  b : install and configure HTTPD, BT Listener for BPA"
  echo "  c : cleanup and unintsall everything"

}

installPromExporter () {
  logMsg "Creating Prometheus node exporter "
  kubectl create -f $SCRIPTS_FOLDER/../$PROM_FOLDER/node-exporter.yaml -n $PROM_NAMESPACE
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


   if [ x"$RENAME_AGENT_HOST_NAME" == "xtrue" ]; then
     #sed -i 's/REPLACE_DEF_TIX_WEB_AGENT_HOST_NS1/\-Dintroscope.agent.hostName=TxChangeWeb_UC1/' templates/tix_configmap_apm_v1.yaml
     echo "RenameAgentHostname: true" >> values.yaml
   fi


   #sed -i 's/SNIPPET_STRING/'$BA_SNIPPET'/' template/tix_configmap_apm.yaml

   ESCAPED_APM_MANAGER_URL_1=$(echo "$APM_MANAGER_URL_1"| sed 's/\//\\\//g')
   sed -i 's/APM_MANAGER_URL_1/'$ESCAPED_APM_MANAGER_URL_1'/' $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER/templates/tix_mysql_deploy_v1.yaml
   sed -i 's/APM_MANAGER_CREDENTIAL/'$APM_MANAGER_CREDENTIAL'/' $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER/templates/tix_mysql_deploy_v1.yaml

   sed -i 's/APM_MANAGER_URL_1/'$ESCAPED_APM_MANAGER_URL_1'/' $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER/templates/tix_mysql_deploy_v2.yaml
   sed -i 's/APM_MANAGER_CREDENTIAL/'$APM_MANAGER_CREDENTIAL'/' $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER/templates/tix_mysql_deploy_v2.yaml


   #logMsg "***IGNORE the 3 errors related to configmap below"
   helm install  . --name tixchange 
   
   sleep 10

   TIXCHANGE_DEPLOYED=`helm ls|grep FAILED`
   
   if [ X"$TIXCHANGE_DEPLOYED" != "X" ]; then
      helm delete tixchange --purge 2>/dev/null
     
      sleep 10
   
      helm install  . --name tixchange

   fi

   sleep 10

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

  installApmiaMySQL

   sleep 5
}

installSelenium () {
  yum install -y gcc-c++ make
  curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -

  sudo yum -y install nodejs-12.8.1

  yum install -y http://orion.lcg.ufrj.br/RPMS/myrpms/google/google-chrome-stable-74.0.3729.169-1.x86_64.rpm

  logMsg "installing selenium-side-runner"
  npm install -g selenium-side-runner

  logMsg "Uninstall and installing chromedriver"
  npm uninstall -g  chromedriver@74 --unsafe-perm=true --allow-root
  npm install -g  chromedriver@74 --unsafe-perm=true --allow-root

}


configureAndRunSelenium () {

  logMsg "Install and Run Selenium"

  if [ ! -d $INSTALLATION_FOLDER/$SELENIUM_FOLDER ]; then
    mkdir -p $INSTALLATION_FOLDER/$SELENIUM_FOLDER
  fi

  cp $SCRIPTS_FOLDER/TixChangeSelenimum*.side $INSTALLATION_FOLDER/$SELENIUM_FOLDER
  cp $SCRIPTS_FOLDER/runSeleniumUC* $INSTALLATION_FOLDER/$SELENIUM_FOLDER

  cd $INSTALLATION_FOLDER/$SELENIUM_FOLDER

  sleep 10

  logMsg "configuring the use cases"
  ESCAPED_APM_SAAS_URL=$(echo "$APM_SAAS_URL"| sed 's/\//\\\//g')
  sed -i 's/APM_SAAS_URL/'$ESCAPED_APM_SAAS_URL'/' $SELENIUM_UC
  sed -i 's/APM_API_TOKEN/'$APM_MANAGER_CREDENTIAL'/' $SELENIUM_UC

  #sed -i 's/APM_SAAS_URL/'$ESCAPED_APM_SAAS_URL'/' $SELENIUM_UC2
  #sed -i 's/APM_API_TOKEN/'$APM_MANAGER_CREDENTIAL'/' $SELENIUM_UC2

   TIXCHANGE_WEB_POD1=`kubectl get pods -n $TIXCHANGE_NAMESPACE1 |grep -v NAME |awk '{print $1}'|grep tix-web`
   TIXCHANGE_WS_POD1=`kubectl get pods -n $TIXCHANGE_NAMESPACE1 |grep -v NAME |awk '{print $1}'|grep tix-ws`

   TIXCHANGE_WEB_POD2=`kubectl get pods -n $TIXCHANGE_NAMESPACE2 |grep -v NAME |awk '{print $1}'|grep tix-web`
   TIXCHANGE_WS_POD2=`kubectl get pods -n $TIXCHANGE_NAMESPACE2 |grep -v NAME |awk '{print $1}'|grep tix-ws`

   sed -i 's/TIX_WEB_INSTANCE1/'$TIXCHANGE_WEB_POD1'/' $SELENIUM_UC
   sed -i 's/TIX_WS_INSTANCE1/'$TIXCHANGE_WS_POD1'/' $SELENIUM_UC

   sed -i 's/TIX_WEB_INSTANCE2/'$TIXCHANGE_WEB_POD2'/' $SELENIUM_UC
   sed -i 's/TIX_WS_INSTANCE2/'$TIXCHANGE_WS_POD2'/' $SELENIUM_UC


  chmod 755 runS*
  nohup ./$SELENIUM_UC > ucNohup.out 2>&1 &   
  #nohup ./$SELENIUM_UC2 > uc2Nohup.out 2>&1 &   

  
  cd -
}

configureEM () {

  if [ X"$1" == "Xem1" ]; then
    EM_SETUP_SCRIPT=$EM_SETUP_SCRIPT1
    EM_UNIVERSE_NAME=$EM_UNIVERSE1_NAME
    TIXCHANGE_NAMESPACE=$TIXCHANGE_NAMESPACE1
    #TIX_WEB_INSTANCE=$TIX_WEB_INSTANCE1

  if [ -d $INSTALLATION_FOLDER/$EM_FOLDER ]; then
    rm -rf $INSTALLATION_FOLDER/$EM_FOLDER
  fi

  mkdir -p $INSTALLATION_FOLDER/$EM_FOLDER

  else
    EM_SETUP_SCRIPT=$EM_SETUP_SCRIPT2
    EM_UNIVERSE_NAME=$EM_UNIVERSE2_NAME
    TIXCHANGE_NAMESPACE=$TIXCHANGE_NAMESPACE2
    #TIX_WEB_INSTANCE=$TIX_WEB_INSTANCE2
  
  fi


  logMsg "configuring the EM Common Functions for $1 $EM_SETUP_SCRIPT"

  cp -f $EM_FOLDER/$EM_SETUP_SCRIPT $INSTALLATION_FOLDER/$EM_FOLDER/
  cp -f $EM_FOLDER/jq-linux64 $INSTALLATION_FOLDER/$EM_FOLDER/
  cp -f $EM_FOLDER/TixChange.jar $INSTALLATION_FOLDER/$EM_FOLDER/

  cd $INSTALLATION_FOLDER/$EM_FOLDER

  ESCAPED_APM_SAAS_URL=$(echo "$APM_SAAS_URL"| sed 's/\//\\\//g')
   ESCAPED_INSTALLATION_FOLDER=$(echo "$INSTALLATION_FOLDER"| sed 's/\//\\\//g')
  APM_SAAS_URL_NO_PROTO=$(echo "$APM_SAAS_URL"| sed 's/http[s]*:\/\///g' |sed 's/\//\\\//g' )

  sed -i 's/APM_SAAS_URL_NO_PROTO/'$APM_SAAS_URL_NO_PROTO'/' $EM_SETUP_SCRIPT
  sed -i 's/APM_SAAS_URL/'$ESCAPED_APM_SAAS_URL'/' $EM_SETUP_SCRIPT
  sed -i 's/APM_API_TOKEN/'$APM_API_TOKEN'/' $EM_SETUP_SCRIPT
  sed -i 's/SAAS_USER_ID/'$SAAS_USER_ID'/' $EM_SETUP_SCRIPT
  sed -i 's/EM_UNIVERSE_NAME/'$EM_UNIVERSE_NAME'/' $EM_SETUP_SCRIPT
  sed -i 's/INSTALLATION_FOLDER/'$ESCAPED_INSTALLATION_FOLDER'/' $EM_SETUP_SCRIPT
  sed -i 's/EM_FOLDER/'$EM_FOLDER'/' $EM_SETUP_SCRIPT


  TIXCHANGE_WEB_POD=`kubectl get pods -n $TIXCHANGE_NAMESPACE |grep -v NAME |awk '{print $1}'|grep tix-web`
  TIXCHANGE_WS_POD=`kubectl get pods -n $TIXCHANGE_NAMESPACE |grep -v NAME |awk '{print $1}'|grep tix-ws`
  
  sed -i 's/TIX_WEB_INSTANCE/'$TIXCHANGE_WEB_POD'/' $EM_SETUP_SCRIPT
  sed -i 's/TIX_WS_INSTANCE/'$TIXCHANGE_WS_POD'/' $EM_SETUP_SCRIPT

  ##UNIVERSE_ID=`getUniverseIDFromName "$EM_UNIVERSE1"`

  #logMsg " UNIVERSE ID is $UNIVERSE_ID"

  #sed -i 's/UNIVERSE_ID/'$UNIVERSE_ID'/' $EM_SETUP_SCRIPT

  ./$EM_SETUP_SCRIPT
  
  cd -
}

runFinalSanityCheck () {

   logMsg "running sanity test to ensure its all good - pls wait"

   sleep 15

   IS_TEST_PASS=`grep failed $INSTALLATION_FOLDER/$SELENIUM_FOLDER/ucNohup.out`

   if [ X"$IS_TEST_PASS" != "X" ]; then
      
      GOOGL_CHRM_VER=`google-chrome --version |grep "74.0"`

      if [ X"$GOOGL_CHRM_VER" == "X" ]; then
        logMsg "** Google chrome version issue - reinstalling **"
        yum remove -y google-chrome
        yum install -y http://orion.lcg.ufrj.br/RPMS/myrpms/google/google-chrome-stable-74.0.3729.169-1.x86_64.rpm

      else 
        logMsg "*** looks like Tixchange issue - restarting**"
        $INSTALL_SCRIPT_FOLDER/healthCheck/restartTixChange.sh
      fi

      sleep 15

      sed -i "s/failed/NOT_FAILED/g" $INSTALLATION_FOLDER/$SELENIUM_FOLDER/ucNohup.out
   fi

  
   
   IS_TEST_PASS=`tail -8 $INSTALLATION_FOLDER/$SELENIUM_FOLDER/ucNohup.out |grep failed`
   if [ X"$IS_TEST_PASS" != "X" ]; then
    
      logMsg ""
      logMsg "*** Looks like UC1 or UC2 Selenium tests are experiencing issues running the test. Pls check $INSTALLATION_FOLDER/$SELENIUM_FOLDER/ucNohup.out and raise an issue in git hub"	
      logMsg ""

      

     exit
   fi

     logMsg "Sanity Passed"

}



if [ "$EUID" -ne 0 ]
  then logMsg "Please run as root"
  exit
fi

