# Build module
module "build-module" {
  source = "./giteaAWS-codebuild-terraform"
  gitea-environment = module.app-module.gitea-environment
  gitea-application = module.app-module.gitea-application
}

#App module
module "app-module" {
  source = "./giteaAWS-terraform"
  s3_bucket = module.build-module.s3_bucket
}