output "HarborCoreIngressDomain" {
    value = var.ingressCoreDomain
    description = "Default Domain to Access Harbor"
}

output "HarborNotaryIngressDomain" {
    value = var.ingressNotaryDomain
    description = "Notary Domain to Access Harbor"
}

output "HarborNamespace" {
    value = helm_release.harbor_release_chart.namespace
    description = "Harbor Namespace"
}

output "HarborName" {
    value = helm_release.harbor_release_chart.name
    description = "Harbor Release Name"
}

output "HarborChartVersion" {
    value = helm_release.harbor_release_chart.version
    description = "Harbor Chart Version"
}

output "HarborChartValues" {
    value = helm_release.harbor_release_chart.values
    description = "Harbor Release Values"
}