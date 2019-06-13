#!/bin/bash
#BASEDIR=$(dirname "$0")
SCRIPTS_FOLDER=`dirname $BASH_SOURCE`

. $SCRIPTS_FOLDER/../config.ini

logData () {
        echo "$1"
        sleep 2
}

