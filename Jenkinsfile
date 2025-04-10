pipeline {
    agent { label 'slave01' }

    environment {
        DOCKER_IMAGE = "kalangun/my-project:latest"
        DOCKER_USER = "kalangun"
        DOCKER_PASS = "netsiri69300"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ." // สร้าง Docker image
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Login Docker Hub 
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push Docker image ขึ้น Docker Hub
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // หยุด,ลบ container เก่า
                    sh "docker stop my-container || true"
                    sh "docker rm my-container || true"
                    // รัน container ใหม่
                    sh "docker run -d --name my-container -p 8080:8080 ${DOCKER_IMAGE}"
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
