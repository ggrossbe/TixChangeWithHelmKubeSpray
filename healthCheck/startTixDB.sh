#!/bin/bash
CURRENT_FOLDER=`dirname $BASH_SOURCE`

echo "Current Folder $CURRENT_FOLDER"

cd $CURRENT_FOLDER

restartTixChange.sh

sleep 10

/opt/ca/TixChangeK8sDemo/em/setupEMSideConfigurations1.sh


