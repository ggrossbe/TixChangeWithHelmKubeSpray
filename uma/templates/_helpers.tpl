{{- define "prometheus.clusterName" }} {{- .Values.monitor.container.prometheus.backend.endPoint.url | replace ":" "_" }} {{- end }}
#{{- define "runtime.info"}} {{ .Values.runtime | default "docker" }} {{- end }}
#| replace ":" "_"
