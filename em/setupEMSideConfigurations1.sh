EM_UNIVERSE1=EM_UNIVERSE_NAME
VERSION="VERSION_VAL"

# need to setup both EM alert config here as filter doesnt work
configMySqlMetricAndAlertMapping () {

curl -v -k -X POST \
  APM_SAAS_URL/apm/appmap/ats/extension/configure \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: APM_SAAS_URL_NO_PROTO' \
  -H 'cache-control: no-cache' \
  -d '{
   "id":"REAL_DB1",
   "layer": "INFRASTRUCTURE",
   "version": "'$VERSION'",
   "icons":{
   },

 "metricSpecifiers":{
      "MYSQL_DB":[
         {
            "metricSpecifier":{
               "format":"MYSQL|<Hostname>|jtixchange",
               "type":"EXACT"
            },
            "agentSpecifier":{
               "format":"<agent>",
               "type":"EXACT"
            },
            "section":"Database Metrics",
            "metricNames":[
               "Availability"
            ],
            "filter":{
                "Hostname": "TIXCHANGE_MYSQL_RDS_HOSTNAME1"
            }
         },
         {
            "metricSpecifier":{
               "format":"MYSQL|<Hostname>|jtixchange|Operations",
               "type":"EXACT"
            },
            "agentSpecifier":{
               "format":"<agent>",
               "type":"EXACT"
            },
            "section":"Database Metrics",
            "metricNames":[
               "Total Queries", "Total Requests", "Total Deletes",  "Total Inserts"
            ],
            "filter":{
                "Hostname": "TIXCHANGE_MYSQL_RDS_HOSTNAME1"
            }
         },
         {
            "metricSpecifier":{
               "format":"MYSQL|<Hostname>|jtixchange",
               "type":"EXACT"
            },
            "agentSpecifier":{
               "format":"<agent>",
               "type":"EXACT"
            },
            "section":"Database Metrics",
            "metricNames":[
                "Availability"
            ],
            "filter":{
                    "Hostname": "TIXCHANGE_MYSQL_RDS_HOSTNAME2"
            }
         },
         {
            "metricSpecifier":{
               "format":"MYSQL|<Hostname>|jtixchange|Operations",
               "type":"EXACT"
            },
            "agentSpecifier":{
               "format":"<agent>",
               "type":"EXACT"
            },
            "section":"Database Metrics",
            "metricNames":[
               "Total Queries", "Total Requests", "Total Deletes",  "Total Inserts"
            ],
            "filter":{
                "Hostname": "TIXCHANGE_MYSQL_RDS_HOSTNAME2"
            }
         }
      ]
   },
   "alertMappings":{
        "MYSQL_DB":[
      "MYSQL|<Hostname>|jtixchange|*",
      "MYSQL|<Hostname>|jtixchange:Availability"
      ]
   },
   "perspectives":[
   ]
}'
}


configInferredDBMetricAndAlertMapping () {

curl -v  -k -X POST \
  APM_SAAS_URL/apm/appmap/ats/extension/configure \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: APM_SAAS_URL_NO_PROTO' \
  -H 'cache-control: no-cache' \
  -d '{
   "id":"INFRRED_DB1",
   "layer": "APPLICATION",
   "version": "'$VERSION'",
   "icons":{
   },

   "metricSpecifiers":{

    "INFERRED_DATABASE":[
         {
            "metricSpecifier":{
               "format":"Backends|<databasename>",
               "type":"EXACT"
            },
            "agentSpecifier":{
               "format":"TxChangeSvc_UC1|tomcat|Agent",
               "type":"EXACT"
            },
            "section":"Database Metrics",
            "metricNames":[
               "Responses Per Interval"
            ],
            "filter":{
                "Hostname": "TIXCHANGE_MYSQL_RDS_HOSTNAME1"
            }
         },
         {
            "metricSpecifier":{
               "format":"Backends|<databasename>",
               "type":"EXACT"
            },
            "agentSpecifier":{
               "format":"TxChangeSvc_UC2|tomcat|Agent",
               "type":"EXACT"
            },
            "section":"Database Metrics",
            "metricNames":[
               "Responses Per Interval"
            ],
            "filter":{
                "Hostname": "TIXCHANGE_MYSQL_RDS_HOSTNAME2"
            }
         }
      ]
   },
   "alertMappings":{

   "INFERRED_DATABASE_WITH_AGENT":[
     "TxChangeSvc_UC1|tomcat|Agent|Backends|<databasename>:Responses Per Interval",
     "TxChangeSvc_UC2|tomcat|Agent|Backends|<databasename>:Responses Per Interval"
      ]
   },
   "perspectives":[
   ]
}'

}


