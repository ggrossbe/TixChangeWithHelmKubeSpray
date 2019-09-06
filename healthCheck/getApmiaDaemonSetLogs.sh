#collect APMIA Daemonset logs from all the pods
# bundles it as APM.log.tar
# @author - srikant.noorani@broadcom.com

CAAPM_PODS=`kubectl get pods -n caapm | grep -v NAME| awk '{print $1}'`; for POD in $CAAPM_PODS; do kubectl logs $POD -n caapm > $POD.logs; done; tar cvf ApmiaDaemonSet.log.tar *.logs

echo "mail ApmiaDaemonSet.log.tar to CA/BC"
