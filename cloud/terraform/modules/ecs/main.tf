variable "docker_image" {
  default = "nginx"
}


variable "acm_certificate" {
  
}

variable "subnets" {
  
}

variable "security_group" {
  
}
variable "elb_target_group_arn" {
  
}

#LOG

resource "aws_cloudwatch_log_group" "teste" {
  name = "teste"
}

#IAM

resource "aws_iam_role" "task_execution_ecs" {
  name = "task_execution_ecs"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "example_attachment" {
  role       = aws_iam_role.task_execution_ecs.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS

resource "aws_ecs_cluster" "application" {

  name = "clusterzinho_teste"

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}


resource "aws_ecs_task_definition" "gateway" {
  container_definitions = jsonencode(
    [
      {
        cpu              = 0
        environment      = []
        environmentFiles = []
        image            =  var.docker_image
         logConfiguration = {
           logDriver = "awslogs"
            options = {
              awslogs-create-group  = "true"
              awslogs-group         =  aws_cloudwatch_log_group.teste.name
              awslogs-region        = "us-east-1" # colocar como variavel
              awslogs-stream-prefix = "ecs"
            }
            secretOptions = []
          }
        mountPoints = []
        essential   = true
        name        = "api_gateway" # colocar como variavel
        portMappings = [
          {
            containerPort = 80 # colocar como variavel
            hostPort      = 80 # colocar como variavel
          },
        ]
        ulimits     = []
        volumesFrom = []
      },
    ]
  )
  skip_destroy       = true
  cpu                = "256" # colocar como variavel
  execution_role_arn =  aws_iam_role.task_execution_ecs.arn
  family             = "gateway" # colocar como variavel
  memory             = "512" # colocar como variavel
  network_mode       = "awsvpc"
  requires_compatibilities = [
    "FARGATE",
  ]

  runtime_platform { # forces replacement
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

}

resource "aws_ecs_service" "gateway" {
  cluster = aws_ecs_cluster.application.id
  desired_count                     = 1
  enable_ecs_managed_tags           = true
  health_check_grace_period_seconds = 0
  name                              = "gateway" # colocar como variavel
  platform_version                  = "LATEST"
  propagate_tags                    = "NONE"
  task_definition                   = aws_ecs_task_definition.gateway.arn
  triggers                          = {}
  wait_for_steady_state             = false

  capacity_provider_strategy { # forces replacement
    base              = 0
    capacity_provider = "FARGATE"
    weight            = 1
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    assign_public_ip = true
    security_groups = var.security_group
    subnets = var.subnets
  }

  service_registries {
    container_port = 0
    port           = 0
    registry_arn   = aws_service_discovery_service.example.arn
  }

  load_balancer {
    target_group_arn = var.elb_target_group_arn
    container_name   = "api_gateway"
    container_port   = 80
  }
}







# CLOUD MAP
variable "vpc_id" {}

resource "aws_service_discovery_private_dns_namespace" "b3_social_action" {
  name = "teste_tf"
  vpc = var.vpc_id

}

resource "aws_service_discovery_service" "example" {
  name = "example"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.b3_social_action.id

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


