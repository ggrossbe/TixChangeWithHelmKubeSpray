#
# get all alarms for a particular service
# and clear the alarm by alarm id
##

#jpmc
#TENANT_ID="EC5C5C89-0D23-4D44-B2A1-9989A528BF54"
#dxi_srik
TENANT_ID="8A8753D7-16E2-4151-AFE5-212444F9988F"
TO_EPOCH_TIME=`date +%s%3N`
FROM_EPOCH_TIME=$(($TO_EPOCH_TIME + 18000000))

echo "$TO_EPOCH_TIME -- $FROM_EPOCH_TIME"

UTC_TIME=`date -u '+%Y-%m-%dT%H:%M:%S+0000'`
BUILD_NUMB=`cat /root/TixChangeWithHelmKubeSpray/CustomJenkinsEvent/currentBuildNumb`
SVC_NAME="NA_Provisioning"
JQ="/root/TixChangeWithHelmKubeSpray/CustomJenkinsEvent/scripts/jq-linux64"

echo "$TENANT_ID $EPOCH_TIME $UTC_TIME"

OI_USER_TOKEN="eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJzdWIiOiJTUklLQU5ULk5PT1JBTklAQlJPQURDT00uQ09NIiwidGlkIjo2ODMsImp0aSI6IjM0NmFjNjI5LTc0NTEtNDU2OS1hOWU4LThlY2NkNzAxODg2MiJ9.Sr8bM-5wpuAlG83mD1kJWE13vCKtuUN29piQlA2tlAOkMhSuZxILpwPX-xGIXBisUTV-POP3zbwCAYNvlig-hQ"


ALARM_IDS=`curl -k -X  POST 'https://doi.dxi-na1.saas.broadcom.com/oi/v2/api/servicealarms/_search' \
  -H 'content-type: application/json' \
  -H 'x-authorizationview: VIEWALL' \
-H 'Authorization: Bearer '"$OI_USER_TOKEN"'' \
-d '{
	"pageNumber": 0,
  "pageSize": 50,
  "timeFrom": '$FROM_EPOCH_TIME',
  "timeTo": '$TO_EPOCH_TIME',
  "like": "",
  "sortCol": "",
  "deviceNames": [],
  "includeDeviceTypes": [],
  "excludeDeviceTypes": [],
  "groups": [],
  "services": [],
  "includeSeverity": [],
  "allOtherSeverity": false,
  "selectedAlarmId": null,
  "includeAlarmTypes": [],
  "excludeAlarmTypes": [],
  "showMaintenanceAlarms": false,
  "includeClosedAlarms": false,
  "customFilter": {
    "and": {
      "expressions": [
        {
          "or": {
            "expressions": [
              {
                "fieldDescription": "Service",
                "field": "service",
                "value": "'"$SVC_NAME"'",
                "condition": "equals"
              }
            ]
          }
        }
      ]
    }
  }
}' | $JQ -r '.alarms[].alarmId'`


clearServiceAlarm () {

ALARM_ID="$1"

curl  -v -k -X POST 'https://doi.dxi-na1.saas.broadcom.com/oi/v2/api/alarmactions/clear' \
-H 'Content-Type: application/json' \
-H 'x-authorizationview: VIEWALL' \
-H 'Authorization: Bearer '"$OI_USER_TOKEN"'' \
-d '{
"actionDetails": {
    "actionType": "clear",
    "target": [],
    "template": "",
    "locale": "en-US"
  },
  "alarmDetails": [
    {
      "alarmId": "'"$ALARM_ID"'",
      "alarmType": "Service",
      "message": "",
      "severity": "",
      "acknowledged": "false",
      "ticketID": "",
      "troubleShooter": "",
      "docTypeId": "itoa_alarms_service_sa",
      "docTypeVersion": "1",
      "actionsSupported": {
        "acknowledge": true,
        "unAcknowledge": true,
        "ticket": true,
        "assignment": true,
        "unAssignment": true,
        "clear": true,
        "visible": true,
        "invisible": true,
        "groupTicket": false,
        "assignGroupTicket": false,
        "unAssignGroupTicket": false
      },
      "actionOnServiceAlarm": true,
      "serviceName": "'"$SVC_NAME"'"
    }
  ]
}'
}

for ALARM_ID in $ALARM_IDS
do
	echo " 1 alarm is $ALARM_ID"
	clearServiceAlarm "$ALARM_ID"

done
