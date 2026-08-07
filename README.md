# Memos on AWS ECS Deployment

## Overview

This project demonstrates the deployment of the open-source Memos application to AWS using Docker, Amazon ECS/Fargate and Terraform.

The project follows the progression recommended for the ECS project:

**ClickOps → Terraform → CI/CD**

The infrastructure was initially created manually using the AWS Console to understand how the individual AWS services interact. The infrastructure was then destroyed and recreated using Terraform as Infrastructure as Code (IaC).

The final deployment uses:

- Docker for application containerisation
- Amazon ECR for container image storage
- Amazon ECS/Fargate for running the application
- Application Load Balancer (ALB) for traffic distribution
- AWS Certificate Manager (ACM) for HTTPS
- Route 53 for DNS
- Terraform for infrastructure provisioning
- Amazon S3 for Terraform remote state
- DynamoDB for Terraform state locking
- GitHub Actions for CI/CD
- GitHub Actions OIDC for AWS authentication
- Automated post-deployment health checks

**Final Application**

The final application is available at:

https://tm.aftabn10.co.uk

![image](images/memos-signin.png)

![image](images/memos-app.png)

# 1. Application Setup

## Application Selection

For this project I selected *Memos*, an open-source self-hosted note-taking application written in Go.

I chose Memos because it provided a realistic lightweight application that could be containerised and deployed to ECS/Fargate, while allowing the focus of the project to remain on the infrastructure, containerisation and deployment rather than application development.

*Application*: Memos
*Language*: Go
*Application documentation*: Use Memos documentation
*Source code*: Use Memos GitHub repository

# Running Memos Locally

Before introducing Docker or AWS infrastructure, I first verified that the application could run successfully on my local machine.

I navigated to the application directory:
```bash
cd ECS-Project/app/memos
```
The application was started using:
```bash
go run ./cmd/memos/main.go --port 80
```
This allowed the application to be accessed locally at:
```bash
http://localhost:80
```
## Health Endpoint

The project specification requested a `/health` endpoint.

However, after inspecting the Memos source code, I found that the application actually exposes its health endpoint at:
```bash
/healthz
```
I identified this by searching the source code:
```bash
grep -r "health" .
```
This identified the health endpoint in the Memos server configuration.

The endpoint was then tested using:
```bash
curl http://localhost:80/healthz
```
The application returned:
```bash
Service Ready
```
This confirmed that the application was running successfully and that its health endpoint was accessible before moving on to containerisation.

