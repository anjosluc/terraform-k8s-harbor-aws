resource "kubectl_manifest" "ns_harbor" {
  count = var.createNamespace ? 1 : 0
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: ${var.namespace}
YAML
}

resource "kubectl_manifest" "serviceaccount_harbor" {
  count = var.createServiceAccount ? 1 : 0
  yaml_body = <<YAML
apiVersion: v1
kind: ServiceAccount
metadata:
  name: harbor
  namespace: ${var.namespace}
  annotations:
    eks.amazonaws.com/role-arn: ${local.roleARN}
YAML
}

resource "helm_release" "harbor_release_chart" {
  depends_on = [
    kubectl_manifest.serviceaccount_harbor
  ]
  chart            = "harbor"
  name             = "harbor"
  namespace        = var.namespace
  repository       = "https://helm.goharbor.io"
  force_update     = false
  version          = "1.9.0"

  set {
    name  = "expose.tls.enabled"
    value = false
  }

  set {
    name  = "expose.ingress.hosts.core"
    value = var.ingressCoreDomain
  }

  set {
    name  = "expose.ingress.hosts.notary"
    value = var.ingressNotaryDomain
  }

  set {
    name  = "expose.ingress.className"
    value = var.ingressClassName
  }

  set {
    name  = "externalURL"
    value = "https://${var.ingressCoreDomain}"
  }

  # PERSISTENCE
  set {
    name  = "persistence.imageChartStorage.type"
    value = "s3"
  }

  set {
    name  = "persistence.imageChartStorage.s3.region"
    value = var.region
  }

  set {
    name  = "persistence.imageChartStorage.s3.bucket"
    value = var.bucketName
  }

  # HARBOR ADMIN
  set {
    name  = "harborAdminPassword"
    value = var.harborAdminPassword
  }

  # NGINX
  set {
    name  = "nginx.image.repository"
    value = var.nginxImageRepository
  }

  set {
    name  = "nginx.image.tag"
    value = var.nginxImageTag
  }

  set {
    name  = "nginx.replicas"
    value = var.nginxReplicas
  }

  set {
    name  = "nginx.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "nginx.automountServiceAccountToken"
    value = true
  }
  
  # PORTAL
  set {
    name  = "portal.image.repository"
    value = var.portalImageRepository
  }

  set {
    name  = "portal.image.tag"
    value = var.portalImageTag
  }

  set {
    name  = "portal.replicas"
    value = var.portalReplicas
  }

  set {
    name  = "portal.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "portal.automountServiceAccountToken"
    value = true
  }

  #CORE
  set {
    name  = "core.image.repository"
    value = var.coreImageRepository
  }

  set {
    name  = "core.image.tag"
    value = var.coreImageTag
  }

  set {
    name  = "core.replicas"
    value = var.coreReplicas
  }

  set {
    name  = "core.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "core.automountServiceAccountToken"
    value = true
  }

  #JOBSERVICE
  set {
    name = "jobservice.image.repository"
    value = var.jobserviceImageRepository
  }

  set {
    name  = "jobservice.image.tag"
    value = var.jobserviceImageTag
  }

  set {
    name  = "jobservice.replicas"
    value = var.jobserviceReplicas
  }

  set {
    name  = "jobservice.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "jobservice.automountServiceAccountToken"
    value = true
  }

  #REGISTRY
  set {
    name  = "registry.registry.image.repository"
    value = var.registryImageRepository
  }

  set {
    name  = "registry.registry.image.tag"
    value = var.registryImageTag
  }

  set {
    name  = "registry.controller.image.repository"
    value = var.registryControllerImageRepository
  }

  set {
    name  = "registry.controller.image.tag"
    value = var.registryControllerImageTag
  }

  set {
    name  = "registry.replicas"
    value = var.registryReplicas
  }

  set {
    name  = "registry.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "registry.automountServiceAccountToken"
    value = true
  }

  # CHARTMUSEUM
  set {
    name  = "chartmuseum.enabled"
    value = var.chartmuseumEnabled
  }

  set {
    name  = "chartmuseum.image.repository"
    value = var.chartmuseumImageRepository
  }

  set {
    name  = "chartmuseum.image.tag"
    value = var.chartmuseumImageTag
  }

  set {
    name  = "chartmuseum.replicas"
    value = var.chartmuseumReplicas
  }

  set {
    name  = "chartmuseum.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "chartmuseum.automountServiceAccountToken"
    value = true
  }

  # TRIVY
  set {
    name  = "trivy.enabled"
    value = var.trivyEnabled
  }

  set {
    name  = "trivy.image.repository"
    value = var.trivyImageRepository
  }

  set {
    name  = "trivy.image.tag"
    value = var.trivyImageTag
  }

  set {
    name  = "trivy.replicas"
    value = var.trivyReplicas
  }

  set {
    name  = "trivy.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "trivy.automountServiceAccountToken"
    value = true
  }

  # NOTARY
  set {
    name  = "notary.enabled"
    value = var.notaryEnabled
  }

  set {
    name  = "notary.server.image.repository"
    value = var.notaryServerImageRepository
  }

  set {
    name  = "notary.server.image.tag"
    value = var.notaryServerImageTag
  }

  set {
    name  = "notary.server.replicas"
    value = var.notaryServerReplicas
  }

  set {
    name  = "notary.server.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "notary.server.automountServiceAccountToken"
    value = true
  }

  set {
    name  = "notary.signer.image.repository"
    value = var.notarySignerImageRepository
  }

  set {
    name  = "notary.signer.image.tag"
    value = var.notarySignerImageTag
  }

  set {
    name  = "notary.signer.replicas"
    value = var.notarySignerReplicas
  }

  set {
    name  = "notary.signer.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "notary.signer.automountServiceAccountToken"
    value = true
  }

  ########## DATABASE CONFIGURATIONS ###############
  set {
    name  = "database.type"
    value = var.databaseType
  }

  set {
    name  = "database.internal.image.repository"
    value = var.databaseInternalRepository
  }

  set {
    name  = "database.internal.image.tag"
    value = var.databaseInternalTag
  }

  set {
    name  = "database.internal.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "database.internal.automountServiceAccountToken"
    value = true
  }
  
  ### EXTERNAL DATABASE
  set {
    name  = "database.external.host"
    value = var.databaseExternalHost
  }

  set {
    name  = "database.external.port"
    value = var.databaseExternalPort
  }

  set {
    name  = "database.external.username"
    value = var.databaseExternalUsername
  }

  set {
    name  = "database.external.password"
    value = var.databaseExternalPassword
  }
  
  set {
    name  = "database.external.coreDatabase"
    value = var.databaseExternalCoreDatabase
  }

  set {
    name  = "database.external.notaryServerDatabase"
    value = var.databaseExternalNotaryServerDatabase
  }

  set {
    name  = "database.external.notarySignerDatabase"
    value = var.databaseExternalNotarySignerDatabase
  }

  #################################################

  ############ REDIS CONFIGURATIONS ###############
  set {
    name  = "redis.type"
    value = var.redisType
  }

  set {
    name  = "redis.internal.image.repository"
    value = var.redisImageRepository
  }

  set {
    name  = "redis.internal.image.tag"
    value = var.redisImageTag
  }

  set {
    name  = "redis.internal.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "redis.internal.automountServiceAccountToken"
    value = true
  }

  set {
    name  = "redis.external.addr"
    value = var.redisExternalAddress
  }
  #################################################

  ### EXPORTER
  set {
    name  = "exporter.replicas"
    value = var.exporterReplicas
  }

  set {
    name  = "exporter.image.repository"
    value = var.exporterImageRepository
  }

  set {
    name  = "exporter.image.tag"
    value = var.exporterImageTag
  }

  set {
    name  = "exporter.serviceAccountName"
    value = "harbor"
  }

  set {
    name  = "exporter.automountServiceAccountToken"
    value = true
  }
  
}

resource "aws_s3_bucket" "harbor_chart_storage_bucket" {
  count = var.createBucket ? 1 : 0
  bucket = var.bucketName

  tags = {
    Application = "harbor"
  }
}

# AWS ROLE MAPPING SVCACCOUNT
module "iam_harbor" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "3.6.0"
  create_role                   = var.createIAMRole
  role_permissions_boundary_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/policy-iam-boundary"
  role_name                     = "harbor-role"
  provider_url                  = replace(var.iamRoleOIDCIssuerURL, "https://", "")
  role_policy_arns              = [
    aws_iam_policy.harbor[0].arn,
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
  ]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:harbor"]
}

resource "aws_iam_policy" "harbor" {
  count       = var.createIAMRole ? 1 : 0
  name_prefix = "harbor"
  description = "Harbor policy"
  policy      = data.aws_iam_policy_document.harbor.json
}

data "aws_iam_policy_document" "harbor" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${var.bucketName}"
    ]
  }
}

data "aws_caller_identity" "current" {}