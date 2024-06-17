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
