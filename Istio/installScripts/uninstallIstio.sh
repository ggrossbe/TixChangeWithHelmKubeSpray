 istioctl manifest generate --set profile=demo | kubectl delete --ignore-not-found=true -f -

kubectl delete namespace istio-system

kubectl label namespace tixchange-v2 istio-injection-

