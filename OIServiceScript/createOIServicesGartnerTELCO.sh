clear
echo ""
echo "***********"
echo "create service in GCP SaaS instance"
echo ""
echo "pls provide the OI token (this is OI token not APM - Go to Service Overview Page of the OI. Open browser dev mode and go to request header section under network tab for a request (say click on status circle) and look for Authorization Bearer token )"
echo ""
echo ""

read OI_TOKEN

echo ""
echo " Pls Provide MYSQL POD name OR RDS East Hostname if using AWS RDS deployment. e.g kubectl get pods -n tixchange-v2 OR tixchange:us-east-2:544960306 from AWS console"

read TIXCHANGE_MYSQL_RDS_HOSTNAME

echo ""

sleep 2

if [ X"$OI_TOKEN" == "X" ] || [ X"$TIXCHANGE_MYSQL_RDS_HOSTNAME" == "X" ]; then
   echo "Pls provide valid token and Valid MYSQL RDS hostname/POD name "
   exit

fi

echo " "

echo " This will create an OI service - give it a minute or two and refresh your browser"
echo ""

echo ""

curl -v -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/save \
  -H 'Authorization: Bearer '$OI_TOKEN'' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
  "vertices": [
    {
      "attributes": {
        "type": "saService",
        "name": "APJ_Billing",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_Billing"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_Mobile",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "LATAM_Mobile"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Billing",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Billing"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "Mobile Service",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "Mobile Service"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Mobile",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Mobile"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_Billing",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "LATAM_Billing"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Activation",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Activation"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "NA_Activation"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Mobile",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Mobile"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Billing",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Billing"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Activation",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Activation"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Activation"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Provisioning",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Provisioning"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Provisioning"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Provisioning",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Provisioning"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Provisioning"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "APJ_Mobile",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_Mobile"
    }
  ],
  "edges": [
    {
      "targetExternalId": "EMEA_Billing",
      "sourceExternalId": "EMEA_Mobile",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Provisioning",
      "sourceExternalId": "EMEA_Mobile",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Activation",
      "sourceExternalId": "EMEA_Mobile",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Mobile",
      "sourceExternalId": "Mobile Service",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Billing",
      "sourceExternalId": "NA_Mobile",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Provisioning",
      "sourceExternalId": "NA_Mobile",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_Mobile",
      "sourceExternalId": "Mobile Service",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_Billing",
      "sourceExternalId": "LATAM_Mobile",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_Billing",
      "sourceExternalId": "APJ_Mobile",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Mobile",
      "sourceExternalId": "Mobile Service",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Activation",
      "sourceExternalId": "NA_Mobile",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_Mobile",
      "sourceExternalId": "Mobile Service",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    }
  ]
}
'
echo "***sleeping for 10 sec"
sleep 10

curl -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/NA_Provisioning \
  -H 'Authorization: Bearer '$OI_TOKEN'' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
    "serviceContent": [{
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Provisioning"
              }]
    }]
}'

echo "***sleeping for 5 sec"
sleep 5

curl -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/EMEA_Provisioning \
  -H 'Authorization: Bearer '$OI_TOKEN'' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
    "serviceContent": [{
        "query": [{
                                "attributeName": "agent",
                "attributeValue": "TxChangeWeb_UC2|tomcat|Agent"
        }]
    },{
        "query": [{
                                "attributeName": "agent",
                "attributeValue": "TxChangeSvc_UC2|tomcat|Agent"
        }]
    },{
        "query": [{
                                "attributeName": "agent",
                "attributeValue": "node2|apmiaMySQL_UC2|Agent"
        }]
    },{
        "query": [{
                                "attributeName": "hostname",
                "attributeValue": "'$TIXCHANGE_MYSQL_RDS_HOSTNAME'"
        }]
    }]
}'


echo "***sleeping for 5 sec"
sleep 5

curl -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/NA_Activation \
  -H 'Authorization: Bearer '$OI_TOKEN'' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
    "serviceContent": [{
        "query": [{
                                "attributeName": "applicationName",
                "attributeValue": "Activation"
        }]
    }]
}'