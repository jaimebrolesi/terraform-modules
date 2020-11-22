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
# CREATE THE IAM ROLE MODULE ENABLING PERMISSION sqs:SendMessage FOR API GATEWAY
# ------------------------------------------------------------------------------

data "template_file" "policy_template" {
  template = file("${path.module}/policies/api-gateway-permission.json")

  vars = {
    sqs_arn = module.simple_queue.queue_arn
  }
}

data "template_file" "assume_role_template" {
  template = file("${path.module}/policies/api-gateway-assume-role.json")
}

module "iam_role" {
  source = "../../../security/iam/role"

  name                 = var.iam_role_name
  policy_template      = data.template_file.policy_template.rendered
  assume_role_template = data.template_file.assume_role_template.rendered
}

module "api_gateway" {
  source = "./api-gateway"

  name         = var.api_gateway_name
  description  = var.api_gateway_description
  iam_role_arn = module.iam_role.iam_role_arn
  queue_name   = module.simple_queue.queue_name
  aws_region   = var.aws_region

  depends_on = [module.iam_role.attach_policy_role]
}
