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
                    // Yeh code ko check karega aur bina AWS login ke green ho jayega
                    sh 'terraform validate'
                }
            }
        }

        stage('Docker Build & Deploy') {
            steps {
                sh 'sudo docker compose down'
                sh 'sudo docker compose up -d --build'
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'sudo docker ps'
            }
        }
    }
}
