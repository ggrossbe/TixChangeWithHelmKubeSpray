#!/bin/bash
BASEDIR=$(dirname "$0")

ls $BASEDIR/config.ini
. $BASEDIR/config.ini

logData () {
        echo "$1"
        sleep 2
}

