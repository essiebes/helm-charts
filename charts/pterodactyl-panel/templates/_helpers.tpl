{{/*
Expand the name of the chart.
*/}}
{{- define "pterodactyl.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pterodactyl.fullname" -}}
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
{{- define "pterodactyl.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pterodactyl.labels" -}}
helm.sh/chart: {{ include "pterodactyl.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels panel
*/}}
{{- define "pterodactyl.selectorLabels.panel" -}}
app.kubernetes.io/name: {{ include "pterodactyl.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels cache
*/}}
{{- define "pterodactyl.selectorLabels.cache" -}}
app.kubernetes.io/name: {{ include "pterodactyl.name" . }}-cache
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pterodactyl.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pterodactyl.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Registers the config map reference
*/}}
{{- define "pterodactyl.configMapRef" -}}
{{- if .Values.config.existingRef }}
{{- printf "%s" .Values.config.existingRef }}
{{- else }}
{{- printf "%s-config" (include "pterodactyl.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Registers the secret reference
*/}}
{{- define "pterodactyl.secretRef" -}}
{{- if .Values.secrets.existingRef }}
{{- printf "%s" .Values.secrets.existingRef }}
{{- else }}
{{- printf "%s-secrets" (include "pterodactyl.fullname" .) }}
{{- end }}
{{- end }}