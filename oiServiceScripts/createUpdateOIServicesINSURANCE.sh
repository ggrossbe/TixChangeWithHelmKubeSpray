### NOT A standalone script any more - pls run this as part of mainInstaller.sh

CREATE_UPDATE="$1"

createOIServices () {

curl -v -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/save \
  -H 'Authorization: Bearer OI_TOKEN' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
  "vertices": [
    {
      "attributes": {
        "type": "saService",
        "name": "APJ_Life",
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
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_Life"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_Insurance",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "LATAM_Insurance"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Life",
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
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Life"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "Consumer Insurance",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "Consumer Insurance"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Insurance",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Insurance"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_Life",
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
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "LATAM_Life"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Vehicle",
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
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "NA_Vehicle"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Insurance",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Insurance"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Life",
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
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Life"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Vehicle",
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
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Vehicle"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Property",
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
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Property"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Property",
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
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Property"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "APJ_Insurance",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Consumer Insurance"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_Insurance"
    }
  ],
  "edges": [
    {
      "targetExternalId": "EMEA_Life",
      "sourceExternalId": "EMEA_Insurance",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Property",
      "sourceExternalId": "EMEA_Insurance",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Vehicle",
      "sourceExternalId": "EMEA_Insurance",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Insurance",
      "sourceExternalId": "Consumer Insurance",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Life",
      "sourceExternalId": "NA_Insurance",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Property",
      "sourceExternalId": "NA_Insurance",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_Insurance",
      "sourceExternalId": "Consumer Insurance",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_Life",
      "sourceExternalId": "LATAM_Insurance",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_Life",
      "sourceExternalId": "APJ_Insurance",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Insurance",
      "sourceExternalId": "Consumer Insurance",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Vehicle",
      "sourceExternalId": "NA_Insurance",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_Insurance",
      "sourceExternalId": "Consumer Insurance",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    }
  ]
}
'

echo ""
}



updateOIServices () {

echo ""

curl -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/NA_Property \
  -H 'Authorization: Bearer OI_TOKEN' \
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
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/EMEA_Property \
  -H 'Authorization: Bearer OI_TOKEN' \
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
                "attributeValue": "EMEA_DB_HOST_POD_NAME"
        }]
    },{
        "metrics": [{
                 "type": "availability",
                "sourceName": "ASM_AGENT_NAME",
                "attributeValue": "ASM_METRIC_NAME"
        }]
    }]
}'

echo "***sleeping for 5 sec"
sleep 5

curl -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/NA_Vehicle \
  -H 'Authorization: Bearer OI_TOKEN' \
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

echo ""
}

echo "***** create update OI services - $1 and  OI_TOKEN and EMEA_DB_HOST_POD_NAME - EMEA_DB_HOST_POD_NAME"


if [ X"$CREATE_UPDATE" == "Xcreate" ]; then
  createOIServices

  sleep 10

  updateOIServices
else
  updateOIServices
fi
