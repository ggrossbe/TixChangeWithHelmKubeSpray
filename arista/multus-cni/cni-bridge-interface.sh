kubectl delete Network-Attachment-Definition -n nodejs-tix-mysql bridge-multus-cni
sleep 5

cat <<EOF | kubectl create -f -
apiVersion: "k8s.cni.cncf.io/v1"
kind: NetworkAttachmentDefinition
metadata:
  name: bridge-multus-cni
  namespace: nodejs-tix-mysql
spec:
  config: '{
    "cniVersion": "0.3.1",
    "name": "net1",
    "type": "bridge",
    "bridge": "mynet0",
    "isDefaultGateway": true,
    "forceAddress": false,
    "ipMasq": true,
    "hairpinMode": true,
      "ipam": {
        "type": "host-local",
        "subnet": "172.22.0.0/16",
        "rangeStart": "172.22.0.100",
        "rangeEnd": "172.22.0.110",
        "routes": [
          { "dst": "0.0.0.0/0" }
        ],
        "gateway": "172.22.0.10"
      }
    }'
EOF
