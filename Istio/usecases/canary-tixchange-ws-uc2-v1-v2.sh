echo "****Canary Deployment (sort of) -  splitting traffic 60:40 between v1 and v2. May take up to 10 mts `date`"
echo ""
kubectl apply -f uc2/tixchange-ws-uc2-dest-rule-v1-v2-common.yml  -f uc2/canary-tixchange-ws-uc2-v1-v2.yml -n tixchange-v2

