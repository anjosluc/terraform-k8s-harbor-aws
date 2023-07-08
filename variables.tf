variable "namespace" {
    type = string
    description = "Namespace name"
    default = "harbor"
}

variable "createNamespace" {
    type    = bool
    default = true
    description = "Create Namespace?"  
}

variable "createServiceAccount" {
    type    = bool
    default = true
    description = "Create Service Account?"
}

variable "createIAMRole" {
  type        = bool
  default     = true
  description = "Create IAM Role for Harbor? (Using EKS Default format)"
}

variable "iamRoleOIDCIssuerURL" {
  type        = string
  default     = "https://"
  description = "Cluster OIDC Issuer URL (Only valid for EKS clusters with OIDC Providers and createIAMRole = true)"
}

variable "existingIAMRoleARN" {
  type        = string
  default     = ""
  description = "Use Existing Role ARN for Harbor Service Account"
}

#### INGRESS
variable "ingressCoreDomain" {
    type        = string
    description = "Ingress Core DNS"
}

variable "ingressNotaryDomain" {
    type        = string
    description = "Ingress Notary DNS"
}

variable "ingressClassName" {
    type    = string
    default = "nginx"
    description = "Ingress Class Name"
}

###### PERSISTENCE
variable "region" {
    type        = string
    description = "AWS REGION to deploy bucket"
    validation {
      condition = contains(["us-east-1", "sa-east-1"], var.region)
      error_message = "Valid regions are: us-east-1, sa-east-1."
    }
}

variable "createBucket" {
  type = bool
  default = true
  description = "Create S3 Bucket?"
}

variable "bucketName" {
    type = string
    default = "harbor-storage"
    description = "S3 Bucket name to use"
}

######## HARBOR ADMIN
variable "harborAdminPassword" {
    type      = string
    sensitive = true
    description = "Harbor Admin Password"
}

######## NGINX
variable "nginxImageTag" {
    type        = string
    description = "Nginx Image Tag"
    default     = "v2.5.0"
}

variable "nginxImageRepository" {
    type = string
    description = "Nginx Image Repository"
    default     = "goharbor/nginx-photon"
}

variable "nginxReplicas" {
    type = string
    description = "Nginx Replicas"
    default     = "3"
}

######### PORTAL
variable "portalImageRepository" {
    type = string
    description = "Portal Image Repository"
    default     = "goharbor/harbor-portal"
}

variable "portalImageTag" {
    type = string
    description = "Portal Image Repository"
    default     = "v2.5.0"
}

variable "portalReplicas" {
    type = string
    description = "Portal Image Repository"
    default     = ""
}

######### CORE
variable "coreImageTag" {
    type = string
    description = "Core Image Repository"
    default     = "v2.5.0"
}

variable "coreImageRepository" {
    type = string
    description = "Core Image Repository"
    default     = "goharbor/harbor-core"
}

variable "coreReplicas" {
    type = string
    description = "Core Image Repository"
    default     = "1"
}

######### JOBSERVICE
variable "jobserviceImageTag" {
    type = string
    description = "JobService Image Repository"
    default     = "v2.5.0"
}

variable "jobserviceImageRepository" {
    type = string
    description = "JobService Image Repository"
    default     = "goharbor/harbor-jobservice"
}

variable "jobserviceReplicas" {
    type = string
    description = "JobService Replicas"
    default     = "1"
}

######### REGISTRY
variable "registryImageTag" {
    type = string
    description = "Registry Image Tag"
    default     = "v2.5.0"
}

variable "registryImageRepository" {
    type = string
    description = "Registry Image Repository"
    default     = "goharbor/registry-photon"
}

variable "registryReplicas" {
    type = string
    description = "Registry Replicas"
    default     = "1"
}

variable "registryControllerImageTag" {
    type = string
    description = "Registry Controller Image Tag"
    default     = "v2.5.0"
}

variable "registryControllerImageRepository" {
    type = string
    description = "Registry Controller Image Repository"
    default     = "goharbor/harbor-registryctl"
}

######### CHARTMUSEUM
variable "chartmuseumEnabled" {
    type    = bool
    default = true
    description = "ChartMuseum Enabled"
}

variable "chartmuseumImageTag" {
    type = string
    default = "v2.5.0"
    description = "ChartMuseum Image Tag"
}

variable "chartmuseumImageRepository" {
    type = string
    description = "ChartMuseum Image Repository"
    default = "goharbor/chartmuseum-photon"
}

variable "chartmuseumReplicas" {
    type = string
    default = "1"
    description = "ChartMuseum Replicas"
}

######### TRIVY
variable "trivyEnabled" {
    type    = bool
    default = true
    description = "Trivy Enabled?"
}

variable "trivyImageTag" {
    type        = string
    default     = "v2.5.0"
    description = "Trivy Image Tag"
}

variable "trivyImageRepository" {
    type = string
    description = "Trivy Image Repository"
    default = "goharbor/trivy-adapter-photon"
}

variable "trivyReplicas" {
    type = string
    description = "Trivy Replicas"
    default = "1"
}

######### NOTARY
variable "notaryEnabled" {
    type        = bool
    description = "Notary Enabled?"
    default     = true
}

variable "notaryServerImageTag" {
    type = string
    description = "Notary Server Image Tag"
    default = "v2.5.0"
}

variable "notaryServerImageRepository" {
    type = string
    description = "Notary Server Image Repository"
    default = "goharbor/notary-server-photon"
}

