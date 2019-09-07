POD_MYSQL=`kubectl get pods -n tixchange-v1|grep -v NAME|awk '{print $1}'|grep mysql`
POD_WEB=`kubectl get pods -n tixchange-v1|grep -v NAME|awk '{print $1}'|grep tix-web`
POD_WS=`kubectl get pods -n tixchange-v1|grep -v NAME|awk '{print $1}'|grep tix-ws`

kubectl delete pod $POD_MYSQL -n tixchange-v1
sleep 5
kubectl delete pod $POD_WS -n tixchange-v1
sleep 5
kubectl delete pod $POD_WEB -n tixchange-v1

