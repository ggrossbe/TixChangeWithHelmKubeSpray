ISTIO_VER=1.8.3
TIX_NS=tixchange-v2

export PATH=/root/TixChangeWithHelmKubeSpray/Istio/istio-$ISTIO_VER/bin:$PATH

cd /root/TixChangeWithHelmKubeSpray/Istio

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=$ISTIO_VER TARGET_ARCH=x86_64 sh -

cd /root/TixChangeWithHelmKubeSpray/Istio/istio-$ISTIO_VER/

istioctl install --set profile=demo -y

kubectl label namespace $TIX_NS istio-injection=enabled

sleep 10

kubectl apply -f samples/addons

sleep 10

echo "deploying tix ws v2 - may take up to 30 sec"

kubectl create -f /root/TixChangeWithHelmKubeSpray/Istio/tixchange/tix_ws-deploy_v2.yaml -n $TIX_NS

sleep 20

echo "restarting all pods - may take up to 90 sec"

PODS=`kubectl get pods -n $TIX_NS| awk '{print $1}'|grep -v NAME |grep -v apmia`

for POD in $PODS
do
  kubectl delete pods $POD -n $TIX_NS
done


sleep 60

nohup istioctl dashboard --address 10.74.242.214 kiali &
nohup istioctl dashboard --address 10.74.242.214 prometheus &

echo " pls allow some time for things to settle"

echo "pls add $PATH to you profile"

