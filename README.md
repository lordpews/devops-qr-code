# DevOps QR Code Project

## Overview
This repository contains a full-stack application for generating QR codes. It includes a backend API, a frontend built with Next.js, and infrastructure as code (IaC) using Terraform and Kubernetes. The project is designed to demonstrate DevOps practices, including containerization, CI/CD, and cloud infrastructure management.

## Repository Structure

Below is a pictorial representation of the repository structure:

```
📦 devops-qr-code
├── 📄 Dockerfile2
├── 📄 Jenkinsfile
├── 📄 LICENSE
├── 📄 README.md
├── 📂 api
│   ├── 📄 Dockerfile
│   ├── 📄 main.py
│   ├── 📄 requirements.txt
│   ├── 📄 test_main.py
│   └── 📂 __pycache__
│       ├── 📄 app.cpython-312.pyc
│       └── 📄 main.cpython-312.pyc
├── 📂 front-end-nextjs
│   ├── 📄 Dockerfile
│   ├── 📄 jsconfig.json
│   ├── 📄 next.config.js
│   ├── 📄 package.json
│   ├── 📄 postcss.config.js
│   ├── 📄 README.md
│   ├── 📄 tailwind.config.js
│   ├── 📂 public
│   │   ├── 📄 next.svg
│   │   └── 📄 vercel.svg
│   └── 📂 src
│       ├── 📂 app
│       │   ├── 📄 favicon.ico
│       │   ├── 📄 globals.css
│       │   ├── 📄 layout.js
│       │   ├── 📄 page.js
│       │   └── 📂 api
│       │       └── 📂 generate-qr
│       │           └── 📄 route.js
├── 📂 infra
│   ├── 📄 main.tf
│   ├── 📄 provider.tf
│   ├── 📄 terraform.tfstate
│   └── 📄 terraform.tfstate.backup
└── 📂 k8s
    ├── 📄 backend-service.yaml
    ├── 📄 backend.yaml
    ├── 📄 frontend-service.yaml
    └── 📄 frontend.yaml
```

### Backend (API)
- **Path**: `api/`
- **Description**: Contains the Python-based backend API for generating QR codes.
- **Key Files**:
  - `main.py`: Entry point for the API.
  - `requirements.txt`: Python dependencies.
  - `Dockerfile`: Dockerfile for containerizing the API.
  - `test_main.py`: Unit tests for the API.

### Frontend (Next.js)
- **Path**: `front-end-nextjs/`
- **Description**: Contains the frontend application built with Next.js for interacting with the QR code generator.
- **Key Files**:
  - `src/`: Source code for the frontend.
  - `Dockerfile`: Dockerfile for containerizing the frontend.
  - `package.json`: Node.js dependencies.

### Infrastructure (Terraform)
- **Path**: `infra/`
- **Description**: Contains Terraform configuration files for provisioning cloud infrastructure.
- **Key Files**:
  - `main.tf`: Main Terraform configuration.
  - `provider.tf`: Provider configuration for Terraform.

### Kubernetes Manifests
- **Path**: `k8s/`
- **Description**: Contains Kubernetes YAML files for deploying the application.
- **Key Files**:
  - `backend.yaml`: Deployment configuration for the backend API.
  - `frontend.yaml`: Deployment configuration for the frontend.
  - `backend-service.yaml`: Service configuration for the backend API.
  - `frontend-service.yaml`: Service configuration for the frontend.

## Prerequisites
- Docker
- Kubernetes (Minikube, EKS, or any Kubernetes cluster)
- Terraform
- Node.js and npm
- Python 3.9+

## Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/your-repo/devops-qr-code.git
cd devops-qr-code
```

### 2. Build and Run with Docker
#### Backend
```bash
cd api
docker build -t qr-api .
docker run -p 5000:5000 qr-api
```

#### Frontend
```bash
cd front-end-nextjs
docker build -t qr-frontend .
docker run -p 3000:3000 qr-frontend
```

### 3. Deploy with Kubernetes
```bash
kubectl apply -f k8s/
```

### 4. Provision Infrastructure with Terraform
```bash
cd infra
terraform init
terraform apply
```

## CI/CD Pipeline *to do*
- The `Jenkinsfile` defines the CI/CD pipeline for building, testing, and deploying the application.
- Ensure Jenkins is configured with Docker and Kubernetes plugins.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.


