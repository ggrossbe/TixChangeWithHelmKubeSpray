#!/bin/bash
UC_FOLDER=`dirname $BASH_SOURCE`

. $UC_FOLDER/../config.ini

cd $UC_FOLDER/../selenium


kubectl create -f selenium-standalone-slow.yml -n selenium

#$UC_FOLDER/openAccessUCStatusTracker/UC2_StatusTracker.sh OFF
