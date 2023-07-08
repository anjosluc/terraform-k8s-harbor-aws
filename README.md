# terraform-k8s-harbor-aws

<div>
    <img src="https://goharbor.io/img/logos/harbor-icon-color.png" width="200"/>
    <img src="https://avatars.githubusercontent.com/u/31414033?s=280&v=4"/>
</div>

Base module to deploy Harbor on K8S Cluster with S3 storage. Harbor docs are available on https://goharbor.io/docs/1.10/. It can be used to deploy Helm charts, container images and proxy from public container registries.


## Usage

```hcl
module "harbor" {
    source = "git@github.com:anjosluc/terraform-k8s-harbor-aws.git?ref=v1.0.0"
    
    bucketName              = "example-com-harbor-storage-${local.env[var.environment].cluster_name}"
    createBucket            = true
    harborAdminPassword     = var.harborAdminPassword
    ingressCoreDomain       = local.env[var.environment].harborCoreDomain
    ingressNotaryDomain     = local.env[var.environment].harborNotaryDomain
    region                  = var.aws_region
    iamRoleOIDCIssuerURL    = module.eks-prov.cluster_oidc_issuer_url
    ingressClassName        = "nginx-internal"
    ldapSearchPassword      = var.ldapHarborUserPassword
    smtpHost                = local.env[var.environment].harborSmtpHost
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.59.0 |
| <a name="requirement_harbor"></a> [harbor](#requirement\_harbor) | 3.7.1 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.3.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.59.0 |
| <a name="provider_harbor"></a> [harbor](#provider\_harbor) | 3.7.1 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.3.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_harbor"></a> [iam\_harbor](#module\_iam\_harbor) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 3.6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.harbor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_s3_bucket.harbor_chart_storage_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [harbor_config_auth.ldap](https://registry.terraform.io/providers/BESTSELLER/harbor/3.7.1/docs/resources/config_auth) | resource |
| [harbor_config_auth.oidc](https://registry.terraform.io/providers/BESTSELLER/harbor/3.7.1/docs/resources/config_auth) | resource |
| [harbor_config_email.email_configuration](https://registry.terraform.io/providers/BESTSELLER/harbor/3.7.1/docs/resources/config_email) | resource |
| [harbor_config_system.main](https://registry.terraform.io/providers/BESTSELLER/harbor/3.7.1/docs/resources/config_system) | resource |
| [harbor_project.dockerhub_project](https://registry.terraform.io/providers/BESTSELLER/harbor/3.7.1/docs/resources/project) | resource |
| [harbor_registry.dockerhub_registry](https://registry.terraform.io/providers/BESTSELLER/harbor/3.7.1/docs/resources/registry) | resource |
| [helm_release.harbor_release_chart](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.ns_harbor](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.serviceaccount_harbor](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.harbor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_OIDCAdminGroup"></a> [OIDCAdminGroup](#input\_OIDCAdminGroup) | OIDC Admin Group | `string` | `"Harbor Admins"` | no |
| <a name="input_OIDCClientId"></a> [OIDCClientId](#input\_OIDCClientId) | OIDC Client ID | `string` | `""` | no |
| <a name="input_OIDCClientSecret"></a> [OIDCClientSecret](#input\_OIDCClientSecret) | OIDC Client Secret | `string` | `""` | no |
| <a name="input_OIDCEndpoint"></a> [OIDCEndpoint](#input\_OIDCEndpoint) | OIDC Endpoint | `string` | `"https://login.microsoftonline.com/{GUID}/v2.0"` | no |
| <a name="input_OIDCName"></a> [OIDCName](#input\_OIDCName) | OIDC Name to use | `string` | `"azure"` | no |
| <a name="input_OIDCScope"></a> [OIDCScope](#input\_OIDCScope) | OIDC Scope | `string` | `"openid,email"` | no |
| <a name="input_bucketName"></a> [bucketName](#input\_bucketName) | S3 Bucket name to use | `string` | `"harbor-storage"` | no |
| <a name="input_chartmuseumEnabled"></a> [chartmuseumEnabled](#input\_chartmuseumEnabled) | ChartMuseum Enabled | `bool` | `true` | no |
| <a name="input_chartmuseumImageRepository"></a> [chartmuseumImageRepository](#input\_chartmuseumImageRepository) | ChartMuseum Image Repository | `string` | `"goharbor/chartmuseum-photon"` | no |
| <a name="input_chartmuseumImageTag"></a> [chartmuseumImageTag](#input\_chartmuseumImageTag) | ChartMuseum Image Tag | `string` | `"v2.5.0"` | no |
| <a name="input_chartmuseumReplicas"></a> [chartmuseumReplicas](#input\_chartmuseumReplicas) | ChartMuseum Replicas | `string` | `"1"` | no |
| <a name="input_coreImageRepository"></a> [coreImageRepository](#input\_coreImageRepository) | Core Image Repository | `string` | `"goharbor/harbor-core"` | no |
| <a name="input_coreImageTag"></a> [coreImageTag](#input\_coreImageTag) | Core Image Repository | `string` | `"v2.5.0"` | no |
| <a name="input_coreReplicas"></a> [coreReplicas](#input\_coreReplicas) | Core Image Repository | `string` | `"1"` | no |
| <a name="input_createBucket"></a> [createBucket](#input\_createBucket) | Create S3 Bucket? | `bool` | `true` | no |
| <a name="input_createDockerHubProxy"></a> [createDockerHubProxy](#input\_createDockerHubProxy) | (optional) describe your variable | `bool` | `true` | no |
| <a name="input_createIAMRole"></a> [createIAMRole](#input\_createIAMRole) | Create IAM Role for Harbor? (Using EKS Default format) | `bool` | `true` | no |
| <a name="input_createNamespace"></a> [createNamespace](#input\_createNamespace) | Create Namespace? | `bool` | `true` | no |
| <a name="input_createServiceAccount"></a> [createServiceAccount](#input\_createServiceAccount) | Create Service Account? | `bool` | `true` | no |
| <a name="input_databaseExternalCoreDatabase"></a> [databaseExternalCoreDatabase](#input\_databaseExternalCoreDatabase) | DB External Core Database (Required if databaseType = external) | `string` | `"registry"` | no |
| <a name="input_databaseExternalHost"></a> [databaseExternalHost](#input\_databaseExternalHost) | DB External Host (Required if databaseType = external) | `string` | `"192.168.1.2"` | no |
| <a name="input_databaseExternalNotaryServerDatabase"></a> [databaseExternalNotaryServerDatabase](#input\_databaseExternalNotaryServerDatabase) | DB External Notary Server Database (Required if databaseType = external) | `string` | `"notary_server"` | no |
| <a name="input_databaseExternalNotarySignerDatabase"></a> [databaseExternalNotarySignerDatabase](#input\_databaseExternalNotarySignerDatabase) | DB External describe your variable (Required if databaseType = external) | `string` | `"notary_signer"` | no |
| <a name="input_databaseExternalPassword"></a> [databaseExternalPassword](#input\_databaseExternalPassword) | DB External Password (Required if databaseType = external) | `string` | `"password"` | no |
| <a name="input_databaseExternalPort"></a> [databaseExternalPort](#input\_databaseExternalPort) | DB External Port (Required if databaseType = external) | `string` | `"5432"` | no |
| <a name="input_databaseExternalUsername"></a> [databaseExternalUsername](#input\_databaseExternalUsername) | DB External Username (Required if databaseType = external) | `string` | `"user"` | no |
| <a name="input_databaseInternalRepository"></a> [databaseInternalRepository](#input\_databaseInternalRepository) | Database Internal Image Repository | `string` | `"goharbor/harbor-db"` | no |
| <a name="input_databaseInternalTag"></a> [databaseInternalTag](#input\_databaseInternalTag) | Database Internal Image Tag | `string` | `"v2.5.0"` | no |
| <a name="input_databaseType"></a> [databaseType](#input\_databaseType) | Database type to use (external, internal) | `string` | `"internal"` | no |
| <a name="input_emailFrom"></a> [emailFrom](#input\_emailFrom) | (optional) describe your variable | `string` | `"harbor-sre-dev@example-com.cloud"` | no |
| <a name="input_existingIAMRoleARN"></a> [existingIAMRoleARN](#input\_existingIAMRoleARN) | Use Existing Role ARN for Harbor Service Account | `string` | `""` | no |
| <a name="input_exporterImageRepository"></a> [exporterImageRepository](#input\_exporterImageRepository) | External Image Repository | `string` | `"goharbor/harbor-exporter"` | no |
| <a name="input_exporterImageTag"></a> [exporterImageTag](#input\_exporterImageTag) | External Image Tag | `string` | `"v2.5.0"` | no |
| <a name="input_exporterReplicas"></a> [exporterReplicas](#input\_exporterReplicas) | External Replicas | `string` | `"1"` | no |
| <a name="input_harborAdminPassword"></a> [harborAdminPassword](#input\_harborAdminPassword) | Harbor Admin Password | `string` | n/a | yes |
| <a name="input_iamRoleOIDCIssuerURL"></a> [iamRoleOIDCIssuerURL](#input\_iamRoleOIDCIssuerURL) | Cluster OIDC Issuer URL (Only valid for EKS clusters with OIDC Providers and createIAMRole = true) | `string` | `"https://"` | no |
| <a name="input_ingressClassName"></a> [ingressClassName](#input\_ingressClassName) | Ingress Class Name | `string` | `"nginx"` | no |
| <a name="input_ingressCoreDomain"></a> [ingressCoreDomain](#input\_ingressCoreDomain) | Ingress Core DNS | `string` | n/a | yes |
| <a name="input_ingressNotaryDomain"></a> [ingressNotaryDomain](#input\_ingressNotaryDomain) | Ingress Notary DNS | `string` | n/a | yes |
| <a name="input_jobserviceImageRepository"></a> [jobserviceImageRepository](#input\_jobserviceImageRepository) | JobService Image Repository | `string` | `"goharbor/harbor-jobservice"` | no |
| <a name="input_jobserviceImageTag"></a> [jobserviceImageTag](#input\_jobserviceImageTag) | JobService Image Repository | `string` | `"v2.5.0"` | no |
| <a name="input_jobserviceReplicas"></a> [jobserviceReplicas](#input\_jobserviceReplicas) | JobService Replicas | `string` | `"1"` | no |
| <a name="input_ldapBaseDN"></a> [ldapBaseDN](#input\_ldapBaseDN) | LDAP Base DN | `string` | `"dc=example,dc=com"` | no |
| <a name="input_ldapGroupAdminDN"></a> [ldapGroupAdminDN](#input\_ldapGroupAdminDN) | LDAP Group Admin DN | `string` | `"cn=harbor-admins,ou=managementgroups,dc=example,dc=com"` | no |
| <a name="input_ldapGroupBaseDN"></a> [ldapGroupBaseDN](#input\_ldapGroupBaseDN) | LDAP Group Base DN | `string` | `"ou=ManagementGroups,dc=example,dc=com"` | no |
| <a name="input_ldapSearchDN"></a> [ldapSearchDN](#input\_ldapSearchDN) | LDAP Search DN | `string` | `"cn=svc_harbor,dc=example,dc=com"` | no |
| <a name="input_ldapSearchPassword"></a> [ldapSearchPassword](#input\_ldapSearchPassword) | LDAP Search Password | `string` | `""` | no |
| <a name="input_ldapURL"></a> [ldapURL](#input\_ldapURL) | LDAP URL | `string` | `"ldap://10.0.0.1"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name | `string` | `"harbor"` | no |
| <a name="input_nginxImageRepository"></a> [nginxImageRepository](#input\_nginxImageRepository) | Nginx Image Repository | `string` | `"goharbor/nginx-photon"` | no |
| <a name="input_nginxImageTag"></a> [nginxImageTag](#input\_nginxImageTag) | Nginx Image Tag | `string` | `"v2.5.0"` | no |
| <a name="input_nginxReplicas"></a> [nginxReplicas](#input\_nginxReplicas) | Nginx Replicas | `string` | `"3"` | no |
| <a name="input_notaryEnabled"></a> [notaryEnabled](#input\_notaryEnabled) | Notary Enabled? | `bool` | `true` | no |
| <a name="input_notaryServerImageRepository"></a> [notaryServerImageRepository](#input\_notaryServerImageRepository) | Notary Server Image Repository | `string` | `"goharbor/notary-server-photon"` | no |
| <a name="input_notaryServerImageTag"></a> [notaryServerImageTag](#input\_notaryServerImageTag) | Notary Server Image Tag | `string` | `"v2.5.0"` | no |
| <a name="input_notaryServerReplicas"></a> [notaryServerReplicas](#input\_notaryServerReplicas) | Notary Server Replicas | `string` | `"1"` | no |
| <a name="input_notarySignerImageRepository"></a> [notarySignerImageRepository](#input\_notarySignerImageRepository) | Notary Signer Image Repository | `string` | `"goharbor/notary-signer-photon"` | no |
| <a name="input_notarySignerImageTag"></a> [notarySignerImageTag](#input\_notarySignerImageTag) | Notary Signer Image Tag | `string` | `"v2.5.0"` | no |
| <a name="input_notarySignerReplicas"></a> [notarySignerReplicas](#input\_notarySignerReplicas) | Notary Signer Replicas | `string` | `"1"` | no |
| <a name="input_portalImageRepository"></a> [portalImageRepository](#input\_portalImageRepository) | Portal Image Repository | `string` | `"goharbor/harbor-portal"` | no |
| <a name="input_portalImageTag"></a> [portalImageTag](#input\_portalImageTag) | Portal Image Repository | `string` | `"v2.5.0"` | no |
| <a name="input_portalReplicas"></a> [portalReplicas](#input\_portalReplicas) | Portal Image Repository | `string` | `""` | no |
| <a name="input_redisExternalAddress"></a> [redisExternalAddress](#input\_redisExternalAddress) | Redis External Addresss | `string` | `"192.168.0.2:6379"` | no |
| <a name="input_redisImageRepository"></a> [redisImageRepository](#input\_redisImageRepository) | Redis Image Repository | `string` | `"goharbor/redis-photon"` | no |
| <a name="input_redisImageTag"></a> [redisImageTag](#input\_redisImageTag) | Redis Image Tag | `string` | `"v2.5.0"` | no |
| <a name="input_redisType"></a> [redisType](#input\_redisType) | Redis type to use (external, internal) | `string` | `"internal"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS REGION to deploy bucket | `string` | n/a | yes |
| <a name="input_registryControllerImageRepository"></a> [registryControllerImageRepository](#input\_registryControllerImageRepository) | Registry Controller Image Repository | `string` | `"goharbor/harbor-registryctl"` | no |
| <a name="input_registryControllerImageTag"></a> [registryControllerImageTag](#input\_registryControllerImageTag) | Registry Controller Image Tag | `string` | `"v2.5.0"` | no |
| <a name="input_registryImageRepository"></a> [registryImageRepository](#input\_registryImageRepository) | Registry Image Repository | `string` | `"goharbor/registry-photon"` | no |
| <a name="input_registryImageTag"></a> [registryImageTag](#input\_registryImageTag) | Registry Image Tag | `string` | `"v2.5.0"` | no |
| <a name="input_registryReplicas"></a> [registryReplicas](#input\_registryReplicas) | Registry Replicas | `string` | `"1"` | no |
| <a name="input_smtpHost"></a> [smtpHost](#input\_smtpHost) | (optional) describe your variable | `string` | `"mail.example.com"` | no |
| <a name="input_trivyEnabled"></a> [trivyEnabled](#input\_trivyEnabled) | Trivy Enabled? | `bool` | `true` | no |
| <a name="input_trivyImageRepository"></a> [trivyImageRepository](#input\_trivyImageRepository) | Trivy Image Repository | `string` | `"goharbor/trivy-adapter-photon"` | no |
| <a name="input_trivyImageTag"></a> [trivyImageTag](#input\_trivyImageTag) | Trivy Image Tag | `string` | `"v2.5.0"` | no |
| <a name="input_trivyReplicas"></a> [trivyReplicas](#input\_trivyReplicas) | Trivy Replicas | `string` | `"1"` | no |
| <a name="input_useLDAPAuth"></a> [useLDAPAuth](#input\_useLDAPAuth) | Use LDAP for authentication? | `bool` | `true` | no |
| <a name="input_useOIDCAuth"></a> [useOIDCAuth](#input\_useOIDCAuth) | Use OIDC for authentication? | `bool` | `false` | no |
| <a name="input_useSMTP"></a> [useSMTP](#input\_useSMTP) | Use SMTP? | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_HarborChartValues"></a> [HarborChartValues](#output\_HarborChartValues) | Harbor Release Values |
| <a name="output_HarborChartVersion"></a> [HarborChartVersion](#output\_HarborChartVersion) | Harbor Chart Version |
| <a name="output_HarborCoreIngressDomain"></a> [HarborCoreIngressDomain](#output\_HarborCoreIngressDomain) | Default Domain to Access Harbor |
| <a name="output_HarborName"></a> [HarborName](#output\_HarborName) | Harbor Release Name |
| <a name="output_HarborNamespace"></a> [HarborNamespace](#output\_HarborNamespace) | Harbor Namespace |
| <a name="output_HarborNotaryIngressDomain"></a> [HarborNotaryIngressDomain](#output\_HarborNotaryIngressDomain) | Notary Domain to Access Harbor |
<!-- END_TF_DOCS -->
