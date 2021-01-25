echo "Introducing 500 erro in svc layer"
kubectl apply -f uc2/tichange-ws-uc2-dest-rule-v1-v2.yml  -f uc2/abort-tichange-ws-uc2-virt-svc-v1.yml -n tixchange-v2

