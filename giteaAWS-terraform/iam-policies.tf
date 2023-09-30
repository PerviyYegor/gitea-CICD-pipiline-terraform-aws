resource "aws_iam_role" "beanstalk_service" {
  name = "beanstalk_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_policy" "beanstalk_create_app_version_policy" {
  name        = "beanstalk-create-app-version-policy"
  description = "Policy to allow creating Elastic Beanstalk Application Versions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "elasticbeanstalk:CreateApplicationVersion",
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "beanstalk_create_app_version_attach" {
  policy_arn = aws_iam_policy.beanstalk_create_app_version_policy.arn
  role       = aws_iam_role.beanstalk_service.name
}

resource "aws_iam_role_policy_attachment" "beanstalk_log_attach" {
  role       = aws_iam_role.beanstalk_service.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_instance_profile" "beanstalk_iam_instance_profile" {
  name = "beanstalk_iam_instance_profile"
  role = aws_iam_role.beanstalk_service.name
}