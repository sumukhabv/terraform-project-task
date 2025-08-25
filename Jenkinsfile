pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
  }

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  stages {

    stage('Terraform Init') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Format Check') {
      steps {
        echo 'Checking Terraform formatting...'
        sh 'terraform fmt -check -recursive'
      }
    }

    stage('Terraform Validate') {
      steps {
        echo 'Validating Terraform configuration...'
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        echo 'Planning Terraform apply...'
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          sh 'terraform plan -var-file="terraform.tfvars" -out=apply.tfplan'
        }
      }
    }

    stage('Manual Approval to Apply') {
      steps {
        input message: '✅ Are you sure you want to apply the infrastructure changes to DEV environment?'
      }
    }

    stage('Terraform Apply') {
      steps {
        echo 'Applying Terraform-managed infrastructure...'
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          sh 'terraform apply -auto-approve apply.tfplan'
        }
      }
    }

    stage('Terraform Plan (Destroy Mode)') {
      steps {
        echo 'Planning Terraform destroy...'
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          sh 'terraform plan -destroy -var-file="terraform.tfvars" -out=destroy.tfplan'
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
        echo 'Destroying Terraform-managed infrastructure...'
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          sh 'terraform apply -auto-approve destroy.tfplan'
        }
      }
    }
  }

  post {
    success {
      echo '✅ Pipeline completed successfully.'
    }
    failure {
      echo '❌ Pipeline failed.'
    }
  }
}
