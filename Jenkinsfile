pipeline {

    agent any

    environment {
        APP_SERVER = 35.173.217.69
    }

    stages {

        stage('Verify workspace') {

            steps {

                sh "pwd"
                sh "ls-la"


            }
        stage("Build docker image") {
            steps {
                dir("node-app") {
                    sh "docker build -t node-demo ."
                }
            }
        }
        stage("copy app to app server") {
            steps {
                sh ''' scp -o StrictHostKeyChecking=no \ -r node-app \ ubuntu@$APP_SERVER:/home/ubuntu/ '''
            }
        }
        stage("deply to app server") {
            steps {
                sh ''' ssh -o StrictHostKeyChecking=no ubuntu@$APP_SERVER " docker stop node-app || true docker rm node-app || true cd /home/ubuntu/node-app docker build -t node-demo . docker run -d \ --name node-app \ -p 3000:3000 \ node-demo " '''
            }
        }
        }

    }

}