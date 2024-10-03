# 🚜 AWS Docker Infrastructure

### Main branch structure:
1. [Fargate](./fargate/README.md)
2. [CodePipeline](./codepipeline/README.md)
3. [NodeJS Express App](./fargate/docker/nodejs-express/README.md)

#### **IaC - [Fargate](./fargate/README.md)**:
- [x] **Virtual Private Cloud** (VPC)
    - Subnets
    - Internet Gateway
    - Route Tables
    - NAT Gateway
- [x] **Application Load Balancer** (ALB)
    - ALB Target Group
    - ALB Listener
    - ALB Health Checks
- [x] **IAM Policies & Roles**
- [x] **Environment Variables & Secrets**
- [x] **Security Groups**
- [x] **Elastic Container Service** (ECS)
    - ECS Cluster
    - ECS Task Definition
    - ECS Service
- [x] **Elastic Container Registry** (ECR)

#### **CI/CD - [CodePipeline](./codepipeline/README.md)**:
- [x] **CodePipeline**
- [x] **CodeBuild**
- [x] **CodeDeploy**
    - Blue/Green Deployment
- [x] **Codestar Connection**
- [X] **IAM Policies & Roles**
- [X] **S3 Bucket Artifacts**

#### **[NodeJS Express](./fargate/docker/nodejs-express/README.md) Boilerplate**:
- [x] `Dockerfile`
- [x] `buildspec.yml`
- [x] `appspec_template.yaml`
