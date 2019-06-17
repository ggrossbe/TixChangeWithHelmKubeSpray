#!/bin/bash
SCRIPTS_FOLDER=`dirname $BASH_SOURCE`

. $SCRIPTS_FOLDER/../config.ini


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
     if [ -d "$INSTALL_FOLDER" ]; then
       logMsg "emptying stuff from ** $INSTALL_FOLDER ** and will re-install relevant components. press y to proceed"

       read INPUT

        #User says delete
       if [ X$INPUT == "Xy" ]; then
         cd $INSTALL_FOLDER
   
         #ensure folder exists again
         if [ $? -eq 0 ]; then

           case $1 in
            a) # empty all
                rm -rf $HELM_FOLDER
                rm -rf $KUBESPRAY_FOLDER
                rm -rf $TIXCHANGE_FOLDER
                rm -rf $HELM_FOLDER
                rm -rf $UMA_FOLDER
                rm -rf $JMETER_FOLDER
                cd -
                ;;
            k)
                rm -rf $KUBESPRAY_FOLDER
                cd -
                ;;
            u)
                rm -rf $UMA_FOLDER
                cd -
                ;;
            t)
                rm -rf $TIXCHANGE_FOLDER
                cd -
                ;;
            j)
                rm -rf $JMETER_FOLDER
                cd -
                ;;
             esac
        else
           logMsg "Sorry could not CD to $INSTALL_FOLDER. Hence cannot empty it. Pls check if the folder exists or not and have sufficient priv"
           exit
        fi
       fi
    
     else 
       mkdir -p $INSTALL_FOLDER
     fi

}

cleanUp () {
   
  helm delete tixchange --purge
  helm delete uma --purge

  cd $INSTALL_FOLDER/$KUBESPRAY_FOLDER

  ansible-playbook -b --become-user=root -v -i  inventory/mycluster/hosts.yml --user=root reset.yml --flush-cache

  cd -


  logMsg "Cleaning up all the folders"

  sleep 2

  emptyInstallFolders a
}


Usage () {
  echo "Options: "
  echo "  a : install all (K8s, UMA, TixChange, JMeter)"
  echo "  p : run the pre-reqa"
  echo "  k : install kubernetes"
  echo "  u : install uma"
  echo "  t : install tixChange"
  echo "  j : install jmeter"
  echo "  c : cleanup and unintsall everything"

}

cleanInstallHelmClient () {
   
    logMsg "Deleting Helm"

    #ensure folder exist
     if [ -d "$INSTALL_FOLDER" ]; then
         #ensure folder exist
        if [ -d "$INSTALL_FOLDER/$HELM_FOLDER" ]; then
          helm delete uma --purge
          helm delete tixchange --purge

          cp -f $SCRIPTS_FOLDER/$HELM_RBAC_YAML  $INSTALL_FOLDER/$HELM_FOLDER/

          kubectl create -f $INSTALL_FOLDER/$HELM_FOLDER/$HELM_RBAC_YAML

          cd  $INSTALL_FOLDER/$HELM_FOLDER/
          wget https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz

          tar -xvf helm-v2.13.1-linux-amd64.tar.gz
          mv linux-amd64/helm /usr/local/bin/helm

          helm init --service-account tiller --history-max 200

          cd -

        else
          mkdir -p $INSTALL_FOLDER/$HELM_FOLDER/
          cp -f $SCRIPTS_FOLDER/$HELM_RBAC_YAML  $INSTALL_FOLDER/$HELM_FOLDER/
          
          kubectl create -f $INSTALL_FOLDER/$HELM_FOLDER/$HELM_RBAC_YAML
          
          cd  $INSTALL_FOLDER/$HELM_FOLDER/
          wget https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz 

          tar -xvf helm-v2.13.1-linux-amd64.tar.gz
          mv linux-amd64/helm /usr/local/bin/helm

          helm init --service-account tiller --history-max 200

          cd -
        fi
     else
        mkdir -p $INSTALL_FOLDER/$HELM_FOLDER/
        cp -f $SCRIPTS_FOLDER/$HELM_RBAC_YAML  $INSTALL_FOLDER/$HELM_FOLDER/

        kubectl create -f $INSTALL_FOLDER/$HELM_FOLDER/$HELM_RBAC_YAML
       
          cd  $INSTALL_FOLDER/$HELM_FOLDER/
          wget https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz

          tar -xvf helm-v2.13.1-linux-amd64.tar.gz
          mv linux-amd64/helm /usr/local/bin/helm

          helm init --service-account tiller --history-max 200

          cd -

     fi
}


installUMA () {
   logMsg "Installing UMA using Helm"

   cd $INSTALL_FOLDER/$UMA_FOLDER
   helm install  . --name uma --namespace caaiops
   
   helm list
   kubectl get pods -n caaiops

   cd -
   
   logMsg " UMA done "

   sleep 5 
}


installTixChangeHelm () {
   logMsg "Installing TixChang using Helm"

   cd $INSTALL_FOLDER/$TIXCHANGE_FOLDER
   helm install  . --name tixchange --namespace tixchange
    
   helm list 
   kubectl get pods -n tixchange
   
   cd -

   logMsg " Tixchange  done "

   sleep 5
}


if [ "$EUID" -ne 0 ]
  then logMsg "Please run as root"
  exit
fi

