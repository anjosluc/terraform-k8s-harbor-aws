resource "harbor_config_auth" "ldap" {
  count                = var.useLDAPAuth ? 1 : 0
  depends_on = [
    helm_release.harbor_release_chart
  ]
  auth_mode             = "ldap_auth"
  ldap_url              = var.ldapURL
  ldap_search_dn        = var.ldapSearchDN
  ldap_search_password  = var.ldapSearchPassword
  ldap_base_dn          = var.ldapBaseDN
  ldap_group_admin_dn   = var.ldapGroupAdminDN
  ldap_group_base_dn    = var.ldapGroupBaseDN
  ldap_uid              = "sAMAccountName"
  ldap_filter           = "objectclass=user"
  ldap_group_gid        = "cn"
  ldap_group_filter     = "objectclass=group"
  ldap_group_membership = "memberof"
  ldap_verify_cert      = false
}

resource "harbor_config_auth" "oidc" {
  count              = var.useOIDCAuth ? 1 : 0
  depends_on = [
    helm_release.harbor_release_chart
  ]
  auth_mode          = "oidc_auth"
  oidc_name          = var.OIDCName
  oidc_endpoint      = var.OIDCEndpoint
  oidc_client_id     = var.OIDCClientId
  oidc_client_secret = var.OIDCClientSecret
  oidc_scope         = var.OIDCScope
  oidc_verify_cert   = true
  oidc_auto_onboard  = true
  oidc_user_claim    = "name"
  oidc_admin_group   = var.OIDCAdminGroup
}

resource "harbor_config_email" "email_configuration" {
    depends_on = [
        helm_release.harbor_release_chart
    ]
    count          = var.useSMTP ? 1 : 0
    email_host     = var.smtpHost
    email_from     = var.emailFrom
    email_username = var.emailFrom 
}

resource "harbor_config_system" "main" {
    depends_on = [
        helm_release.harbor_release_chart
    ]
    project_creation_restriction = "adminonly"
}

resource "harbor_registry" "dockerhub_registry" {
    depends_on = [
        helm_release.harbor_release_chart
    ]
    count         = var.createDockerHubProxy ? 1 : 0
    provider_name = "docker-hub"
    name          = "docker-hub"
    endpoint_url  = "https://hub.docker.com"
}

resource "harbor_project" "dockerhub_project" {
    depends_on  = [
        helm_release.harbor_release_chart,
        harbor_registry.dockerhub_registry
    ]
    count       = var.createDockerHubProxy ? 1 : 0
    name        = "docker-hub"
    public      = "true"
    registry_id = harbor_registry.dockerhub_registry[count.index].registry_id
}