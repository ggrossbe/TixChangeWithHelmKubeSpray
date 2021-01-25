echo "100% of traffic to v1.  May take up to 10 mts"
kubectl apply -f uc2/tichange-ws-uc2-dest-rule-v1-v2.yml  -f uc2/routing-tixchange-ws-uc2-virt-svc-routing-v1-100.yml -n tixchange-v2
