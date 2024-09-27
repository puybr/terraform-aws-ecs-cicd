# AWS ECS Fargate

### Running the Code

1. Provision ECR by running the following commands:

```bash
cd ecr-infra
terraform init
terraform plan
terraform apply
```

2. Provision ECS by running the following commands:

```bash
cd ecs-infra
terraform init
terraform plan
terraform apply
```