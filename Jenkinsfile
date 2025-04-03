pipeline {
    agent {
  label 'slave01'
}

    environment {
        IMAGE_NAME = "my-project"
        IMAGE_TAG = "latest"
    }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }


        stage('Success') {
            steps {
                echo 'Deploy Successfully'
            }
        }
    }
}





