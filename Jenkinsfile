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
                script {
                    def terraformCommand = params.ACTION == 'apply' ? 'apply --auto-approve' : 'destroy --auto-approve'
                    def selectedEnvironment = input message: "Select the environment to deploy to", ok: "Done", parameters: [choice(name: 'ENV', choices: ['dev','staging', 'prod'], description: 'Select one to perform')]
                    echo "Executing Terraform ${params.ACTION}..."
                    echo "Deploying to ${selectedEnvironment}"
                    bat "terraform ${terraformCommand}"
                }
            }
        }
    }
}
