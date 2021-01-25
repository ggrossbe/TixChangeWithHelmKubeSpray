echo "Chaos Testing - Introducing 500 error in v1 version of svc layer"
kubectl apply -f tixchange-ws-uc2-dest-rule-v1-v2-common.yml  -f chaos-testing-tixchange-ws-uc2-v1-abort.yml -n tixchange-v2

