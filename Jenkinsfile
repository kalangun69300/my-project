pipeline {
    agent { label 'slave01' }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t my-project:latest ."
                }
            }
        }

        stage('Success') {
            steps {
                echo 'Deploy Successfully'
            }
        }
    }
}
