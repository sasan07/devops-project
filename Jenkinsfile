pipeline {
    agent any

    environment {
        APP_SERVER = "35.173.217.69"
    }

    stages {

        stage('Verify') {
            steps {
                echo "Deploying to ${APP_SERVER}"
            }
        }

        stage('Copy App') {
            steps {
                sh """
                scp -o StrictHostKeyChecking=no -r node-app ubuntu@${APP_SERVER}:/home/ubuntu/
                """
            }
        }

    }
}