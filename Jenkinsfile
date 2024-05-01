pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select action to perform')
        booleanParam(name: 'executeTest', defaultValue: true, description: 'Apply or Destroy?')
    }
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
        stage('Terraform Apply/Destroy') {
            when {
                expression {
                    params.executeTest
                }
            }
            steps {
                dir('project') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'my-aws-credentials-2', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        script {
                            def terraformCommand = params.ACTION == 'apply' ? 'apply --auto-approve' : 'destroy --auto-approve'
                            bat "terraform ${terraformCommand}"
                        }
                    }
                }
            }
        }
    }
}
