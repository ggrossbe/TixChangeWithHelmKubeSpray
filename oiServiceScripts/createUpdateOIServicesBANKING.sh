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
        "name": "APJ_Commercial",
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
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_Commercial"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_Banking",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "LATAM_Banking"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Commercial",
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
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Commercial"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "Banking Service",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "Banking Service"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Banking",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Banking"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_Commercial",
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
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "LATAM_Commercial"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Mobile",
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
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "NA_Mobile"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Banking",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Banking"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Commercial",
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
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Commercial"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Mobile",
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
          "Banking Service"
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
        "name": "EMEA_Retail",
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
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Retail"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Retail",
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
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Retail"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "APJ_Banking",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Banking Service"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_Banking"
    }
  ],
  "edges": [
    {
      "targetExternalId": "EMEA_Commercial",
      "sourceExternalId": "EMEA_Banking",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Retail",
      "sourceExternalId": "EMEA_Banking",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Mobile",
      "sourceExternalId": "EMEA_Banking",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Banking",
      "sourceExternalId": "Banking Service",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Commercial",
      "sourceExternalId": "NA_Banking",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Retail",
      "sourceExternalId": "NA_Banking",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_Banking",
      "sourceExternalId": "Banking Service",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_Commercial",
      "sourceExternalId": "LATAM_Banking",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_Commercial",
      "sourceExternalId": "APJ_Banking",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Banking",
      "sourceExternalId": "Banking Service",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Mobile",
      "sourceExternalId": "NA_Banking",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_Banking",
      "sourceExternalId": "Banking Service",
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
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/NA_Retail \
  -H 'Authorization: Bearer OI_TOKEN' \
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
    },{
        "query": [{
                                "attributeName": "hostname",
                "attributeValue": "NA_DB_HOST_POD_TOKEN"
        }]
    },{
        "query": [{
                                "attributeName": "hostname",
                "attributeValue": "NA_DB_HOST_POD_NAME"
        }]
    }],
   "metrics": [
    {
      "type": "availability",
      "sourceName": "ASM_AGENT_NAME_NA",
      "attributeName": "ASM_METRIC_NAME_NA",
      "threshold": 0.5
     }
     ]
}'

echo "***sleeping for 5 sec"
sleep 5

curl -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/EMEA_Retail \
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
                "attributeValue": "EMEA_DB_HOST_POD_TOKEN"
        }]
    },{
        "query": [{
                                "attributeName": "hostname",
                "attributeValue": "EMEA_DB_HOST_POD_NAME"
        }]
    }],
   "metrics": [
    {
      "type": "availability",
      "sourceName": "ASM_AGENT_NAME_EMEA",
      "attributeName": "ASM_METRIC_NAME_EMEA",
      "threshold": 0.5
     }
     ]
}'

echo "***sleeping for 5 sec"
sleep 5

curl -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/NA_Mobile \
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

echo "***** create update OI services - $1 and  OI_TOKEN and EMEA_DB_HOST_POD_NAME - $EMEA_DB_HOST_POD_NAME"


if [ X"$CREATE_UPDATE" == "Xcreate" ]; then
  createOIServices
  
  sleep 10

  updateOIServices
else
  updateOIServices
fi
