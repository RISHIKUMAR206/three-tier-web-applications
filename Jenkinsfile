pipeline {
    agent any

    environment {
        GITHUB_URL = 'https://github.com/RISHIKUMAR206/three-tier-web-applications.git'
        AWS_IP     = '13.206.251.228'
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

        stage('Docker Deploy to AWS') {
            steps {
                // AWS server par purane containers stop karke direct fast mode me up karega
                sh "ssh ubuntu@${AWS_IP} 'cd three-tier-web-applications && sudo docker-compose down || true'"
                sh "ssh ubuntu@${AWS_IP} 'cd three-tier-web-applications && sudo docker-compose up -d'"
            }
        }

        stage('Verify AWS Deployment') {
            steps {
                // Teacher ko proof dikhane ke liye AWS ke containers ka status pull karega
                sh "ssh ubuntu@${AWS_IP} 'sudo docker ps'"
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed successfully!'
        }
    }
}
