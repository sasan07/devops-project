pipeline {

    agent any

    environment {

        APP_SERVER="98.87.165.239"

    }

    stages {

        stage('Build Docker Image') {

            steps {

                dir('node-app') {

                    sh 'docker build -t node-demo .'

                }

            }

        }

        stage('Copy Application To App Server') {

            steps {

                sh '''

                scp -r node-app ubuntu@$APP_SERVER:/home/ubuntu/

                '''

            }

        }

        stage('Deploy Container') {

            steps {

                sh '''

                ssh ubuntu@$APP_SERVER "

                docker stop node-app || true

                docker rm node-app || true

                cd /home/ubuntu/node-app

                docker build -t node-demo .

                docker run -d \
                -p 3000:3000 \
                --name node-app \
                node-demo

                "

                '''

            }

        }

    }

}