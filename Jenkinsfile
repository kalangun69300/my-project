pipeline {
    agent { label 'slave01' } //run on slave01

    stages {
        stage('Build Docker Image') {
            steps {
                script {
<<<<<<< HEAD
                    sh "docker build -t my-project:latest ."
=======
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
>>>>>>> parent of c13f104 (test pipeline v2)
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
