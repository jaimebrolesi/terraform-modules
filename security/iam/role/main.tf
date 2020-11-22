terraform {
  required_version = ">= 0.13.5"
}

# ------------------------------------------------------------------------------
# LOAD ASSUME ROLE TEMPLATE
# ------------------------------------------------------------------------------

data "template_file" "assume_role_template" {
  template = file(var.assume_role_template)
}

# ------------------------------------------------------------------------------
# CREATE THE IAM ROLE
# ------------------------------------------------------------------------------

resource "aws_iam_role" "role" {
  name               = upper("${var.name}_ROLE")
  assume_role_policy = data.template_file.assume_role_template.rendered
}

# ------------------------------------------------------------------------------
# LOAD IAM POLICY TEMPLATE
# ------------------------------------------------------------------------------

data "template_file" "policy_template" {
  template = file(var.policy_template)
  vars     = var.policy_template_args
}

# ------------------------------------------------------------------------------
# CREATE IAM POLICY
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "policy" {
  name   = upper("${var.name}_POLICY")
  policy = data.template_file.policy_template.rendered
}

# ------------------------------------------------------------------------------
# ATTACH IAM POLICY ON IAM ROLE
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "attach_policy_role" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
