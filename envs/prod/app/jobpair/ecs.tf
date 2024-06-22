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

resource "aws_ecs_task_definition" "this" {
  family = "jobpair-prod"

  task_role_arn = "arn:aws:iam::502674413540:role/jobpair-prod-ecs-task"

  network_mode = "awsvpc"

  requires_compatibilities = [
    "FARGATE",
  ]

  execution_role_arn = "arn:aws:iam::502674413540:user/jobpair-prod-ecs-task-execution"

  memory = "512"
  cpu    = "256"

  container_definitions = jsonencode(
    [
      {
        name  = "nginx"
        image = "502674413540.dkr.ecr.ap-northeast-1.amazonaws.com/jobpair-prod-nginx:latest"

        portMappings = [
          {
            containerPort = 80
            protocol      = "tcp"
          }
        ]

        environment = []
        secrets     = []

        dependsOn = [
          {
            containerName = "php"
            condition     = "START"
          }
        ]

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = "/ecs/jobpair-prod/nginx"
            awslogs-region        = "502674413540"
            awslogs-stream-prefix = "ecs"
          }
        }
      },
      {
        name  = "php"
        image = "502674413540.dkr.ecr.ap-northeast-1.amazonaws.com/jobpair-prod-php:latest"

        portMappings = []

        environment = []
        secrets = [
          {
            name      = "APP_KEY"
            valueFrom = "/jobpair/prod/APP_KEY"
          }
        ]

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = "/ecs/jobpair-prod/php"
            awslogs-region        = "502674413540"
            awslogs-stream-prefix = "ecs"
          }
        }
      }
    ]
  )

  tags = {
    Name = "jobpair-prod"
  }
}
