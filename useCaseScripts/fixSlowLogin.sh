#!/bin/bash
UC_FOLDER=`dirname $BASH_SOURCE`

. $UC_FOLDER/../config.ini

cd $UC_FOLDER/../selenium

#Automic recommendation confidence API

automicRecommendationScore () {
curl -v --request POST ''$OI_AUTOMIC_URL'' \
-H 'Authorization: Bearer '$OI_TOKEN'' \
-H 'Content-Type: application/json' \
-H 'Content-Type: text/plain' \
-d '{
  "tenantId": "'"$TENANT_NAME"'",
  "oobSchema": [
    {
      "deviceType": "",
      "alarmType": "Application",
      "metric_names": [
        "'"$APM_METRIC"'"
      ],
      "sourceProduct": "Application Performance Management",
      "automicJobWeightList": [
        {
          "automicJobName": "JOBP.AIOPS.RDS-CRASH.REMEDIATION",
          "oobRecommendationWeight": 9,
          "currentRecommendedWeight": 9,
          "triggeredCount": 0
        },
        {
          "automicJobName": "JOBP.AIOPS.LB-LICENSE.REMEDIATION",
          "oobRecommendationWeight": 1,
          "currentRecommendedWeight": 1,
          "triggeredCount": 0
        }
      ]
    }
  ]
}
'
}

#automicRecommendationScore

kubectl delete -f selenium-standalone-slow.yml -n selenium

#$UC_FOLDER/openAccessUCStatusTracker/UC2_StatusTracker.sh OFF
