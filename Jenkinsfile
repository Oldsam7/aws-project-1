pipeline {
    agent any                                                                             //Runs on any available agent
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Oldsam7/aws-project-1.git'                //checkout the source code from the version control system (e.g., Git)
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'                                                      //Initialize Terraform in the directory containing code
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'                                                     //generate and display an execution plan for Terraform
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply "tfplan" -auto-approve'                                      //apply the terraform configuration to create/update infrastructure
            }
        }
    }
