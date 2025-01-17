{{/*
Fullname
*/}}
{{- define "thanos.compact.fullname" -}}
{{ include "thanos.fullname" . }}-compact
{{- end }}

{{/*
Common labels
*/}}
{{- define "thanos.compact.labels" -}}
{{ include "thanos.labels" . }}
app.kubernetes.io/component: compact
{{- end }}

{{/*
Selector labels
*/}}
{{- define "thanos.compact.selectorLabels" -}}
{{ include "thanos.selectorLabels" . }}
app.kubernetes.io/component: compact
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "thanos.compact.serviceAccountName" -}}
{{- if .Values.compact.serviceAccount.create -}}
{{- default (printf "%s-compact" (include "thanos.fullname" .)) .Values.compact.serviceAccount.name }}
{{- else -}}
{{- default "default" .Values.compact.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Patch affinity
*/}}
{{- define "thanos.compact.patchAffinity" -}}
{{- if (hasKey .Values.pause.affinity "podAffinity") }}
{{- include "thanos.patchPodAffinity" (merge (dict "_podAffinity" .Values.pause.affinity.podAffinity "_selectorLabelsTemplate" "thanos.compact.selectorLabels") .) }}
{{- end }}
{{- if (hasKey .Values.pause.affinity "podAntiAffinity") }}
{{- include "thanos.patchPodAffinity" (merge (dict "_podAffinity" .Values.pause.affinity.podAntiAffinity "_selectorLabelsTemplate" "thanos.compact.selectorLabels") .) }}
{{- end }}
{{- end }}

{{/*
Patch topology spread constraints
*/}}
{{- define "thanos.compact.patchTopologySpreadConstraints" -}}
{{- range $constraint := .Values.pause.topologySpreadConstraints }}
{{- include "thanos.patchLabelSelector" (merge (dict "_target" $constraint "_selectorLabelsTemplate" "thanos.compact.selectorLabels") $) }}
{{- end }}
{{- end }}
