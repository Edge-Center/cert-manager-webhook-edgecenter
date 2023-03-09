{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "edgecenter-webhook.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "edgecenter-webhook.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "edgecenter-webhook.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "edgecenter-webhook.labels" -}}
app.kubernetes.io/name: {{ include "edgecenter-webhook.name" . }}
helm.sh/chart: {{ include "edgecenter-webhook.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
PKI
*/}}
{{- define "edgecenter-webhook.selfSignedIssuer" -}}
{{ printf "%s-selfsign" (include "edgecenter-webhook.fullname" .) }}
{{- end -}}

{{- define "edgecenter-webhook.rootCAIssuer" -}}
{{ printf "%s-ca" (include "edgecenter-webhook.fullname" .) }}
{{- end -}}

{{- define "edgecenter-webhook.rootCACertificate" -}}
{{ printf "%s-ca" (include "edgecenter-webhook.fullname" .) }}
{{- end -}}

{{- define "edgecenter-webhook.servingCertificate" -}}
{{ printf "%s-webhook-tls" (include "edgecenter-webhook.fullname" .) }}
{{- end -}}
