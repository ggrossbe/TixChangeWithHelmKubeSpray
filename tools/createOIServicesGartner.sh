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
        "name": "APJ_Billing_5",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing_5"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_Billing_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_5",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "LATAM_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Billing_5",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing_5"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Billing_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "Mobile Service_5",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "Mobile Service_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_5",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_Billing_5",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing_5"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "LATAM_Billing_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Activiation_5",
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
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "NA_Activiation_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_5",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Billing_5",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing_5"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Billing_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Activation_5",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Activation_5"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Activation_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Provisioning_5",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Provisioning_5"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Provisioning_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Provisioning_5",
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
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Provisioning_5"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "APJ_5",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_5"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_5"
    }
  ],
  "edges": [
    {
      "targetExternalId": "EMEA_Billing_5",
      "sourceExternalId": "EMEA_5",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Provisioning_5",
      "sourceExternalId": "EMEA_5",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_Activation_5",
      "sourceExternalId": "EMEA_5",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_5",
      "sourceExternalId": "Mobile Service_5",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Billing_5",
      "sourceExternalId": "NA_5",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Provisioning_5",
      "sourceExternalId": "NA_5",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_5",
      "sourceExternalId": "Mobile Service_5",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_Billing_5",
      "sourceExternalId": "LATAM_5",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_Billing_5",
      "sourceExternalId": "APJ_5",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_5",
      "sourceExternalId": "Mobile Service_5",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Activiation_5",
      "sourceExternalId": "NA_5",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_5",
      "sourceExternalId": "Mobile Service_5",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    }
  ]
}
'
