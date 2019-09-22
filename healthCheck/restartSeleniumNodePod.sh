SELENIUM_NODE_PODS=`get pod -n selenium|grep node-chrome|grep -v NAME |grep -v grep |awk '{print $1}`

for NODE_POD in $SELENIUM_NODE_PODS; 
do
	kubectl delete pod $NODE_POD -n selenium	
done
