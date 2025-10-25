# DevOps Automation Project — FastAPI + Terraform + MicroK8s + CI/CD

## Skills Demonstrated
Terraform · Azure Cloud · CI/CD Pipelines · GitHub Actions · FastAPI · Python · Docker · MicroK8s · Prometheus · Grafana · Infrastructure as Code (IaC)

---

##  Overview

This project demonstrates a **complete DevOps automation workflow** — from provisioning infrastructure on **Azure** to **deploying a FastAPI application on MicroK8s** with automated CI/CD and monitoring integration.

### Technologies Used
- **FastAPI** – Lightweight Python web framework for REST endpoints  
- **Terraform** – Infrastructure as Code (IaC) for Azure provisioning  
- **MicroK8s** – Lightweight Kubernetes for local or VM deployment  
- **GitHub Actions** – CI/CD automation for testing, validation, and deployment  
- **Prometheus & Grafana** – Metrics monitoring and visualization  

---

## Prerequisites

Before starting, ensure you have:

- Azure Subscription  
- Service Principal credentials (for Terraform authentication)  
- Terraform ≥ v1.5  
- Python ≥ 3.11  
- Git & GitHub Actions configured  
- MicroK8s installed on VM or local setup
  Setting Up GitHub Secrets

The CI/CD pipeline uses GitHub Secrets to store sensitive credentials required for Azure, Docker, and VM access.

Go to your repository → Settings → Secrets and variables → Actions → New repository secret,
then add the following keys and values:

| Secret Name           | Description                                        |
| --------------------- | -------------------------------------------------- |
| `ARM_CLIENT_ID`       | Azure Service Principal Client ID                  |
| `ARM_CLIENT_SECRET`   | Azure Service Principal Secret                     |
| `ARM_SUBSCRIPTION_ID` | Azure Subscription ID                              |
| `ARM_TENANT_ID`       | Azure Tenant ID                                    |
| `VM_PUBLIC_IP`        | Public IP of your Azure VM (output from Terraform) |
| `VM_PASSWORD`         | Password for your Azure VM user                    |
| `DOCKERHUB_USERNAME`  | Your Docker Hub username                           |
| `DOCKERHUB_TOKEN`     | Docker Hub access token or password                |

---

## Infrastructure Setup with Terraform

Follow these steps to provision your Azure resources:

```bash
#  Clone Repository
git clone https://github.com/abhishek-root/devops.git
cd devops

#  Initialize Terraform
terraform init

#  Validate Configuration
terraform validate

#  Preview Infrastructure Changes
terraform plan 

#  Apply Configuration
terraform apply -auto-approve



CI/CD Workflow — GitHub Actions

The pipeline defined in .github/workflows/ci.yaml automates the following:

| Stage                                 Description                                          |
| -------------------------------------------------------------------------------------------|
|  **Linting & Testing**                 Runs **Pylint** and **Pytest** on FastAPI code      |
|  **Terraform Validation & Plan**       Validates Terraform syntax and previews changes     |
|  **Docker Build & Push**               Builds Docker image and pushes to Docker Hub        |
|  **Terraform Apply & K8s Deployment**  Applies Terraform changes and deploys app manifests |
|  **Monitoring Setup**                  Installs Prometheus and Grafana via Helm            |


FastAPI Application
 Endpoints

| Endpoint  | Description           | Example Response                          |
| --------- | --------------------- | ----------------------------------------- |
| `/`       | Root endpoint         | `{"message": "Hello World from FastAPI"}` |
| `/health` | Health check endpoint | `{"status": "ok"}`                        |


**Access & Ports Once deployed, check your service using: **
microk8s kubectl get svc

Example output:

NAME              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
fastapi-service   NodePort    10.152.183.100   <none>        30080:30080/TCP  10m

To access your FastAPI app:
http://<vm-public-ip>:30080


**Example:

If your VM public IP is 52.173.18.101 **

Root endpoint → http://52.173.18.101:30080/

Health endpoint → http://52.173.18.101:30080/health

**Monitoring — Prometheus & Grafana**

helm upgrade --install prometheus prometheus-community/prometheus \
  -n monitoring \
  -f k8s/monitoring/prometheus-values.yaml

helm upgrade --install grafana grafana/grafana \
  -n monitoring \
  -f k8s/monitoring/grafana-values.yaml


Components

Prometheus – Scrapes and stores Kubernetes metrics

Grafana – Visualizes performance metrics through dashboards

Check services:

kubectl get svc -n monitoring


Example output:

grafana     NodePort   10.152.183.20   <none>   30000:30000/TCP   5m


Access Grafana dashboard:

http://<vm-public-ip>:30000


Default Login:

Username: admin
Password: admin