createUniverse () {

curl -k -s  -X POST \
   APM_SAAS_URL/apm/appmap/private/universe \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'Host: APM_SAAS_URL_NO_PROTO' \
  -H 'cache-control: no-cache' \
  -d '
  {
  "universeId": null,
  "name": "'$EM_UNIVERSE1'",
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
            "monitor",
            "caaiops",
            "aws"
          ],
          "btCoverage": null
        }
      ]
    },
    {
      "operator": "AND",
      "attributeName": "name",
      "layer": {
        "value": "ATC"
      },
      "values": [
        "Apps|TIXCHANGE Web|URLs|shop/signon.shtml",
        "/jtixchange_web/shop/signon.shtml",
        "Apps|TIXCHANGE Web|URLs|shop/signoff.shtml",
        "/jtixchange_web/shop/viewItem.shtml",
        "/jtixchange_web/shop/newOrder.shtml",
        "/jtixchange_web/shop/newOrderForm.shtml",
        "/jtixchange_web/shop/viewProduct.shtml",
        "Apps|TIXCHANGE Web|URLs|shop/newOrder.shtml",
        "Apps|TIXCHANGE Web|URLs|shop/addItemToCart.shtml",
        "Apps|TIXCHANGE Web|URLs|shop/signonForm.shtml",
        "DATABASE : jtixchange on TIXCHANGE_MYSQL_RDS_HOSTNAME-3306 (MySQL DB)",
        "/jtixchange_web/shop/addItemToCart.shtml",
        "Apps|pricingService|pricingGatewayCompute",
        "Apps|TIXCHANGE Web|URLs|shop/viewCategory.shtml",
        "Apps|TIXCHANGE Web|URLs|shop/checkout.shtml",
        "Apps|TIXCHANGE Web|URLs|shop/viewProduct.shtml",
        "Apps|TIXCHANGE Services|URLs|/JTiXChange_Services/services/",
        "/jtixchange_web/shop/viewCategory.shtml",
        "Apps|TIXCHANGE Web|URLs|shop/viewItem.shtml",
        "Apps|TIXCHANGE Web|URLs|shop/newOrderForm.shtml",
        "node1",
        "/jtixchange_web/shop/checkout.shtml",
        "node2",
        "node3",
        "/jtixchange_web/shop/signonForm.shtml",
        "/jtixchange_web/shop/index.shtml",
        "service.jtixchange.com|getAuthAccount",
        "ActionServlet|service",
        "Apps|TIXCHANGE Web|URLs|shop/index.shtml"
      ],
      "btCoverage": null
    },
    {
      "operator": "OR",
      "attributeName": "hostname",
      "layer": {
        "value": "APM_INFRASTRUCTURE"
      },
      "values": [
        "node2",
        "node3",
        "node1"
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
    },
    {
      "operator": "OR",
      "attributeName": "type",
      "layer": {
        "value": "INFRASTRUCTURE"
      },
      "values": [
        "AWS Account",
        "AWS Service Type",
        "AWS_RDS",
        "AWS Region",
        "AWS_AutoScaling",
        "AWS_LAMBDA",
        "AWS_S3"
      ],
      "btCoverage": null
    }
  ],
  "users": [],
  "includedVertices": [],
  "excludedVertices": [],
  "showEntry": false,
  "lastUpdate": 1584825448975,
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

curl -k -s -X GET \
   'APM_SAAS_URL/apm/appmap/private/universe?skipCount=true&user=SAAS_USER_ID' \
   -H 'Accept: */*' \
   -H 'Authorization: Bearer APM_API_TOKEN' \
   -H 'Cache-Control: no-cache' \
   -H 'Connection: keep-alive' \
   -H 'Content-Type: application/json' \
   -H 'Host: APM_SAAS_URL_NO_PROTO'
}


