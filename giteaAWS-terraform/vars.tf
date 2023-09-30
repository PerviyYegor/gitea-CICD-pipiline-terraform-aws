variable "elasticapp" {
  default = "gitea-app"
}
variable "beanstalkappenv" {
  default = "gitea-env"
}
variable "solution_stack_name" {
  default = "64bit Amazon Linux 2023 v6.0.1 running Node.js 18"
}
variable "tier" {
  default = "WebServer"
}

locals {
  app_env = {
    DB_SSL_MODE = "true"
    SITE_URL    = ""


    DB_USERNAME            = "root"
    DB_PASSWORD            = "somePassword"
    DB_NAME                = "gitea"
    SERVER_PORT            = 5432
    DB_ENGINE              = "postgres"
  }
}

variable "s3_bucket" {
  description = "The S3 bucket to use"
  type        = string
}
