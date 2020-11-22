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
# CREATE THE IAM ROLE MODULE TO ENABLE sqs:SendMessage FOR API GATEWAY
# ------------------------------------------------------------------------------

module "iam_role" {
  source = "../../../security/iam/role"

  name            = var.iam_role_name
  policy_template = "templates/api-gateway-permission.json"

  policy_template_args = {
    sqs_arn = module.simple_queue.queue_arn
  }

  assume_role_template = "templates/api-gateway-assume-role.json"
}
