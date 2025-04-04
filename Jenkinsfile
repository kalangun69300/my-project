pipeline {
    agent { label 'slave01' } //run on slave01

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t my-project:latest ."
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Stop and remove 
                    sh "docker stop my-container || true"
                    sh "docker rm my-container || true"
                    
                    // Deploy new container
                    sh "docker run -d --name my-container -p 8080:8080 my-project:latest" 
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
