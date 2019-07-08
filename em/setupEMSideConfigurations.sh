EM_UNIVERSE1=EM_UNIVERSE1_NAME

createUniverse () {

curl -X POST \
  APM_SAAS_URL/apm/appmap/private/universe \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'Host: APM_SAAS_URL' \
  -H 'cache-control: no-cache' \
  -H 'content-length: 1321' \
  -d '{
  "universeId": null,
  "name": "$EM_UNIVERSE1",
  "items": [
    {
      "layer": {
        "value": "INFRASTRUCTURE"
      },
      "operator": "AND",
      "btCoverage": [
        {
          "operator": "AND",
          "attributeName": "k8s_project",
          "layer": {
            "value": "INFRASTRUCTURE"
          },
          "values": [
            "tixchange-v1",
            "ingress-nginx",
            "kube-system",
            "caaiops"
          ],
          "btCoverage": null
        }
      ]
    },
    {
      "operator": "OR",
      "attributeName": "hostname",
      "layer": {
        "value": "APM_INFRASTRUCTURE"
      },
      "values": [
        "node2"
      ],
      "btCoverage": null
    },
    {
      "operator": "AND",
      "attributeName": "k8s_project",
      "layer": {
        "value": "INFRASTRUCTURE"
      },
      "values": [
        "tixchange-v1",
        "ingress-nginx",
        "CA_INTERNAL_NULL",
        "kube-system",
        "caaiops"
      ],
      "btCoverage": null
    }
  ],
  "users": [],
  "includedVertices": [],
  "excludedVertices": [],
  "showEntry": false,
  "lastUpdate": 1562419946426,
  "joins": [
    {
      "layer": {
        "value": "ATC"
      }
    },
    {
      "layer": {
        "value": "APM_INFRASTRUCTURE"
      }
    }
  ]
}'

}


listUniverses () {

curl -X GET \
   'APM_SAAS_URL/apm/appmap/private/universe?skipCount=true&user=SAAS_USER_ID' \
   -H 'Accept: */*' \
   -H 'Authorization: Bearer APM_API_TOKEN' \
   -H 'Cache-Control: no-cache' \
   -H 'Connection: keep-alive' \
   -H 'Content-Type: application/json' \
   -H 'Host: APM_SAAS_URL'
}


createExpView () {

curl -X POST \
  APM_SAAS_URL/apm/appmap/private/settings/experience \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: APM_SAAS_URL' \
  -H 'cache-control: no-cache' \
  -H 'content-length: 650' \
  -H 'cookie: JSESSIONID=node01ixkinym4b32m4ejzkoq6h0ox44.node0; e63bcb68cc073a55f8914752561ebe6d=5d1e65f2b1552e35f8ea89735b7f5a13' \
  -b 'JSESSIONID=node01ixkinym4b32m4ejzkoq6h0ox44.node0; e63bcb68cc073a55f8914752561ebe6d=5d1e65f2b1552e35f8ea89735b7f5a13' \
  -d '{
  "type": "experience",
  "data": {
    "name": "EM_UNIVERSE1",
    "universeId": "$*",
    "filter": {
      "showEntry": false,
      "items": [
        {
          "operator": "AND",
          "attributeName": "transactionId",
          "layer": {
            "value": "ATC"
          },
          "values": null,
          "btCoverage": null
        }
      ]
    },
    "graphType": "HISTOGRAM",
    "groupAttributes": [
      {
        "layer": "ATC",
        "name": "applicationName"
      },
      {
        "layer": "ATC",
        "name": "name"
      }
    ],
    "owner": "SAAS_USER_ID",
    "public": true
  }
}'

}

runTrxnTrace () {
  curl -X POST \
  APM_SAAS_URL/apm/appmap/private/agentlist/starttrace \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'accept-encoding: gzip, deflate' \
  -H 'cache-control: no-cache' \
  -H 'cookie: e63bcb68cc073a55f8914752561ebe6d=5d1e65f2b1552e35f8ea89735b7f5a13' \
  -d '{
  "minTraceDuration": 3000,
  "traceSessionDuration": 60000,
  "agentList": [
    "SuperDomain|Experience Collector Host|DxC Agent|Logstash-APM-Plugin",
    "SuperDomain|TIX_WEB_INSTANCE1|tomcat|Agent",
    "SuperDomain|TIX_WS_INSTANCE1|tomcat|Agent"
  ]
}'
}


getUniverseIDFromName () {
  echo "Get Universe ID for $*"

  UNIVERSE_ID=`listUniverses |grep -A 1 "$*" |sed -e '1d'|sed -e 's/.*: "//g'|sed -e 's/"\,//g'`

  echo "Get Universe ID for $UNIVERSE_ID"
}


createMgmtModule () {
  echo "create mgt mod"
}


sleep 10
runTrxTrace
sleep 10
createUniverse 
echo "Created $EM_UNIVERSE1 Universe, Exp View and TixChangeWestCoast MgmtMod"

UNIVERSE_ID=`getUniverseIDFromName "$EM_UNIVERSE1"`

echo " UNIVERSE ID is $UNIVERSE_ID"

sleep 5
createExpView $UNIVERSE_ID
sleep 5
importMgmtModule

