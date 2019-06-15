#!/bin/bash
#BASEDIR=$(dirname "$0")
SCRIPTS_FOLDER=`dirname $BASH_SOURCE`

. $SCRIPTS_FOLDER/../config.ini

logData () {
        echo "$1"
        sleep 2
}


Usage() {
  echo "mainInstaller.sh [Options]"
  echo "Options: "
  echo "  -a : install all (K8s, UMA, TixChange, JMeter)"
  echo "  -p : run the pre-reqa"
  echo "  -k : install kubernetes"
  echo "  -u : install uma"
  echo "  -t : install tixChange"
  echo "  -j : install jmeter"

}


if [ "$EUID" -ne 0 ]
  then logMsg "Please run as root"
  exit
fi

