NSS=`kubectl get ns |awk '{print $1}'`

for NS in $NSS
do
	PODS=`kubectl get pods -n $NS |grep -v Runnin|awk '{print $1}'`
	for POD in $PODS; do echo $POD; kubectl delete pods $POD -n $NS; sleep 1; done
done
