echo "****Chaos Testing - introducing 7s delay in version v1 svc layer calls - `date`"
echo ""
kubectl apply -f uc2/tixchange-ws-uc2-dest-rule-v1-v2-common.yml  -f uc2/chaos-testing-tixchange-ws-uc2-v1-delay.yml -n tixchange-v2