variable "notaryServerReplicas" {
    type = string
    default = "1"
    description = "Notary Server Replicas"
}

variable "notarySignerImageTag" {
    type = string
    default = "v2.5.0"
    description = "Notary Signer Image Tag"
}

variable "notarySignerImageRepository" {
    type = string
    default = "goharbor/notary-signer-photon"
    description = "Notary Signer Image Repository"
}

variable "notarySignerReplicas" {
    type = string
    default = "1"
    description = "Notary Signer Replicas"
}

######### DATABASE
variable "databaseInternalTag" {
    type = string
    default = "v2.5.0"
    description = "Database Internal Image Tag"
}

variable "databaseInternalRepository" {
    type = string
    default = "goharbor/harbor-db"
    description = "Database Internal Image Repository"
}

variable "databaseType" {
    type    = string
    default = "internal"
    description = "Database type to use (external, internal)"
    validation {
      condition = contains(["external", "internal"], var.databaseType)
      error_message = "Valid DB types are: external, internal." 
    }
}

variable "databaseExternalHost" {
    type = string
    default = "192.168.1.2"
    description = "DB External Host (Required if databaseType = external)"
}

variable "databaseExternalPort" {
    type    = string
    default = "5432"
    description = "DB External Port (Required if databaseType = external)"
}

variable "databaseExternalUsername" {
    type = string
    default = "user"
    description = "DB External Username (Required if databaseType = external)"
}

variable "databaseExternalPassword" {
    type = string
    default = "password"
    description = "DB External Password (Required if databaseType = external)"
}

variable "databaseExternalCoreDatabase" {
    type = string
    default = "registry"
    description = "DB External Core Database (Required if databaseType = external)"
}

variable "databaseExternalNotaryServerDatabase" {
    type = string
    default = "notary_server"
    description = "DB External Notary Server Database (Required if databaseType = external)"
}

variable "databaseExternalNotarySignerDatabase" {
    type = string
    default = "notary_signer"
    description = "DB External describe your variable (Required if databaseType = external)"
}


######### REDIS
variable "redisType" {
    type = string
    default = "internal"
    description = "Redis type to use (external, internal)"
    validation {
      condition = contains(["external", "internal"], var.redisType)
      error_message = "Valid Redis types are: external, internal." 
    }
}

variable "redisImageRepository" {
    type = string
    default = "goharbor/redis-photon"
    description = "Redis Image Repository"
}

variable "redisImageTag" {
    type = string
    default = "v2.5.0"
    description = "Redis Image Tag"
}

variable "redisExternalAddress" {
    type = string
    default = "192.168.0.2:6379"
    description = "Redis External Addresss"
}


######### EXPORTER
variable "exporterReplicas" {
    type = string
    default = "1"
    description = "External Replicas"
}

variable "exporterImageRepository" {
    type = string
    default = "goharbor/harbor-exporter"
    description = "External Image Repository"
}

variable "exporterImageTag" {
    type = string
    default = "v2.5.0"
    description = "External Image Tag"
}

############## HARBOR CONFIGURATIONS #######################

variable "useLDAPAuth" {
    type = bool
    default = true
    description = "Use LDAP for authentication?"
}

variable "useOIDCAuth" {
    type = bool
    default = false
    description = "Use OIDC for authentication?"
}

variable "useSMTP" {
    type = bool
    default = true
    description = "Use SMTP?"
}

## SMTP 
variable "smtpHost" {
    type = string
    default = "mail.example.com"
    description = "(optional) describe your variable"
}

variable "emailFrom" {
    type = string
    default = "harbor-sre-dev@example-com.cloud"
    description = "(optional) describe your variable"
}

## LDAP
variable "ldapURL" {
    type = string
    default = "ldap://10.0.0.1"
    description = "LDAP URL"
}

variable "ldapSearchDN" {
    type = string
    default = "cn=svc_harbor,dc=example,dc=com"
    description = "LDAP Search DN"
}

variable "ldapSearchPassword" {
    type = string
    sensitive = true
    default = ""
    description = "LDAP Search Password"
}

variable "ldapBaseDN" {
    type = string
    default = "dc=example,dc=com"
    description = "LDAP Base DN"
}

variable "ldapGroupBaseDN" {
    type = string
    default = "ou=ManagementGroups,dc=example,dc=com"
    description = "LDAP Group Base DN"
}

variable "ldapGroupAdminDN" {
    type = string
    default = "cn=harbor-admins,ou=managementgroups,dc=example,dc=com"
    description = "LDAP Group Admin DN"
}

## OIDC
variable "OIDCEndpoint" {
    type = string
    default = "https://login.microsoftonline.com/{GUID}/v2.0"
    description = "OIDC Endpoint"
}

variable "OIDCName" {
    type = string
    default = "azure"
    description = "OIDC Name to use"
}

variable "OIDCClientId" {
    type = string
    default = ""
    description = "OIDC Client ID"
}

variable "OIDCClientSecret" {
    type = string
    default = ""
    description = "OIDC Client Secret"
}

variable "OIDCScope" {
    type = string
    default = "openid,email"
    description = "OIDC Scope"
}

variable "OIDCAdminGroup" {
    type = string
    default = "Harbor Admins"
    description = "OIDC Admin Group"
}

## PROJECT CONFS

variable "createDockerHubProxy" {
    type = bool
    default = true
    description = "(optional) describe your variable"
}