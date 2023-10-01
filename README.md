## AWS Gitea Application Development Pipeline

### Overview

This Terraform project manages the infrastructure required to set up a CI/CD pipeline for a Gitea application on AWS. The pipeline is triggered by changes in a private GitHub repository, automatically builds the application, deploys it to AWS Elastic Beanstalk, and connects it to an Amazon RDS PostgreSQL database.

### Pipeline Workflow

1. **GitHub Repository:** This project assumes you have a private GitHub repository hosting your Gitea application code.

2. **CodePipeline Configuration:** The Terraform configuration includes the setup of an AWS CodePipeline. The pipeline is configured to monitor changes in your GitHub repository.

3. **CodeBuild Stage:** When changes are detected in your GitHub repository, AWS CodePipeline triggers a CodeBuild stage. This stage compiles your application code, creates an artifact, and packages it as a ZIP archive.

4. **Amazon S3 Artifact Storage:** The resulting ZIP archive is stored in an Amazon S3 bucket. This bucket acts as an artifact repository.

5. **Elastic Beanstalk Deployment:** After the CodeBuild stage is successful, the pipeline triggers a deployment to AWS Elastic Beanstalk. Elastic Beanstalk is used to host and manage the Gitea application.

6. **Amazon RDS Integration:** The Elastic Beanstalk environment connects to an Amazon RDS PostgreSQL database, which is created and managed by Elastic Beanstalk.

### Infrastructure as Code

The pipeline setup and the required infrastructure are managed as code using Terraform. You can initialize, plan, and apply these configurations using Terraform commands:

```bash
terraform init
terraform plan
terraform apply
```

Please note that after setting up the pipeline infrastructure, you need to manually connect your AWS CodePipeline to your GitHub repository using AWS CodeStar Connections. You can find more information about CodeStar Connections in the [Terraform AWS Provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarconnections_connection).

### Prerequisites

Before using this Terraform configuration, make sure you have:

- A private GitHub repository containing your Gitea application code.
- AWS credentials configured on your local environment with the necessary permissions.
- Terraform installed and configured on your local machine.
- AWS CLI installed and configured on your local machine.

### Usage

1. Clone this repository to your local environment.

2. Modify the Terraform configurations in this repository as needed to match your specific requirements (Optional).

3. Set TF_VAR_gh_token in environment or change file with this variable in giteaAWS-codebuild-terraform/vars.tf
   ```bash
   export TF_VAR_gh_token="<token>"
   ```

5. Run the following commands in root of project to set up the infrastructure:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

6. After applying the Terraform configuration, manually connect your AWS CodePipeline to your GitHub repository in AWS Console in CodePipeline edit page. (strange terraform politic idk **https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarconnections_connection**)

7. Once everything is set up, any changes made to your GitHub repository will trigger the CI/CD pipeline.
