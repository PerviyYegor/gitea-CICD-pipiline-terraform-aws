output "gitea-environment" {
  value = aws_elastic_beanstalk_environment.dev_env.name
}

output "gitea-application" {
  value = aws_elastic_beanstalk_application.elasticapp.name
}