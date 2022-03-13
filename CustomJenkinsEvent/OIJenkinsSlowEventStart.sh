#jpmc
TENANT_ID="EC5C5C89-0D23-4D44-B2A1-9989A528BF54"
#dxi_srik
TENANT_ID="8A8753D7-16E2-4151-AFE5-212444F9988F"
EPOCH_TIME=`date +%s%3N`
UTC_TIME=`date -u '+%Y-%m-%dT%H:%M:%S+0000'`
BUILD_NUMB=`cat /root/TixChangeWithHelmKubeSpray/CustomJenkinsEvent/currentBuildNumb`

echo "$TENANT_ID $EPOCH_TIME $UTC_TIME"


curl -v -k -X POST 'https://api.dxi-na1.saas.broadcom.com/ingestion' \
-H 'Content-Type: application/json' \
-d '{
  "documents": [
    {
      "header": {
        "tenant_id": "'$TENANT_ID'",
        "doc_type_id": "itoa_events_change_custom",
        "doc_type_version": "1",
        "product_id": "ao"
      },
      "body": [
        {
          "severity": "information",
          "summary": "Change event is generated with Jenkins build",
          "product": "Jenkins",
          "host": "lvnkdev010575.bpc.broadcom.net",
          "change_type": "NA_Provisioning",
          "event_unique_id": "Jenkins-b566ea26-ba92-4235-b08f-5bd7d1b6d3e7-'$EPOCH_TIME'",
          "ci_unique_id": "100533",
          "message": "BuildNumber : '$BUILD_NUMB', ApplicationName : \"TIXCHANGE Web\", GIT_COMMIT_MESSAGE : North America 5G provisioning Feature Flag Enabled, jenkinsPluginName : CAAPM",
          "timestamp": "'$UTC_TIME'",
          "status": "NEW"
        }
      ]
    }
  ]
}'
