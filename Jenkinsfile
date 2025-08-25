pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
  }

  options {
    timestamps()
    disableConcurrentBuilds()
    skipDefaultCheckout()
  }

  stages {
    stage('Checkout Code') {
      steps {
        echo 'Cloning repository from GitHub...'
        git branch: 'main', url: 'https://github.com/sumukhabv/terraform-project-task.git'
      }
    }

    stage('Terraform Init') {
      steps {
        dir('environment/dev') {
          withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'aws-creds'
          ]]) {
            sh 'terraform init'
          }
        }
      }
    }

    stage('Terraform Format Check') {
      steps {
        echo ' Checking Terraform formatting...'
        dir('environment/dev') {
          sh 'terraform fmt -check -recursive'
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        echo ' Validating Terraform configuration...'
        dir('environment/dev') {
          sh 'terraform validate'
        }
      }
    }

    stage('Terraform Plan (Destroy Mode)') {
      steps {
        echo ' Planning Terraform destroy...'
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          dir('environment/dev') {
            sh 'terraform plan -destroy -var-file="terraform.tfvars.json" -out=destroy.tfplan'
          }
        }
      }
    }

    stage('Manual Approval to Destroy') {
      steps {
        input message: '⚠️ Are you sure you want to destroy all resources in DEV environment?'
      }
    }

    stage('Terraform Destroy') {
      steps {
        echo ' Destroying Terraform-managed infrastructure...'
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          dir('environment/dev') {
            sh 'terraform apply -auto-approve destroy.tfplan'
          }
        }
      }
    }
  }

  post {
    success {
      echo '✅ Infrastructure destroyed successfully.'
    }
    failure {
      echo '❌ Terraform destroy failed.'
    }
  }
}
