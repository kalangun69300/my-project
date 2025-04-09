pipeline {
    agent { label 'slave01' }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t kalangun/my-project:latest ."
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push kalangun/my-project:latest"
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    sh "docker stop my-container || true"
                    sh "docker rm my-container || true"
                    sh "docker run -d --name my-container -p 8080:8080 kalangun/my-project:latest"
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
