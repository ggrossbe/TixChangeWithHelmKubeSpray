#!/bin/bash

cd /root/MobileProvisioningService

git pull origin master

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

IS_ENABLED=`curl -s https://github.gwd.broadcom.net/ns657061/MobileProvisioningService//blob/master/config/NA_Feature_Flag.config|grep 5G_Pro|grep enabled`

if [ X"$IS_ENABLED" == X ]; then
    sed -i 's/enable/enabled/g' config/NA_Feature_Flag.config
    sed -i 's/disabled/enabled/g' config/NA_Feature_Flag.config
else
    sed -i 's/enabled/enable/g' config/NA_Feature_Flag.config
fi

git add config/NA_Feature_Flag.config
git commit -m "North America 5G provisioning Feature Flag Enabled"

git push origin master
