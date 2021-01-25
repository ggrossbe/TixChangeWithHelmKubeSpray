echo "Blue-Green Deployment - 100% of traffic to v1.  May take up to 10 mts"
kubectl apply -f uc2/tixchange-ws-uc2-dest-rule-v1-v2-common.yml  -f uc2/blue-green-tixchange-ws-uc2-v1-v2.yml -n tixchange-v2

