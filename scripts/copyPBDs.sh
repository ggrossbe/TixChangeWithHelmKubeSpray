#! /bin/bash
while [ ! -d /opt/wily ]; do sleep 5; echo "one time pbd" >> /opt/oneTimePBD.txt;done; cp -f $TEMP_PBD_DIR/* /opt/wily/core/config/hotdeploy/
