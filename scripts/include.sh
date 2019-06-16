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

Usage () {
  echo "Options: "
  echo "  a : install all (K8s, UMA, TixChange, JMeter)"
  echo "  p : run the pre-reqa"
  echo "  k : install kubernetes"
  echo "  u : install uma"
  echo "  t : install tixChange"
  echo "  j : install jmeter"

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
          helm init --service-account tiller --history-max 200
        else
          mkdir -p $INSTALL_FOLDER/$HELM_FOLDER/
          cp -f $SCRIPTS_FOLDER/$HELM_RBAC_YAML  $INSTALL_FOLDER/$HELM_FOLDER/
          
          kubectl create -f $INSTALL_FOLDER/$HELM_FOLDER/$HELM_RBAC_YAML
          helm init --service-account tiller --history-max 200
        fi
     else
        mkdir -p $INSTALL_FOLDER/$HELM_FOLDER/
        cp -f $SCRIPTS_FOLDER/$HELM_RBAC_YAML  $INSTALL_FOLDER/$HELM_FOLDER/

        kubectl create -f $INSTALL_FOLDER/$HELM_FOLDER/$HELM_RBAC_YAML
        helm init --service-account tiller --history-max 200
     fi
}


if [ "$EUID" -ne 0 ]
  then logMsg "Please run as root"
  exit
fi

