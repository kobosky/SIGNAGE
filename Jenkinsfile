pipeline {
    agent any
    environment {
        AWS_REGION = 'eu-west-2'
        AWS_ACCOUNT_ID = '767398087803'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kobosky/SIGNAGE.git']]])
            }
        }
        stage('Terraform Init') {
            steps {
                dir('project') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'my-aws-credentials-2', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        bat 'terraform init'
                    }
                }
            }
        }
        stage('Terraform Action') {
            steps {
                dir('project') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'my-aws-credentials-2', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        bat "terraform destroy --auto-approve"
                    }
                }
            }
        }
    }
}