createExpView () {

curl -k  -s -X POST \
  APM_SAAS_URL/apm/appmap/private/settings/experience \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: APM_SAAS_URL_NO_PROTO' \
  -H 'cache-control: no-cache' \
  -d '{
  "type": "experience",
  "data": {
    "name": "'$EM_UNIVERSE1'",
    "universeId": "'$*'",
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
  curl -k -s -X POST \
  APM_SAAS_URL/apm/appmap/private/agentlist/starttrace \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -H 'cookie: e63bcb68cc073a55f8914752561ebe6d=5d1e65f2b1552e35f8ea89735b7f5a13' \
  -d '{
  "minTraceDuration": 3,
  "traceSessionDuration": 60000,
  "agentList": [
    "SuperDomain|Experience Collector Host|DxC Agent|Logstash-APM-Plugin",
    "SuperDomain|TxChangeWeb_UC1|tomcat|Agent",
    "SuperDomain|TxChangeSvc_UC1|tomcat|Agent"
  ]
}'
}


getCustomPerspectiveIDs () {

  getAllCustomPerspectives | INSTALLATION_FOLDER/EM_FOLDER/jq-linux64|grep -B 1 "$*" |sed -e 's/.*: "//g'|sed -e 's/"\,//g'|sed -e 's/'"$*"'//g'|sed -e 's/\-\-//g'

}

getUniverseIDFromName () {

  listUniverses |INSTALLATION_FOLDER/EM_FOLDER/jq-linux64|grep -A 1 "$*" |sed -e '1d'|sed -e 's/.*: "//g'|sed -e 's/"\,//g'

}


isMgmtModulePresent () {
  MGMT_MOD=`curl -v -k -s -X GET   APM_SAAS_URL/apm/appmap/private/mgmtmod   -H 'Accept: */*'   -H 'Authorization: Bearer APM_API_TOKEN'   -H 'Cache-Control: no-cache'   -H 'Connection: keep-alive'   -H 'Content-Type: application/json'   -H 'Host: APM_SAAS_URL_NO_PROTO'      -H 'cache-control: no-cache'|grep -w "$*"`

  if [ X"$MGMT_MOD" == "X" ]; then
    echo "no";
  else
    echo "yes";
  fi
}


importMgmtModule () {
  echo "import mgt mod"

  MGMT_MODULE="$*"
  IS_PRESENT=`isMgmtModulePresent $MGMT_MODULE`

  # not present
  if [ "$IS_PRESENT" == "no" ]; then
  echo "MGMT Module $MGMT_MODULE importing"

   curl -k -s -X POST -H "Authorization: Bearer APM_API_TOKEN"  -F "file=@INSTALLATION_FOLDER/EM_FOLDER/$MGMT_MODULE" APM_SAAS_URL/apm/atc/api/private/mgmtmod/import

  fi
}

correlateAppToInfraForDBVertex () {
  SQL_POD=`kubectl get pods -n tixchange-v1 |grep $1 |awk '{print $1}'`

  echo "SQL POD $SQL_POD"
  if [ X"$SQL_POD" != "X" ]; then

     CONTAINER_ID=`kubectl describe pod  $SQL_POD -n tixchange-v1 |sed -n '/tix-mysql:/{n;p}'|grep "Container ID" |awk '{print $3}'|sed 's/docker:\/\///g'`
     echo "Container ID is $CONTAINER_ID"
  fi

  if [ X"$CONTAINER_ID" != "X" ]; then
    VERTEX_ID=`getMySQLVertexID |./jq-linux64|grep "\"id\""|awk '{ print $2 }'|sed 's/"//g'`

    echo "VERTEX_ID $VERTEX_ID"

    if [ X"$VERTEX_ID" != "X" ]; then
       patchAVertex $VERTEX_ID $CONTAINER_ID
    fi

  fi

}


getMySQLVertexID () {

curl -k -s -X POST \
  APM_SAAS_URL/apm/appmap/graph/vertex \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: APM_SAAS_URL_NO_PROTO' \
  -H 'cache-control: no-cache' \
  -d '{
    "includeStartPoint": false,
    "orItems":[
        {
            "andItems":[
                {
                     "itemType" : "attributeFilter",
                     "attributeName": "Type",
                     "attributeOperator": "MATCHES",
                     "values": [ "INFERRED_DATABASE*" ]
                 },
                 {
                     "itemType" : "attributeFilter",
                     "attributeName": "Hostname",
                     "attributeOperator": "MATCHES",
                     "values": [ "TIXCHANGE_MYSQL_RDS_HOSTNAME*" ]
                 }
            ]
        }
    ]
}'

}


getApmiaMysqlVertexID () {

curl -k -s -X POST \
  APM_SAAS_URL/apm/appmap/graph/vertex \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: APM_SAAS_URL_NO_PROTO' \
  -H 'cache-control: no-cache' \
  -d '{
    "includeStartPoint": false,
    "orItems":[
        {
            "andItems":[
                {
                     "itemType" : "attributeFilter",
                     "attributeName": "Type",
                     "attributeOperator": "MATCHES",
                     "values": [ "MYSQL_DB*" ]
                 },
                 {
                     "itemType" : "attributeFilter",
                     "attributeName": "Hostname",
                     "attributeOperator": "MATCHES",
                     "values": [ "TIXCHANGE_MYSQL_RDS_HOSTNAME*" ]
                 }
            ]
        }
    ]
}'

}

getHostVertexID () {

curl -k -s -X POST \
  APM_SAAS_URL/apm/appmap/graph/vertex \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: APM_SAAS_URL_NO_PROTO' \
  -H 'cache-control: no-cache' \
  -d '{
    "includeStartPoint": false,
    "orItems":[
        {
            "andItems":[
                {
                     "itemType" : "attributeFilter",
                     "attributeName": "Type",
                     "attributeOperator": "MATCHES",
                     "values": [ "HOST*" ]
                 },
                 {
                     "itemType" : "attributeFilter",
                     "attributeName": "Hostname",
                     "attributeOperator": "MATCHES",
                     "values": [ "node2*" ]
                 }
            ]
        }
    ]
}'

}

patchBTVerticesWithAppName () {

    VERTEX_IDS=`getBTVertexIDs |./jq-linux64|grep "\"id\""|awk '{ print $2 }'|sed 's/"//g'`

    for VERTEX_ID in $VERTEX_IDS
    do
        echo "BT VERTICES are $VERTEX_ID"

        if [ X"$VERTEX_ID" != "X" ]; then
          patchABTVertex $VERTEX_ID
        fi
    done
}


getBTVertexIDs () {

curl -k -s -X POST \
  APM_SAAS_URL/apm/appmap/graph/vertex \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: APM_SAAS_URL_NO_PROTO' \
  -H 'cache-control: no-cache' \
  -d '{
    "includeStartPoint": false,
    "orItems":[
        {
            "andItems":[
                {
                     "itemType" : "attributeFilter",
                     "attributeName": "Type",
                     "attributeOperator": "MATCHES",
                     "values": [ "BUSINESSTRANSACTION*" ]
                 }
            ]
        }
    ]
}'

}

## Dont need this in em/setupEMSideConfigurations2.sh
patchABTVertex () {
curl -k -s -X PATCH \
  APM_SAAS_URL/apm/appmap/graph/vertex/ \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: APM_SAAS_URL_NO_PROTO' \
  -H 'cache-control: no-cache' \
  -d ' { "items" : [
                {
                                "id":"'$1'",
                                "attributes": {
                                "Application Name":["TIXCHANGE Web"]
        }
    }
  ]
}'
}

PatchHostToApmiaContainsReln () {
	HOST_VERTEX_ID=`getHostVertexID|./jq-linux64|grep "\"id\""|awk '{ print $2 }'|sed 's/"//g'`
	APMIA_VERTEX_ID=`getApmiaMysqlVertexID |./jq-linux64|grep "\"id\""|awk '{ print $2 }'|sed 's/"//g'`

	echo "Patching for Contains  in host_vertex_id is $HOST_VERTEX_ID apmia vertex id $APMIA_VERTEX_ID"

   if [ X"$HOST_VERTEX_ID" != "X" ] && [ X"$APMIA_VERTEX_ID" != "X" ]; then
       patchAVertexWithContainsReln $HOST_VERTEX_ID cor.containsreln1.contains.from
       patchAVertexWithContainsReln $APMIA_VERTEX_ID cor.containsreln1.contains.to
    fi
}



patchAVertexWithContainsReln () {
curl -k -s -X PATCH \
  APM_SAAS_URL/apm/appmap/graph/vertex/ \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: APM_SAAS_URL_NO_PROTO' \
  -H 'cache-control: no-cache' \
  -d ' { "items" : [
                {
                                "id":"'$1'",
                                "attributes": {
                                "'$2'":["contains"]
        }
    }
  ]
}'
}



patchAVertex () {
curl -k -s -X PATCH \
  APM_SAAS_URL/apm/appmap/graph/vertex/ \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: APM_SAAS_URL_NO_PROTO' \
  -H 'cache-control: no-cache' \
  -d ' { "items" : [
                {
                                "id":"'$1'",
                                "attributes": {
                                "containerId":["'$2'"]
        }
    }
  ]
}'
}


deleteCustomPerspective () {
   echo "delete perspective"

   curl -v -k -X  DELETE \
   APM_SAAS_URL/apm/atc/api/private/grouping/$1 \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H  'Content-Type: application/json' \
  -d  ''
}

getAllCustomPerspectives () {

curl -k -s -X GET \
   'APM_SAAS_URL/apm/atc/api/private/grouping' \
   -H 'Accept: */*' \
   -H 'Authorization: Bearer APM_API_TOKEN' \
   -H 'Content-Type: application/json' \
   -d ''
}


createCustomInfraPerspectives () {

  echo "creating Custom Infra Perspective"

curl -v -k -X POST \
  APM_SAAS_URL/apm/atc/api/private/grouping \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H  'Content-Type: application/json' \
  -d  '{
     "id": "0",
     "name": "INDUSTRY",
     "groupBy": [
       {
         "layer": "INFRASTRUCTURE",
         "attributeName": "type"
       },
       {
         "layer": "INFRASTRUCTURE",
         "attributeName": "AWS_Vpc"
       },
       {
         "layer": "INFRASTRUCTURE",
         "attributeName": "_BY_LAYER_OBJECT_ AWS_EC2"
       },
       {
         "layer": "INFRASTRUCTURE",
         "attributeName": "k8s_project"
       },
       {
         "layer": "ATC",
         "attributeName": "applicationName"
       }
     ],
     "public": true,
     "automaticGrouping": false,
     "layers": [
       "INFRASTRUCTURE"
     ],
     "owner": "SAAS_USER_ID"
   }'


}

