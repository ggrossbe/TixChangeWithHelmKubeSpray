SELENIUM_POD=`kubectl get pods -n selenium |grep -v grep|grep -v NAME|awk '{print $1}'`

kubectl logs -f $SELENIUM_POD -n selenium

