pipeline {
    agent { label 'slave01' }

    environment {
        DOCKER_IMAGE = "hubdc.dso.local/test-image/node:latest" 
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Login to Harbor') {
            steps {
                script {
                    // ใช้ credentials 
                    withCredentials([usernamePassword(credentialsId: 'harborhub', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                        // Login Harbor 
                        //sh "echo $DOCKER_PASS | docker login hubdc.dso.local -u $DOCKER_USER --password-stdin"
                        sh "docker login hubdc.dso.local -u $DOCKER_USER -p $DOCKER_PASS"

                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    sh "docker stop my-container || true"
                    sh "docker rm my-container || true"
                    // รัน container ใหม่จาก image ที่เพิ่ง push
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
