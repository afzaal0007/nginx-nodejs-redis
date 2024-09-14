pipeline {
    agent any

    environment {
        AWS_ECR_LOGIN = 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 772149515781.dkr.ecr.ap-south-1.amazonaws.com'
        ECR_REPO_URI = '772149515781.dkr.ecr.ap-south-1.amazonaws.com'
        GIT_REPO = 'https://github.com/afzaal0007/nginx-nodejs-redis.git'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install Node.js dependencies for your app
                    sh 'cd app && npm install -g npm-check-updates'
                    sh 'ncu -u'
                    sh 'cd app && npm install --save-dev mocha'
                    sh 'cd app && npm audit fix'
                    sh 'npm install --save-dev mocha'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests for your Node.js app
                    sh 'cd app && npm test'
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    sh 'docker-compose build'
                }
            }
        }

        stage('Push Images to ECR') {
            steps {
                script {
                    // Log in to AWS ECR
                    sh "${AWS_ECR_LOGIN}"

                    // Push Redis image
                    sh """
                        docker tag redis:alpine ${ECR_REPO_URI}/redis:alpine
                        docker push ${ECR_REPO_URI}/redis:alpine
                    """

                    // Push Web1 image
                    sh """
                        docker tag web1 ${ECR_REPO_URI}/web1:${BUILD_NUMBER}
                        docker push ${ECR_REPO_URI}/web1:${BUILD_NUMBER}
                    """

                    // Push Web2 image
                    sh """
                        docker tag web2 ${ECR_REPO_URI}/web2:${BUILD_NUMBER}
                        docker push ${ECR_REPO_URI}/web2:${BUILD_NUMBER}
                    """

                    // Push Nginx image
                    sh """
                        docker tag nginx ${ECR_REPO_URI}/nginx:${BUILD_NUMBER}
                        docker push ${ECR_REPO_URI}/nginx:${BUILD_NUMBER}
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Update the deployment YAML files dynamically with the ECR image tag
                    sh '''
                     sed -i 's|<aws_account_id>.dkr.ecr.<region>.amazonaws.com/web1:<tag>|772149515781.dkr.ecr.ap-south-1.amazonaws.com/web1:${BUILD_NUMBER}|g' web1.yaml
                     sed -i 's|<aws_account_id>.dkr.ecr.<region>.amazonaws.com/web2:<tag>|772149515781.dkr.ecr.ap-south-1.amazonaws.com/web2:${BUILD_NUMBER}|g' web2.yaml
                     sed -i 's|<aws_account_id>.dkr.ecr.<region>.amazonaws.com/nginx:<tag>|772149515781.dkr.ecr.ap-south-1.amazonaws.com/nginx:${BUILD_NUMBER}|g' nginx.yaml


                    kubectl apply -f web1.yaml
                    kubectl apply -f web2.yaml
                    kubectl apply -f nginx.yaml
                    kubectl apply -f redis.yaml
                    '''
                }
            }
        }
    }

    post {
        always {
            // Optional: Clean up workspace after build
            cleanWs()
        }
    }
}