createCustomAppPerspectives () {

  echo "creating Custom App Perspective"

curl -v -k -X POST \
  APM_SAAS_URL/apm/atc/api/private/grouping \
  -H 'Authorization: Bearer APM_API_TOKEN' \
  -H  'Content-Type: application/json' \
  -d  '{
     "id": "0",
       "name": "INDUSTRY",
       "groupBy": [
         {
           "layer": "ATC",
           "attributeName": "endUser"
         },
         {
           "layer": "INFRASTRUCTURE",
           "attributeName": "_BY_LAYER_OBJECT_ AWS_EC2"
         },
         {
           "layer": "INFRASTRUCTURE",
           "attributeName": "_BY_LAYER_OBJECT_ HOST"
         },
         {
           "layer": "INFRASTRUCTURE",
           "attributeName": "k8s_project"
         },
         {
           "layer": "ATC",
           "attributeName": "applicationName"
         }
       ],
       "public": true,
       "automaticGrouping": false,
       "layers": [
         "ATC"
       ],
       "owner": "SAAS_USER_ID"
     }'

}


echo "running setupEMSideConfigurations1.sh"

UNIVERSE_ID=`getUniverseIDFromName "$EM_UNIVERSE1"`

echo " UNIVERSE ID for  $EM_UNIVERSE1 is $UNIVERSE_ID"

