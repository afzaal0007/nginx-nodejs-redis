pipeline {
    agent any

    environment {
        // Fetch secrets from AWS Secrets Manager
        AWS_REGION = sh(script: 'aws secretsmanager get-secret-value --secret-id your-secret-id --region your-region --query SecretString --output text | jq -r ".AWS_REGION"', returnStdout: true).trim()
        SECRET_NAME = sh(script: 'aws secretsmanager get-secret-value --secret-id your-secret-id --region your-region --query SecretString --output text | jq -r ".SECRET_NAME"', returnStdout: true).trim()
        ECR_REPO_URI = sh(script: 'aws secretsmanager get-secret-value --secret-id your-secret-id --region your-region --query SecretString --output text | jq -r ".ECR_REPO_URI"', returnStdout: true).trim()
        GIT_REPO = sh(script: 'aws secretsmanager get-secret-value --secret-id your-secret-id --region your-region --query SecretString --output text | jq -r ".GIT_REPO"', returnStdout: true).trim()
        GRAFANA_ADMIN_PASSWORD = sh(script: 'aws secretsmanager get-secret-value --secret-id your-secret-id --region your-region --query SecretString --output text | jq -r ".grafana_admin_password"', returnStdout: true).trim()

        AWS_ECR_LOGIN = "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_URI}"
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
                    sh 'cd app && npm install -g npm-check-updates'
                    sh 'ncu -u'
                    sh 'cd app && npm install --save-dev mocha'
                    sh 'cd app && npm audit fix'
                }
            }
        }

        stage('Test') {
            steps {
                script {
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

        stage('Install Monitoring Tools') {
            steps {
                script {
                    sh '''
                      helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
                      helm repo update
                      helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
                      --namespace monitoring \
                      --create-namespace \
                      --set grafana.adminPassword=${GRAFANA_ADMIN_PASSWORD} \
                      --values values.yaml \
                      --version <chart_version>
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    def awsAccountId = sh(script: 'aws secretsmanager get-secret-value --secret-id jenkins-env-secrets --region ap-south-1 --query SecretString --output text | jq -r ".AWS_ACCOUNT_ID"', returnStdout: true).trim()
                    def region = sh(script: 'aws secretsmanager get-secret-value --secret-id jenkins-env-secrets --region ap-south-1 --query SecretString --output text | jq -r ".AWS_REGION"', returnStdout: true).trim()
                    def repoUri = sh(script: 'aws secretsmanager get-secret-value --secret-id jenkins-env-secrets --region ap-south-1 --query SecretString --output text | jq -r ".ECR_REPO_URI"', returnStdout: true).trim()

                    sh """
                     sed -i 's|<aws_account_id>.dkr.ecr.<region>.amazonaws.com/web1:<tag>|${repoUri}/web1:${BUILD_NUMBER}|g' web1.yaml
                     sed -i 's|<aws_account_id>.dkr.ecr.<region>.amazonaws.com/web2:<tag>|${repoUri}/web2:${BUILD_NUMBER}|g' web2.yaml
                     sed -i 's|<aws_account_id>.dkr.ecr.<region>.amazonaws.com/nginx:<tag>|${repoUri}/nginx:${BUILD_NUMBER}|g' nginx.yaml
                     
                     kubectl apply -f redis.yaml
                     kubectl apply -f web1.yaml
                     kubectl apply -f web2.yaml
                     kubectl apply -f nginx.yaml
                    """
                }
            }
        }

        stage('Check Node.js Metrics') {
            steps {
                script {
                    sh 'curl http://web1:3000/metrics'
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
