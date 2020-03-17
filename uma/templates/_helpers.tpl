{{- define "prometheus.clusterName" }} {{- .Values.monitor.container.prometheus.backend.endPoint.url | replace ":" "_" }} {{- end }}
#| replace ":" "_"
