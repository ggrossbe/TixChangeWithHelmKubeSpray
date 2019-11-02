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
        "name": "APJ_Billing_4",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing_4"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service_4"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_Billing_4"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_4",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_4"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "LATAM_4"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Billing_4",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing_4"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service_4"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Billing_4"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "Mobile Service_4",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_4"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "Mobile Service_4"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_4",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_4"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_4"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "LATAM_Billing_4",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing_4"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service_4"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "LATAM_Billing_4"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Activiation_4",
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
          "Mobile Service_4"
        ],
        "tags": [],
        "location": "",
        "description": "test",
        "customProperties": []
      },
      "externalId": "NA_Activiation_4"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_4",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_4"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_4"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "EMEA_Billing_4",
        "state": "ACTIVE",
        "serviceContent": [
          {
            "query": [
              {
                "attributeName": "applicationName",
                "attributeValue": "Billing_4"
              }
            ]
          }
        ],
        "root_service": [
          "Mobile Service_4"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "EMEA_Billing_4"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "NA_Provisioning_4",
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
          "Mobile Service_4"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "NA_Provisioning_4"
    },
    {
      "attributes": {
        "type": "saService",
        "name": "APJ_4",
        "state": "ACTIVE",
        "serviceContent": [],
        "root_service": [
          "Mobile Service_4"
        ],
        "tags": [],
        "location": "",
        "description": "",
        "customProperties": []
      },
      "externalId": "APJ_4"
    }
  ],
  "edges": [
    {
      "targetExternalId": "EMEA_Billing_4",
      "sourceExternalId": "EMEA_4",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "EMEA_4",
      "sourceExternalId": "Mobile Service_4",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Billing_4",
      "sourceExternalId": "NA_4",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Provisioning_4",
      "sourceExternalId": "NA_4",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_4",
      "sourceExternalId": "Mobile Service_4",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "LATAM_Billing_4",
      "sourceExternalId": "LATAM_4",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_Billing_4",
      "sourceExternalId": "APJ_4",
      "attributes": {
        "health_weight": 1,
        "risk_weight": 1,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_4",
      "sourceExternalId": "Mobile Service_4",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "NA_Activiation_4",
      "sourceExternalId": "NA_4",
      "attributes": {
        "health_weight": 0.33299999999999996,
        "risk_weight": 0.33299999999999996,
        "semantic": "AggregateOf"
      }
    },
    {
      "targetExternalId": "APJ_4",
      "sourceExternalId": "Mobile Service_4",
      "attributes": {
        "health_weight": 0.25,
        "risk_weight": 0.25,
        "semantic": "AggregateOf"
      }
    }
  ]
}
'
