#resource "aws_codebuild_webhook" "gitea" {
#  project_name = aws_codebuild_project.gitea_build.name
#}

#resource "github_repository_webhook" "gitea" {
#  active     = true
#  events     = ["push"]
#  repository = var.gh_repo_name
#
#
#  configuration {
#    url          = local.gh_repo_url
#    secret       = aws_codebuild_webhook.gitea.secret
#    content_type = "json"
#    insecure_ssl = false
#  }
#}

resource "aws_codestarconnections_connection" "github-connection" {
  name          = "github-connection"
  provider_type = "GitHub"
}

resource "aws_codebuild_source_credential" "gitea_build" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = var.gh_token
}
