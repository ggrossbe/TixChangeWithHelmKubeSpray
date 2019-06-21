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

logMsg () {
        echo "$1"
        
}


emptyInstallFolders () {


     #ensure folder exist
     if [ -d "$INSTALLATION_FOLDER" ]; then


         cd $INSTALLATION_FOLDER
   
         #ensure folder exists again
         if [ $? -eq 0 ]; then

           case $1 in
            a) # empty all
                logMsg "emptying all stuff from ** $INSTALLATION_FOLDER **"
                logMsg "press Ctrl-C to exit"
           
		read INPUT


                rm -rf $HELM_FOLDER
                rm -rf $KUBESPRAY_FOLDER
                rm -rf $TIXCHANGE_FOLDER
                #rm -rf $HELM_FOLDER
                rm -rf $UMA_FOLDER
                rm -rf $JMETER_FOLDER
                cd -
                ;;
            k)
                logMsg "emptying kubespray stuff from ** $INSTALLATION_FOLDER **"
                logMsg "press Ctrl-C to exit"
           
		read INPUT

                rm -rf $KUBESPRAY_FOLDER
                cd -
                ;;
            u)
                logMsg "emptying UMA stuff from ** $INSTALLATION_FOLDER **"
                logMsg "press Ctrl-C to exit"
           
		read INPUT

		logMsg "Deleting UMA"
                helm delete uma --purge
                rm -rf $UMA_FOLDER
		sleep 5
                cd -
                ;;
            t)
                logMsg "emptying TixChange stuff from ** $INSTALLATION_FOLDER **"
                logMsg "press Ctrl-C to exit"
           
		read INPUT

		logMsg "Deleting TixChange"
                helm delete tixchange --purge
                rm -rf $TIXCHANGE_FOLDER
                sleep 5
                cd -
                ;;
            j)
                logMsg "emptying Jmeter stuff from ** $INSTALLATION_FOLDER **"
                logMsg "press Ctrl-C to exit"
           
		read INPUT

                rm -rf $JMETER_FOLDER
                cd -
                ;;
             esac
        else
           logMsg "Sorry could not CD to $INSTALLATION_FOLDER. Hence cannot empty it. Pls check if the folder exists or not and have sufficient priv"
           exit
        fi
    
     else 
       mkdir -p $INSTALLATION_FOLDER
     fi

}

cleanUp () {
   
  helm delete tixchange --purge
  helm delete uma --purge

  cd $INSTALLATION_FOLDER/$KUBESPRAY_FOLDER

  ansible-playbook -b --become-user=root -v -i  inventory/mycluster/hosts.yml --user=root reset.yml --flush-cache

  ps -ef |grep jmeter |grep Tix|awk  '{print $2}' | kill -9

  logMsg "Cleaning up all the folders"

  sleep 2

  emptyInstallFolders a

  cd $INSTALL_SCRIPT_FOLDER
}


Usage () {
  echo "Options: "
  echo "  a : install all (K8s,Helm, UMA, TixChange, JMeter)"
  echo "  p : run the pre-reqa"
#  echo "  k : install just kubernetes"
   echo "  u : install just uma"
   echo "  t : install just tixChange"
  echo "  j : install just jmeter"
  echo "  c : cleanup and unintsall everything"

}

cleanInstallHelmClient () {
   
    logMsg "Deleting Helm"

    #ensure folder exist
     if [ -d "$INSTALLATION_FOLDER" ]; then
         #ensure folder exist
        if [ -d "$INSTALLATION_FOLDER/$HELM_FOLDER" ]; then
          helm delete uma --purge
          helm delete tixchange --purge

          cp -f $SCRIPTS_FOLDER/$HELM_RBAC_YAML  $INSTALLATION_FOLDER/$HELM_FOLDER/

          kubectl create -f $INSTALLATION_FOLDER/$HELM_FOLDER/$HELM_RBAC_YAML

          cd  $INSTALLATION_FOLDER/$HELM_FOLDER/
          wget https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz

          tar -xvf helm-v2.13.1-linux-amd64.tar.gz
          mv linux-amd64/helm /usr/local/bin/helm

          helm init --service-account tiller --history-max 200

          cd -

        else
          mkdir -p $INSTALLATION_FOLDER/$HELM_FOLDER/
          cp -f $SCRIPTS_FOLDER/$HELM_RBAC_YAML  $INSTALLATION_FOLDER/$HELM_FOLDER/
          
          kubectl create -f $INSTALLATION_FOLDER/$HELM_FOLDER/$HELM_RBAC_YAML
          
          cd  $INSTALLATION_FOLDER/$HELM_FOLDER/
          wget https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz 

          tar -xvf helm-v2.13.1-linux-amd64.tar.gz
          mv linux-amd64/helm /usr/local/bin/helm

          helm init --service-account tiller --history-max 200

          cd -
        fi
     else
        mkdir -p $INSTALLATION_FOLDER/$HELM_FOLDER/
        cp -f $SCRIPTS_FOLDER/$HELM_RBAC_YAML  $INSTALLATION_FOLDER/$HELM_FOLDER/

        kubectl create -f $INSTALLATION_FOLDER/$HELM_FOLDER/$HELM_RBAC_YAML
       
          cd  $INSTALLATION_FOLDER/$HELM_FOLDER/
          wget https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz

          tar -xvf helm-v2.13.1-linux-amd64.tar.gz
          mv linux-amd64/helm /usr/local/bin/helm

          helm init --service-account tiller --history-max 200

          cd -

     fi
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

  if [ ! -d $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER ]; then
    mkdir -p $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER
  fi


   cp -rf $TIXCHANGE_FOLDER/* $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER

   cd $INSTALLATION_FOLDER/$TIXCHANGE_FOLDER
   helm install  . --name tixchange --namespace tixchange
    
   helm list 
   kubectl get pods -n tixchange
   
   cd -

   logMsg " Tixchange  done "

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


if [ "$EUID" -ne 0 ]
  then logMsg "Please run as root"
  exit
fi

