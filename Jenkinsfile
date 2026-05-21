pipeline {
    agent any

    environment {
        GITHUB_URL = 'https://github.com/RISHIKUMAR206/three-tier-web-applications.git'
        AWS_IP     = '52.66.123.183'  // <-- Tumhara permanent Elastic IP yahan lock kar diya hai
    }

    stages {
        stage('Checkout Code') {
            steps {
                cleanWs() // Har baar workspace clear karega taaki @2 wala panga na ho
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

        stage('Docker Deploy to AWS') {
            steps {
                // Bina fingerprints ke secure login karke containers up-down karega
                sh "ssh -o StrictHostKeyChecking=no ubuntu@${AWS_IP} 'cd three-tier-web-applications && sudo docker-compose down || true'"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@${AWS_IP} 'cd three-tier-web-applications && sudo docker-compose up -d'"
            }
        }

        stage('Verify AWS Deployment') {
            steps {
                sh "ssh -o StrictHostKeyChecking=no ubuntu@${AWS_IP} 'sudo docker ps'"
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed successfully!'
        }
    }
}
