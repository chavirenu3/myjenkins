pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'  // specify your AWS region
        //TF_STATE_BUCKET = 'your-terraform-state-bucket'  // if using a remote state bucket
        //TF_BACKEND_CONFIG = 'your-backend-config'  // optional if using remote backends
    }

    stages {
        stage('Terraform: Initialize and Apply') {
            steps {
                script {
                    // Clone your Git repository containing Terraform scripts
                    git 'https://github.com/your-repo/terraform-code.git'
                    
                    // Initialize Terraform
                    sh 'terraform init'

                    // Apply the configuration to create the EC2 instance
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        
        stage('Get EC2 IP') {
            steps {
                script {
                    // Extract the instance IP
                    def ip = sh(script: "terraform output -raw instance_public_ip", returnStdout: true).trim()
                    env.INSTANCE_IP = ip
                }
            }
        }

        stage('Ansible: Install Nginx') {
            steps {
                script {
                    // Install nginx on the newly created EC2 instance using Ansible
                    sh """
                        ansible-playbook -i ${env.INSTANCE_IP}, -u ubuntu --private-key /path/to/your/key.pem install_nginx.yml
                    """
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

