terraform {
  required_version = ">= 0.13.5"
}

# ------------------------------------------------------------------------------
# CREATE THE QUEUE MODULE TO ATTACH IT ON API GATEWAY
# ------------------------------------------------------------------------------

module "simple_queue" {
  source = "../../../mgmt/sqs/simple"

  name = var.queue_name
}

# ------------------------------------------------------------------------------
# LOAD IAM POLICY TEMPLATE AND ASSUME ROLE TEMPLATE
# ------------------------------------------------------------------------------

data "template_file" "policy_template" {
  template = file("templates/api-gateway-permission.json")

  vars = {
    sqs_arn = module.simple_queue.queue_arn
  }
}

data "template_file" "assume_role_template" {
  template = file("templates/api-gateway-assume-role.json")
}

# ------------------------------------------------------------------------------
# CREATE THE IAM ROLE MODULE TO ENABLE sqs:SendMessage FOR API GATEWAY
# ------------------------------------------------------------------------------

module "iam_role" {
  source = "../../../security/iam/role"

  name                 = var.iam_role_name
  policy_template      = data.template_file.policy_template.rendered
  assume_role_template = data.template_file.assume_role_template.rendered
}
