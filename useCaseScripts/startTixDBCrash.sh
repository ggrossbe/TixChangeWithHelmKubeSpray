
#!/bin/bash
UC_FOLDER=`dirname $BASH_SOURCE`

kubectl delete deployment tix-mysql-deploy -n tixchange-v2

$UC_FOLDER/openAccessUCStatusTracker/UC2_StatusTracker.sh ON
