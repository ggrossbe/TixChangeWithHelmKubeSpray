#!/bin/bash


SELENIUM_POD=`/usr/local/bin/kubectl get pods -n selenium |grep -v grep|grep -v NAME|awk '{print $1}'`
UC_STATUS=UC1_STATUS

OA_UC_STATUS_FOLDER=$HOME/OpenAccessUseCaseStatus

IS_SLOW_LOGIN_UC=`/usr/local/bin/kubectl logs  --tail=30  $SELENIUM_POD -n selenium|grep -i  "running slow UC1"`

if [ ! -d $OA_UC_STATUS_FOLDER ]; then
	/bin/mkdir -p $OA_UC_STATUS_FOLDER
fi

#echo $IS_SLOW_LOGIN

#need thisoption for includ.sh
if [ X$1 == "XDONE" ]; then
	 echo "OFF" > $OA_UC_STATUS_FOLDER/$UC_STATUS
         exit
fi

if [ X$IS_SLOW_LOGIN_UC != "X" ]; then
       #echo its on
	echo "ON" > $OA_UC_STATUS_FOLDER/$UC_STATUS
else
        #echo its off
	echo "OFF" > $OA_UC_STATUS_FOLDER/$UC_STATUS
fi


sleep 30

IS_SLOW_LOGIN_UC=`/usr/local/bin/kubectl logs  --tail=30  $SELENIUM_POD -n selenium|grep -i  "running slow UC1"`

if [ X$IS_SLOW_LOGIN_UC != "X" ]; then
       #echo its on
        echo "ON" > $OA_UC_STATUS_FOLDER/$UC_STATUS
else
        #echo its off
        echo "OFF" > $OA_UC_STATUS_FOLDER/$UC_STATUS
fi
