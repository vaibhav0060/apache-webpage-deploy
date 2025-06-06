pipeline {
    agent any

    environment {
        TARGET_HOST = '13.208.183.41'
        SSH_USER = 'ec2-user'
        SSH_CREDENTIALS_ID = 'Instance-access'
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/vaibhav0060/apache-webpage-deploy.git'
            }
        }

        stage('Deploy to EC2 Instance') {
            steps {
                sshagent (credentials: [env.SSH_CREDENTIALS_ID]) {
                    sh """
                        echo "Copying files to EC2..."
                        ssh -o StrictHostKeyChecking=no ${SSH_USER}@${TARGET_HOST} 'mkdir -p /home/${SSH_USER}/app'
                        scp -o StrictHostKeyChecking=no -r * ${SSH_USER}@${TARGET_HOST}:/home/${SSH_USER}/app

                        echo "Running deployment script on EC2..."
                        ssh -o StrictHostKeyChecking=no ${SSH_USER}@${TARGET_HOST} 'chmod +x /home/${SSH_USER}/app/app.sh && bash /home/${SSH_USER}/app/app.sh'
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment completed successfully.'
        }
        failure {
            echo '❌ Deployment failed.'
        }
    }
}

