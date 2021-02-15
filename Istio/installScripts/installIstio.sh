export PATH=/root/TixChangeWithHelmKubeSpray/Istio/istio-1.9.0//bin:$PATH

cd /root/TixChangeWithHelmKubeSpray/Istio/istio-1.9.0/

istioctl install --set profile=demo -y

kubectl label namespace tixchange-v2 istio-injection=enabled

sleep 10

kubectl apply -f samples/addons

sleep 10

PODS=`kubectl get pods -n tixchange-v2| awk '{print $1}'|grep -v NAME |grep -v apmia`

for POD in $PODS
do
  kubectl delete pods $POD -n tixchange-v2
done

sleep 10

nohup istioctl dashboard --address 10.74.242.214 kiali &
nohup istioctl dashboard --address 10.74.242.214 prometheus &



