#Run once in 3 Days
EPOCH_TIME=$(((`date +'%s'` + 86400) * 1000))

curl -v -k -X POST 'https://apmservices-gateway-ao-apm.app.gpus1.saas.broadcom.com/tas/graph/store' \
-H 'Authorization: Bearer TENANT_API_TOKEN' \
-H 'Content-Type: application/json' \
-d '{
	"graph": {
		"edges": [
			{
				"sourceExternalId": "ATC:TIXCHANGE Services:WEBSERVICE_SERVER:http_//service.jtixchange.com|getAuthAccount:TxChangeSvc_UC1:Agent:tomcat",
				"targetExternalId": "APM_INFRASTRUCTURE:AGENT:node2|apmiaMySQL_UC1|Agent",
				"endTime": '$EPOCH_TIME'
			},{
				"sourceExternalId": "ATC:TIXCHANGE Services:WEBSERVICE_SERVER:http_//service.jtixchange.com|getAuthAccount:TxChangeSvc_UC2:Agent:tomcat",
				"targetExternalId": "APM_INFRASTRUCTURE:AGENT:node2|apmiaMySQL_UC2|Agent",
				"endTime": '$EPOCH_TIME'
			}
		]
	}
}'
