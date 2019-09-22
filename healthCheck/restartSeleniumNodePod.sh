SELENIUM_NODE_PODS=`kubectl get pods -n selenium|grep node-chrome|grep -v NAME |grep -v grep |awk '{print $1}'`

for NODE_POD in $SELENIUM_NODE_PODS; 
do
	kubectl delete pod $NODE_POD -n selenium	
done
