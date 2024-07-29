resource "aws_ecs_cluster" "this" {
  name = "jobpair-prod-ecs"

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT"
  ]

  tags = {
    Name = "jobpair-prod-ecs"
  }
}

# resource "aws_ecs_task_definition" "this" {
#   family = "jobpair-prod"

#   task_role_arn = "arn:aws:iam::502674413540:role/jobpair-prod-ecs-task"

#   network_mode = "awsvpc"

#   requires_compatibilities = [
#     "FARGATE",
#   ]

#   execution_role_arn = "arn:aws:iam::502674413540:role/jobpair-prod-ecs-task-execution"

#   memory = "512"
#   cpu    = "256"

#   container_definitions = jsonencode(
#     [
#       {
#         name  = "nginx"
#         image = "502674413540.dkr.ecr.ap-northeast-1.amazonaws.com/jobpair-prod-nginx:latest"

#         portMappings = [
#           {
#             containerPort = 80
#             protocol      = "tcp"
#           }
#         ]

#         environment = []
#         secrets     = []

#         dependsOn = [
#           {
#             containerName = "php"
#             condition     = "START"
#           }
#         ]

#         logConfiguration = {
#           logDriver = "awslogs"
#           options = {
#             awslogs-group         = "/ecs/jobpair-prod/nginx"
#             awslogs-region        = "ap-northeast-1"
#             awslogs-stream-prefix = "ecs"
#           }
#         }
#       },
#       {
#         name  = "php"
#         image = "502674413540.dkr.ecr.ap-northeast-1.amazonaws.com/jobpair-prod-php:latest"

#         portMappings = []

#         environment = []
#         secrets = [
#           {
#             name      = "APP_KEY"
#             valueFrom = "/jobpair/prod/APP__KEY"
#           }
#         ]

#         logConfiguration = {
#           logDriver = "awslogs"
#           options = {
#             awslogs-group         = "/ecs/jobpair-prod/php"
#             awslogs-region        = "ap-northeast-1"
#             awslogs-stream-prefix = "ecs"
#           }
#         }
#       }
#     ]
#   )

#   tags = {
#     Name = "jobpair-prod"
#   }
# }

# resource "aws_ecs_service" "this" {
#   name = "jobpair-prod"

#   cluster = aws_ecs_cluster.this.arn

#   capacity_provider_strategy {
#     capacity_provider = "FARGATE_SPOT"
#     base              = 0
#     weight            = 1
#   }

#   platform_version = "1.4.0"

#   task_definition = aws_ecs_task_definition.this.arn

#   desired_count                      = var.desired_count
#   deployment_minimum_healthy_percent = 100
#   deployment_maximum_percent         = 200
#   deployment_circuit_breaker {
#     enable   = true
#     rollback = true
#   }

#   load_balancer {
#     container_name   = "nginx"
#     container_port   = 80
#     target_group_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:502674413540:targetgroup/jobpair-test-target-1/f62fa904d105269a"
#   }

#   health_check_grace_period_seconds = 60

#   network_configuration {
#     assign_public_ip = false
#     security_groups = [
#       "sg-09c9350a8c33f86a8"
#     ]
#     subnets = [
#       "subnet-0c5c7265a8772cfd0",
#       "subnet-0c09a6e0f6d3c3a1f"
#     ]
#   }

#   enable_execute_command = true

#   tags = {
#     Name = "jobpair-prod"
#   }
# }
