pipeline {
    agent any

    environment {
        DOCKER_HUB = credentials('dockerhub-credentials')  // Jenkins-stored Docker Hub credentials
        DOCKER_REGISTRY = "pews"   // Replace with your Docker Hub username
    }

    stages {
        stage('Checkout Git') {
            steps {
                checkout scm  // Automatically checks out the merged code
            }
        }

        // Build and push API image
        stage('Build & Push API') {
            steps {
                dir('api') {  // Navigate to the API directory
                    script {
                        // Build API image using api/Dockerfile
                        docker.build("${DOCKER_REGISTRY}/api:latest", "-f Dockerfile .")
                        // Push to Docker Hub
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                            docker.image("${DOCKER_REGISTRY}/api:latest").push()
                        }
                    }
                }
            }
        }

        // Build and push Frontend image
        stage('Build & Push Frontend') {
            steps {
                dir('front-end-nextjs') {  // Navigate to the Frontend directory
                    script {
                        // Build Frontend image using front-end-nextjs/Dockerfile
                        docker.build("${DOCKER_REGISTRY}/frontend:latest", "-f Dockerfile .")
                        // Push to Docker Hub
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                            docker.image("${DOCKER_REGISTRY}/frontend:latest").push()
                        }
                    }
                }
            }
        }

        // Optional: Clean up unused Docker objects
        stage('Clean Up') {
            steps {
                sh 'docker system prune -f --filter "until=24h"'  // Only remove old unused images
            }
        }
    }
}