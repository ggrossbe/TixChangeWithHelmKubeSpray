clear
echo ""
echo "***********"
echo "create service in GCP SaaS instance"
echo ""
echo "pls provide the OI token (this is OI token not APM - Go to Service Overview Page of the OI. Open browser dev mode and go to request header section under network tab for a request (say click on status circle) and look for Authorization Bearer token )"
echo ""
echo ""

read OI_TOKEN

if [ X"$OI_TOKEN" == "X" ]; then
   echo "Pls provide valid token"
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
          "Consumer Services"
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
        "name": "LATAM",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Consumer Services"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "LATAM"
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
          "Consumer Services"
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
        "name": "Consumer Services",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Consumer Services"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "Consumer Services"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Consumer Services"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA"
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
          "Consumer Services"
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
          "Consumer Services"
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
        "name": "NA",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Consumer Services"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA"
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
          "Consumer Services"
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
          "Consumer Services"
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
          "Consumer Services"
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
          "Consumer Services"
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
        "name": "APJ",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Consumer Services"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ"
    }
  ],
  "edges": [
    {
      "targetExternalId": "EMEA_Life",
      "sourceExternalId": "EMEA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Property",
      "sourceExternalId": "EMEA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Vehicle",
      "sourceExternalId": "EMEA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA",
      "sourceExternalId": "Consumer Services",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Life",
      "sourceExternalId": "NA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Property",
      "sourceExternalId": "NA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM",
      "sourceExternalId": "Consumer Services",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_Life",
      "sourceExternalId": "LATAM",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_Life",
      "sourceExternalId": "APJ",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA",
      "sourceExternalId": "Consumer Services",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Vehicle",
      "sourceExternalId": "NA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ",
      "sourceExternalId": "Consumer Services",
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
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/NA_Property \
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
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/EMEA_Property \
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

echo "***sleeping for 5 sec"
sleep 5

curl -X POST \
  https://doi.dxi-na1.saas.broadcom.com/oi/v2/sa/update/NA_Vehicle \
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
