kubectl delete Network-Attachment-Definition -n nodejs-tix-mysql bridge-multus-cni
kubectl delete Network-Attachment-Definition -n nodejs-tix-mysql static-multus-cni
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
    "bridge": "br-08945aaa4eb6",
    "isDefaultGateway": true,
    "ipMasq": false,
    "hairpinMode": true,
      "ipam": {
        "type": "host-local",
        "subnet": "172.28.0.0/16",
        "rangeStart": "172.28.0.101",
        "rangeEnd": "172.28.0.105",
        "routes": [
          {
             "dst": "0.0.0.0/0",
             "gw": "172.28.0.10"
           }
        ],
        "dns": {
          "nameservers": [ "172.31.0.2" ]
        }
        "gateway": "172.22.0.10"
      }
    }'
EOF
