module "nginx" {
  source = "../../../../modules/ecr"
  name   = "jobpair-prod-nginx"
}

module "php" {
  source = "../../../../modules/ecr"

  name = "jobpair-prod-php"
}