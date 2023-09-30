resource "aws_codebuild_project" "gitea_build" {
  name          = "gitea-codebuild-project"
  description   = "Gitea CodeBuild project"
  build_timeout = 60
  service_role  = aws_iam_role.gitea_build.arn

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "amazonlinux:2023"
    type         = "LINUX_CONTAINER"
  }

  artifacts {
    type                   = "S3"
    override_artifact_name = false
    namespace_type         = "BUILD_ID"
    packaging              = "ZIP"
    location               = aws_s3_bucket.gitea-versions.bucket
  }

    source {
    type            = "GITHUB"
    location        = local.gh_repo_url
    git_clone_depth = 1
  }
}