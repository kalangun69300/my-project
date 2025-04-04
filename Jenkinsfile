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

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Stop and remove any existing container with the same name
                    sh "docker stop my-container || true"
                    sh "docker rm my-container || true"
                    
                    // Deploy the Docker container with the latest image
                    sh "docker run -d --name my-container -p 3000:3000 my-project:latest"
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
