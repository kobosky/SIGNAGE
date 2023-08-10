pipeline {
    agent any
    environment {
        AWS_REGION = 'eu-west-2'
        AWS_ACCOUNT_ID = '488777800893'
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
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'Signage AWS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        sh 'terraform init -reconfigure'
                    }
                }
            }
        }
        stage('Terraform Action') {
            steps {
                dir('project') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'Signage AWS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        echo "Terraform action is --> ${action}"
                        sh "terraform ${action} --auto-approve"
                    }
                }
            }
        }
    }
}
