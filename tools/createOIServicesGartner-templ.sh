echo ""
echo "***********"
echo "create service in GCP SaaS instance"
echo ""
echo "pls provide the OI token (this is OI token not APM - Go to Service Overview Page of the OI. Open browser dev mode and go to request header section under network tab for a request (say click on status circle) and look for Authorization Bearer token )"
echo ""

read OI_TOKEN

if [ X"$OI_TOKEN" == "X" ]; then
   echo "Pls provide valid token"
   exit

fi

echo " "

echo " This will create an OI service - give it a minute or two and refresh your browser"

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
        "name": "APJ_#_Billing",
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
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_#_Billing"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_#",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "LATAM_#"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_#_Billing",
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
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_#_Billing"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "Mobile Service_#",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "Mobile Service_#"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_#",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_#"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_#_Billing",
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
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "LATAM_#_Billing"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_#_Activation",
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
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "NA_#_Activation"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_#",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_#"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_#_Billing",
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
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_#_Billing"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_#_Activation",
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
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_#_Activation"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_#_Provisioning",
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
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_#_Provisioning"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_#_Provisioning",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "agent",
                "attributeValue": "TxChangeWeb_UC1|tomcat|Agent"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_#_Provisioning"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "APJ_#",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_#"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_#"
    }
  ],
  "edges": [
    {
      "targetExternalId": "EMEA_#_Billing",
      "sourceExternalId": "EMEA_#",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_#_Provisioning",
      "sourceExternalId": "EMEA_#",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_#_Activation",
      "sourceExternalId": "EMEA_#",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_#",
      "sourceExternalId": "Mobile Service_#",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_#_Billing",
      "sourceExternalId": "NA_#",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_#_Provisioning",
      "sourceExternalId": "NA_#",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_#",
      "sourceExternalId": "Mobile Service_#",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_#_Billing",
      "sourceExternalId": "LATAM_#",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_#_Billing",
      "sourceExternalId": "APJ_#",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_#",
      "sourceExternalId": "Mobile Service_#",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_#_Activation",
      "sourceExternalId": "NA_#",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_#",
      "sourceExternalId": "Mobile Service_#",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    }
  ]
}
'

curl -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/NA_#_Provisioning \
  -H 'Authorization: Bearer '$OI_TOKEN'' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
    "serviceContent": [{
        "query": [{
                                "attributeName": "agent",
                "attributeValue": "TxChangeWeb_UC1|tomcat|Agent"
        }]
    },{
        "query": [{
                                "attributeName": "agent",
                "attributeValue": "TxChangeSvc_UC1|tomcat|Agent"
        }]
    },{
        "query": [{
                                "attributeName": "agent",
                "attributeValue": "node2|apmiaMySQL_UC1|Agent"
        }]
    }]
}'

curl -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/EMEA_#_Provisioning \
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
    }]
}'


curl -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/NA_#_Activation \
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
