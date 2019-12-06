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
        "name": "LATAM",
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
      "externalId": "LATAM"
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
        "name": "EMEA",
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
      "externalId": "EMEA"
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
        "name": "NA_Activiation",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "agent",
                "attributeValue": "TxChangeWeb_UC2|tomcat|Agent"
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
      "externalId": "NA_Activiation"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA",
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
      "externalId": "NA"
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
                "attributeName": "agent",
                "attributeValue": "TxChangeWeb_UC1|tomcat|Agent"
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
        "name": "APJ",
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
      "externalId": "APJ"
    }
  ],
  "edges": [
    {
      "targetExternalId": "EMEA_Billing",
      "sourceExternalId": "EMEA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Provisioning",
      "sourceExternalId": "EMEA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Activation",
      "sourceExternalId": "EMEA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA",
      "sourceExternalId": "Mobile Service",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Billing",
      "sourceExternalId": "NA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Provisioning",
      "sourceExternalId": "NA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM",
      "sourceExternalId": "Mobile Service",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_Billing",
      "sourceExternalId": "LATAM",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_Billing",
      "sourceExternalId": "APJ",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA",
      "sourceExternalId": "Mobile Service",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Activiation",
      "sourceExternalId": "NA",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ",
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
