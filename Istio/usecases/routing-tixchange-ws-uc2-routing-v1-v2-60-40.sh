echo "splitting traffic 60:40 between v1 and v2. May take up to 10 mts"
kubectl apply -f uc2/tixchange-ws-uc2-dest-rule-v1-v2.yml  -f uc2/routing-tixchange-ws-uc2-virt-svc-v1-v2-60-40.yml -n tixchange-v2
