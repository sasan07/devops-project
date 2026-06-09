pipeline {

```
agent any

environment {

    APP_SERVER="35.173.217.69"

}

stages {

    stage('Build Image') {

        steps {

            dir('node-app') {

                sh 'docker build -t node-demo .'

            }

        }

    }

    stage('Copy App') {

        steps {

            sh '''

            scp -o StrictHostKeyChecking=no \
            -r node-app \
            ubuntu@$APP_SERVER:/home/ubuntu/

            '''

        }

    }

    stage('Deploy') {

        steps {

            sh '''

            ssh -o StrictHostKeyChecking=no \
            ubuntu@$APP_SERVER "

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
```

}
