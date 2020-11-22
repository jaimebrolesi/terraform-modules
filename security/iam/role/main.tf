terraform {
  required_version = ">= 0.13.5"
}

# ------------------------------------------------------------------------------
# CREATE THE IAM ROLE
# ------------------------------------------------------------------------------

resource "aws_iam_role" "role" {
  name               = "${var.name}Role"
  assume_role_policy = var.assume_role_template
}

# ------------------------------------------------------------------------------
# CREATE IAM POLICY
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "policy" {
  name   = "${var.name}Policy"
  policy = var.policy_template
}

# ------------------------------------------------------------------------------
# ATTACH IAM POLICY ON IAM ROLE
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "attach_policy_role" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
