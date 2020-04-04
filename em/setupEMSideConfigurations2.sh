EM_UNIVERSE1=EM_UNIVERSE_NAME
VERSION="VERSION_VAL"

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
   "id":"REAL_DB2",
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
                    "Hostname": "TIXCHANGE_MYSQL_RDS_HOSTNAME"
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
                "Hostname": "TIXCHANGE_MYSQL_RDS_HOSTNAME"
            }
         }
      ]
   },
   "alertMappings":{
        "MYSQL_DB_WITH_AGENT":[
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
   "id":"INFRRED_DB2",
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
               "format":"TxChangeSvc_UC2|tomcat|Agent",
               "type":"EXACT"
            },
            "section":"Database Metrics",
            "metricNames":[
               "Responses Per Interval"
            ],
            "filter":{
                "Hostname": "TIXCHANGE_MYSQL_RDS_HOSTNAME"
            }
         }
      ]
   },
   "alertMappings":{

   "INFERRED_DATABASE_WITH_AGENT":[
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
  -d '{
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
            "tixchange-v2",
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
        "tixchange-v2",
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
        "name": "Application Name"
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
    "SuperDomain|TxChangeWeb_UC2|tomcat|Agent",
    "SuperDomain|TxChangeSvc_UC2|tomcat|Agent"
  ]
}'
}


getUniverseIDFromName () {

  listUniverses |INSTALLATION_FOLDER/EM_FOLDER/jq-linux64|grep -A 1 "$*" |sed -e '1d'|sed -e 's/.*: "//g'|sed -e 's/"\,//g'

}


isMgmtModulePresent () {
  MGMT_MOD=`curl -k -s -X GET   APM_SAAS_URL/apm/appmap/private/mgmtmod   -H 'Accept: */*'   -H 'Authorization: Bearer APM_API_TOKEN'   -H 'Cache-Control: no-cache'   -H 'Connection: keep-alive'   -H 'Content-Type: application/json'   -H 'Host: APM_SAAS_URL_NO_PROTO'      -H 'cache-control: no-cache'|grep "$*"`

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
  SQL_POD=`kubectl get pods -n tixchange-v2 |grep $1 |awk '{print $1}'`

  echo "SQL POD $SQL_POD"
  if [ X"$SQL_POD" != "X" ]; then

     CONTAINER_ID=`kubectl describe pod  $SQL_POD -n tixchange-v2 |sed -n '/tix-mysql:/{n;p}'|grep "Container ID" |awk '{print $3}'|sed 's/docker:\/\///g'`
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

correlateRDSToInfraForDBVertex () {
   echo correlateRDSToInfraForDBVertex

  RDS_VERTEX_ID=`getRDSVertexID |./jq-linux64|grep "\"id\""|awk '{ print $2 }'|sed 's/"//g'`

  if [ X"$RDS_VERTEX_ID" != "X" ]; then
    INF_DB_VERTEX_ID=`getMySQLVertexID |./jq-linux64|grep "\"id\""|awk '{ print $2 }'|sed 's/"//g'`

    echo "RDS_VERTEX_ID $RDS_VERTEX_ID and INF_DB_VERTEX_ID is $INF_DB_VERTEX_ID"

    if [ X"$INF_DB_VERTEX_ID" != "X" ]; then
       correlateRDSINFDBVertex $RDS_VERTEX_ID $INF_DB_VERTEX_ID
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


getRDSVertexID () {

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
                     "values": [ "AWS_RDS*" ]
                 },
                 {
                     "itemType" : "attributeFilter",
                     "attributeName": "Host",
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

PatchHostToApmiaContainsReln () {
	HOST_VERTEX_ID=`getHostVertexID|./jq-linux64|grep "\"id\""|awk '{ print $2 }'|sed 's/"//g'`
	APMIA_VERTEX_ID=`getApmiaMysqlVertexID |./jq-linux64|grep "\"id\""|awk '{ print $2 }'|sed 's/"//g'`

	echo "Patching for Contains  in host_vertex_id is $HOST_VERTEX_ID apmia vertex id $APMIA_VERTEX_ID"

   if [ X"$HOST_VERTEX_ID" != "X" ] && [ X"$APMIA_VERTEX_ID" != "X" ]; then
       patchAVertexWithContainsReln $HOST_VERTEX_ID cor.containsreln.contains.from
       patchAVertexWithContainsReln $APMIA_VERTEX_ID cor.containsreln.contains.to
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

correlateRDSINFDBVertex () {
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
                                "cor.db.contains.from":["rdsEast"]
                                 }
                 },
                 {
                                "id":"'$2'",
                                "attributes": {
                                "cor.db.contains.to":["rdsEast"]
                                 }
                 }
  ]
}'
}



echo "running setupEMSideConfigurations2.sh"

UNIVERSE_ID=`getUniverseIDFromName "$EM_UNIVERSE1"`

echo " UNIVERSE ID for  $EM_UNIVERSE1 is $UNIVERSE_ID"

runTrxnTrace
sleep 30

# if universe does not exist
if [ X"$UNIVERSE_ID" == "X" ]; then
  createUniverse 

  sleep 10
  UNIVERSE_ID=`getUniverseIDFromName "$EM_UNIVERSE1"`
  echo "Created $EM_UNIVERSE1 Universe, Exp View and TixChange MgmtMod - UNIV ID $UNIVERSE_ID"
  createExpView $UNIVERSE_ID

fi

sleep 5
importMgmtModule "TixChange.jar"
sleep 5
importMgmtModule "AWS.jar"
sleep 5
importMgmtModule "SaaSMM.jar"

echo "running Trxn Trace pls have patience"
runTrxnTrace
sleep 30
runTrxnTrace

correlateAppToInfraForDBVertex tix-mysql
#correlateAppToInfraForDBVertex apmia-mysql
correlateRDSToInfraForDBVertex

#PatchHostToApmiaContainsReln


sleep 10

#configMySqlMetricAndAlertMapping
#sleep 2
#configInferredDBMetricAndAlertMapping
