#jpmc
#TENANT_ID="EC5C5C89-0D23-4D44-B2A1-9989A528BF54"
#dxi_srik
TENANT_ID="8A8753D7-16E2-4151-AFE5-212444F9988F"
EPOCH_TIME=`date +%s%3N`
BUILD_NUMB=`cat /root/TixChangeWithHelmKubeSpray/CustomJenkinsEvent/currentBuildNumb`

echo "$TENANT_ID $EPOCH_TIME $UTC_TIME"

for i in 1 2 3 4
do

        echo "i is $i"

#notice, crit - 5, 2 -
SEVERITY="err"
ROUTER_MESSAGE="User:U54634: Configuration Change Detected on TIX-R2 Router. System resource changed. Router Unstable"
PRIORITY=5
UTC_TIME=`date -u '+%Y-%m-%dT%H:%M:%S+0000'`

if [ $i -eq 4 ]; then
        UTC_TIME=`date -u '+%Y-%m-%dT%H:%M:%S+0000'`
        SEVERITY="crit"
        ROUTER_MESSAGE="SEVERE Configuration Change Detected TIX-R2 Router Going Down"
        PRIORITY=5

fi

curl -v -k -X POST 'https://logs.dxi-na1.saas.broadcom.com/mdo/v2/aoanalytics/ingestion/syslog' \
-H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJzdWIiOiJTUklLQU5ULk5PT1JBTklAQlJPQURDT00uQ09NIiwidGlkIjo2ODMsImp0aSI6IjM0NmFjNjI5LTc0NTEtNDU2OS1hOWU4LThlY2NkNzAxODg2MiJ9.Sr8bM-5wpuAlG83mD1kJWE13vCKtuUN29piQlA2tlAOkMhSuZxILpwPX-xGIXBisUTV-POP3zbwCAYNvlig-hQ' \
-H 'Content-Type: application/json' \
-d '{

  "syslog_timestamp": "'$UTC_TIME'",
  "syslog_pri": "30",
  "syslog_ver": "1",
  "tenant_id": "'$TENANT_ID'",
  "syslog_message": "time=\"'$UTC_TIME'\" level=error msg=\"'"$ROUTER_MESSAGE"'\"",
  "syslog_severity": "'$SEVERITY'",
  "syslog_facility": "local7",
  "syslog_severity_code": "6",
  "syslog_facility_code": "7",
  "syslog_program": "152",
  "syslog_pid": "459489",
  "syslog_hostname": "192.20.0.3",
  "host": "192.20.0.3",
  "syslog_priority": "'$PRIORITY'"

}'