runTrxnTrace
sleep 30

#patchBTVerticesWithAppName

#sleep 15

# if universe does not exist
if [ X"$UNIVERSE_ID" == "X" ]; then
  createUniverse

  sleep 10
  UNIVERSE_ID=`getUniverseIDFromName "$EM_UNIVERSE1"`
  echo "Created $EM_UNIVERSE1 Universe, Exp View and TixChange MgmtMod - UNIV ID $UNIVERSE_ID"
  createExpView $UNIVERSE_ID

fi

sleep 5
importMgmtModule "TixChangeUC1.jar"
sleep 5
importMgmtModule "TixChangeUC2.jar"
sleep 3
importMgmtModule "AWS.jar"
sleep 3
importMgmtModule "SaaSMM.jar"
sleep 3
importMgmtModule "MobileTixChange.jar"


echo "running Trxn Trace pls have patience"
runTrxnTrace
sleep 30
runTrxnTrace

correlateAppToInfraForDBVertex tix-mysql
#correlateAppToInfraForDBVertex apmia-mysql

#PatchHostToApmiaContainsReln


sleep 10

configMySqlMetricAndAlertMapping
sleep 1
configInferredDBMetricAndAlertMapping

##First delete custom persp before creating otherwise it will create duplicate persp.

PERSP_IDS=`getCustomPerspectiveIDs "INDUSTRY"`

echo "Custom Perps INDUSTRY and ID's are $PERSP_IDS"

for PERSP_ID in $PERSP_IDS
do
  echo "######deleting perspective id $PERSP_ID"
  sleep 1
  deleteCustomPerspective $PERSP_ID

done


sleep 2
createCustomAppPerspectives
sleep 2
createCustomInfraPerspectives
