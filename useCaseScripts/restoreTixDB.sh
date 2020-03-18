#!/bin/bash
UC_FOLDER=`dirname $BASH_SOURCE`

cd $UC_FOLDER/../

./mainInstaller.sh t

$UC_FOLDER/useCaseScripts/openAccessUCStatusTracker/UC2_StatusTracker.sh OFF
