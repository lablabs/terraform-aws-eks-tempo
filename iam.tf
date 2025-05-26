locals {
  irsa_policy_enabled = var.irsa_policy_enabled != null ? var.irsa_policy_enabled : var.irsa_assume_role_enabled == false
}

data "aws_iam_policy_document" "this" {
  count = var.enabled && var.irsa_policy == null && local.irsa_policy_enabled ? 1 : 0

  # Example statement (modify it before using this module)
  statement {
    sid = "AllowTempoObjectStor"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
    ]
    # checkov:skip=CKV_AWS_111
    # checkov:skip=CKV_AWS_108
    # checkov:skip=CKV_AWS_356
    resources = [
      "*",
    ]

    effect = "Allow"
  }
}
