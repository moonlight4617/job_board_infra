module "nginx" {
  source = "../../../../modules/ecr"
  name   = "jobpair-prod-nginx"
}

module "php" {
  source = "../../../../modules/ecr"

  name = "jobpair-prod-php"
}

module "mysql" {
  source = "../../../../modules/ecr"

  name = "jobpair-prod-mysql"
}
