locals {
  roleARN = var.createIAMRole ? module.iam_harbor.this_iam_role_arn : var.existingIAMRoleARN
}