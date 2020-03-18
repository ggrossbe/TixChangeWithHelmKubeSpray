#!/bin/bash


OA_UC_STATUS_FOLDER=$HOME/OpenAccessUseCaseStatus
UC_STATUS=UC2_STATUS

if [ ! -d $OA_UC_STATUS_FOLDER ]; then
	/bin/mkdir -p $OA_UC_STATUS_FOLDER
fi

#need thisoption for include.sh
if [ X$1 == "XDONE" ]; then
	 echo "OFF" > $OA_UC_STATUS_FOLDER/$UC_STATUS
         exit
fi

if [ X$1 == "XON" ]; then
       #echo its on
	echo "ON" > $OA_UC_STATUS_FOLDER/$UC_STATUS
else
        #echo its off
	echo "OFF" > $OA_UC_STATUS_FOLDER/$UC_STATUS
fi


