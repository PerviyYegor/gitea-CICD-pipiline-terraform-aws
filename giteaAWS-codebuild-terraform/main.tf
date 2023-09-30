resource "aws_s3_bucket" "gitea-versions" {
  bucket = "gitea-versions"
  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "retention"
    enabled = true
    noncurrent_version_expiration {
      days = 90
    }
  }
}



resource "aws_codepipeline" "codepipeline" {
  name     = "gitea-build-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.gitea-versions.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github-connection.arn
        FullRepositoryId = "${var.gh_owner_name}/${var.gh_repo_name}"
        BranchName       = var.gr_branch
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = 1

      configuration = {
        ProjectName = "gitea-codebuild-project"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      input_artifacts = ["build_output"]
      version         = 1

      configuration = {
        ApplicationName = var.gitea-application
        EnvironmentName = var.gitea-environment
      }
    }
  }
}
