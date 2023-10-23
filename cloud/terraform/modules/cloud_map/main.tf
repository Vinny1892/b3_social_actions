variable "vpc_id" {}

resource "aws_service_discovery_private_dns_namespace" "social_action" {
  name        = "social action"
  description = "example"
  vpc         = var.vpc_id
}


resource "aws_service_discovery_private_dns_namespace" "contract" {
  name        = "contract"
  description = "example"
  vpc         = var.vpc_id
}

resource "aws_service_discovery_service" "b3_social_action" {
  name = "b3_social_action"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.social_action.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  

  health_check_custom_config {
    failure_threshold = 1
  }
}