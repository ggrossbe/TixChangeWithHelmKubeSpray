
correlateRDSINFDBVertex () {
curl -v -k -s -X PATCH \
  https://apmgw.dxi-na1.saas.broadcom.com/98/apm/appmap/graph/vertex/ \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJzdWIiOiJTUklLQU5ULk5PT1JBTklAQlJPQURDT00uQ09NIiwiZHluZXhwIjp0cnVlLCJ0aWQiOjk4LCJqdGkiOiI4MzBlNzk1YS0wMDJjLTQxMWMtODcxNy0wZWI3NGM0YjAxNWIifQ.IA2aMFVMetLYEbDB4Xir1WS83FO99yJ6Q_9X9zaVseun_T8OD1o2WKXIjELrH-iFWCjyDhuB9XcCjCyR8Dv6ig' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: apmgw.dxi-na1.saas.broadcom.com' \
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


getRDSVertexID () {

curl -v -k -s -X POST \
  https://apmgw.dxi-na1.saas.broadcom.com/98/apm/appmap/graph/vertex \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJzdWIiOiJTUklLQU5ULk5PT1JBTklAQlJPQURDT00uQ09NIiwiZHluZXhwIjp0cnVlLCJ0aWQiOjk4LCJqdGkiOiI4MzBlNzk1YS0wMDJjLTQxMWMtODcxNy0wZWI3NGM0YjAxNWIifQ.IA2aMFVMetLYEbDB4Xir1WS83FO99yJ6Q_9X9zaVseun_T8OD1o2WKXIjELrH-iFWCjyDhuB9XcCjCyR8Dv6ig' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: apmgw.dxi-na1.saas.broadcom.com' \
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
                     "values": [ "tix-oaccess-east.cq3qfzsicvyi.us-east-2.rds.amazonaws.com*" ]
                 }
            ]
        }
    ]
}'

}


getMySQLVertexID () {

curl -v -k -s -X POST \
  https://apmgw.dxi-na1.saas.broadcom.com/98/apm/appmap/graph/vertex \
  -H 'Accept: */*' \
  -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJzdWIiOiJTUklLQU5ULk5PT1JBTklAQlJPQURDT00uQ09NIiwiZHluZXhwIjp0cnVlLCJ0aWQiOjk4LCJqdGkiOiI4MzBlNzk1YS0wMDJjLTQxMWMtODcxNy0wZWI3NGM0YjAxNWIifQ.IA2aMFVMetLYEbDB4Xir1WS83FO99yJ6Q_9X9zaVseun_T8OD1o2WKXIjELrH-iFWCjyDhuB9XcCjCyR8Dv6ig' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: apmgw.dxi-na1.saas.broadcom.com' \
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
                     "values": [ "tix-oaccess-east.cq3qfzsicvyi.us-east-2.rds.amazonaws.com*" ]
                 }
            ]
        }
    ]
}'

}


correlateRDSToInfraForDBVertex () {

  RDS_VERTEX_ID=`getRDSVertexID |./jq-linux64|grep "\"id\""|awk '{ print $2 }'|sed 's/"//g'`

  echo "RDS Vertex ID $RDS_VERTEX_ID"

  if [ X"$RDS_VERTEX_ID" != "X" ]; then
    INF_DB_VERTEX_ID=`getMySQLVertexID |./jq-linux64|grep "\"id\""|awk '{ print $2 }'|sed 's/"//g'`

    echo "RDS_VERTEX_ID $RDS_VERTEX_ID and INF_DB_VERTEX_ID is $INF_DB_VERTEX_ID"


    if [ X"$INF_DB_VERTEX_ID" != "X" ]; then
       correlateRDSINFDBVertex $RDS_VERTEX_ID $INF_DB_VERTEX_ID
    fi

  fi

}

correlateRDSToInfraForDBVertex


