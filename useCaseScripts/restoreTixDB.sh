#!/bin/bash

kubectl scale -n tixchange-v2 --replicas=1 deployment tix-mysql-deploy

sleep 15

cd /opt/ca/TixChangeK8sDemo/em/
./setupEMSideConfigurations2.sh DUMMY
