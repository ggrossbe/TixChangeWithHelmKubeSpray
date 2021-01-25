echo "introducing 7s delay in svc layer calls"
kubectl apply -f uc2/tichange-ws-uc2-dest-rule-v1-v2.yml  -f uc2/delay-tichange-ws-uc2-virt-svc-v1.yml -n tixchange-v2
