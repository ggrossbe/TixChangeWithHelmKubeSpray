
#!/bin/bash
UC_FOLDER=`dirname $BASH_SOURCE`

#kubectl delete deployment tix-mysql-deploy -n tixchange-v2
kubectl scale -n tixchange-v2 --replicas=0 deployment tix-mysql-deploy

$UC_FOLDER/openAccessUCStatusTracker/UC2_StatusTracker.sh ON
