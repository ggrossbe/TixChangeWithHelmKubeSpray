echo Stopping the Router

/root/TixChangeWithHelmKubeSpray/CustomJenkinsEvent/scripts/stopGNS3Router.sh
sleep 1
/root/TixChangeWithHelmKubeSpray/CustomJenkinsEvent/scripts/SpectrumNCM.sh

/root/TixChangeWithHelmKubeSpray/CustomJenkinsEvent/scripts/logAnalytics.sh

echo Restoring the Router

sleep 1800

/root/TixChangeWithHelmKubeSpray/CustomJenkinsEvent/scripts/restoreGNS3Router.sh
