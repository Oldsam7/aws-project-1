pipeline {
    agent any                                                                             //Runs on any available agent

    tools{
        terraform 'terraform_home'                        //'terraform_home' is the tool name defined in Jenkins Global Tool Configuration
    }
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/yellayakshi-bijji/aws_project_1.git'                //checkout the source code from the version control system (e.g., Git)
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
        stage('Manual Approval') {
            steps{
                script{
                    def userInput = input(
                        id: 'approval',
                        message: 'Proceed with resource destruction (yes/no)? ',
                        parameters: [booleanParam(defaultValue: true, description: 'Approve?')]
                    )

                    if (userInput){
                        def pauseInput = input(
                            id: 'pause',
                            message: 'Pause destruction for (minutes): ',
                            parameters: [string(name: 'pauseDuration', defaultValue: '0', description: 'Minutes')]
                        )

                        def minutesToPause = pauseInput.toInteger()

                        if (minutesToPause > 0){
                            echo "Pausing destruction for ${minutesToPause} minutes..."
                            sleep time: minutesToPause, unit: 'MINUTES'
                        } else {
                            echo "Not pausing destruction!"
                        }
                    } else{
                        error('Resource destruction not approved. Aborting pipeline!!')
                    }
                }
            }
        }
        stage('Terraform Destroy'){
            steps{
                sh 'terraform destroy -auto-approve'
            }
        }
        //more stages
    }
    post{
        success{
            emailext subject: 'Build Success',
                        body: 'The Jenkins pipeline has completed successfully',
                          to: 'yellayakshi.bijji.135@gmail.com'
        }
}