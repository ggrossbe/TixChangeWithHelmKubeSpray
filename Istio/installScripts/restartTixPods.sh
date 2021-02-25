echo "restarting all pods - may take up to 90 sec"

PODS=`kubectl get pods -n tixchange-v2| awk '{print $1}'|grep -v NAME |grep -v apmia`

for POD in $PODS
do
  kubectl delete pods $POD -n tixchange-v2
done
