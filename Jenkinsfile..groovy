
// Jenkins File with ECR Updates

pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        ECR_REGISTRY = '772149515781.dkr.ecr.ap-south-1.amazonaws.com'
        ECR_REPOSITORY_NODE = 'node-js-app'
        ECR_REPOSITORY_MYSQL = 'node-js-app-db'
        DOCKER_IMAGE_NODE = "${ECR_REGISTRY}/${ECR_REPOSITORY_NODE}:latest"
        DOCKER_IMAGE_MYSQL = "${ECR_REGISTRY}/${ECR_REPOSITORY_MYSQL}:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/your-repo/your-node-app.git'
            }
        }
        stage('Build Docker Images') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE_NODE} -f docker/node/Dockerfile .'
                    sh 'docker build -t ${DOCKER_IMAGE_MYSQL} -f docker/db/Dockerfile .'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Running basic tests
                    sh 'npm install'
                    sh 'npm test'
                }
            }
        }


        stage('Login to AWS ECR') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}'
                }
            }
        }
        stage('Push Docker Images to ECR') {
            steps {
                script {
                    sh 'docker push ${DOCKER_IMAGE_NODE}'
                    sh 'docker push ${DOCKER_IMAGE_MYSQL}'
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
                script {
                    // Apply Kubernetes configurations
                    sh 'kubectl apply -f /mnt/data/k8s-mysql.yaml'
                    sh 'kubectl apply -f /mnt/data/k8s-node.yaml'
                    sh 'kubectl apply -f /mnt/data/app-secret.yaml'
                    sh 'kubectl apply -f /mnt/data/app-config.yaml'
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
