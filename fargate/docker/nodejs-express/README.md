# NodeJS Express Image

## Install NodeJS

```bash
choco install nodejs-lts --version="20.17.0"
node -v
```

## Init NodeJS

```bash
cd nodejs-express/app
npm init -y
```

## Authenticate with Docker

```bash
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin <id>.dkr.ecr.eu-west-2.amazonaws.com
```

## Build the Image

```bash
docker build --tag nodejs-express ./app
```

## Push the Image to ECR

```bash
docker images
docker tag e917f2d8a823 <id>.dkr.ecr.eu-west-2.amazonaws.com/nodejs-express:latest
docker push <id>.dkr.ecr.eu-west-2.amazonaws.com/nodejs-express:latest
```

## Run the Image

```bash
docker run -d -p 3000:3000 nodejs-express
```