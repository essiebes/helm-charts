{{/*
Expand the name of the chart.
*/}}
{{- define "essies-toys.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "essies-toys.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "essies-toys.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "essies-toys.labels" -}}
helm.sh/chart: {{ include "essies-toys.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels shared
*/}}
{{- define "essies-toys.selectorLabels.shared" -}}
app.kubernetes.io/name: {{ include "essies-toys.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels API
*/}}
{{- define "essies-toys.selectorLabels.api" -}}
{{ include "essies-toys.selectorLabels.shared" . }}
app.kubernetes.io/component: api
{{- end }}

{{/*
Selector labels Frontend
*/}}
{{- define "essies-toys.selectorLabels.frontend" -}}
{{ include "essies-toys.selectorLabels.shared" . }}
app.kubernetes.io/component: frontend
{{- end }}

{{/*
Selector labels Socketio
*/}}
{{- define "essies-toys.selectorLabels.socketio" -}}
{{ include "essies-toys.selectorLabels.shared" . }}
app.kubernetes.io/component: deapstream
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "essies-toys.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "essies-toys.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
