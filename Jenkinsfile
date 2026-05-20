pipeline {
    agent any
    
    environment {
        GITHUB_URL = 'https://github.com/RISHIKUMAR206/three-tier-web-applications.git'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git credentialsId: 'github-creds', url: "${GITHUB_URL}", branch: 'main'
            }
        }

        stage('Terraform Init & Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform validate'
                }
            }
        }

        stage('Docker Build & Deploy') {
            steps {
                // Agar pehle se koi conflict wala container hai toh use forced remove karega
                sh 'sudo docker rm -f employee-mysql employee-frontend employee-backend employee-nginx || true'
                sh 'sudo docker-compose down || true'
                sh 'sudo docker-compose up -d --build'
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'sudo docker ps'
            }
        }
    }
}
