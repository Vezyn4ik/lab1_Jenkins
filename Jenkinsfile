pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        S3_BUCKET = 'jenkinsfile.bucket.khnure'
    }

    stages {
        stage('Checkout') {
            steps {    
                git branch: 'main', url: 'https://github.com/Vezyn4ik/lab1_Jenkins.git'
            }
        }

        stage('Install AWS CLI') {
            steps {
                sh 'curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"'
                sh 'unzip awscliv2.zip'
                sh 'sudo ./aws/install'
            }
        }

        stage('Deploy to S3') {
            steps {
                script {
                    sh ''' 
                    aws s3 sync . s3://$S3_BUCKET --delete
                    '''
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
