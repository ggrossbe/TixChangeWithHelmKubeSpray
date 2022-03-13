kubectl create -f /opt/ca/TixChangeK8sDemo/selenium/selenium-standalone-slow.yml -n selenium

sleep 10

kubectl get pods -n selenium|grep slow

echo "starting OI event"

/root/TixChangeWithHelmKubeSpray/CustomJenkinsEvent/OIJenkinsSlowEventStart.sh

echo ""

echo " waiting 5 mts before stopping slow login... "
sleep 300

/root/TixChangeWithHelmKubeSpray/CustomJenkinsEvent/OIJenkinsSlowEventEnd.sh
