pipeline {
    agent { label 'slave01' }

    environment {
        IMAGE_NAME = "hubdc.dso.local/test-image/${JOB_NAME}"
        IMAGE_TAG = "${BUILD_NUMBER}"
        DOCKER_IMAGE = "${IMAGE_NAME}:${IMAGE_TAG}"
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
                    // ใช้ credentials เพื่อ login ไปยัง Harbor
                    withCredentials([usernamePassword(credentialsId: 'harborhub', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                        // Login Harbor
                        sh "echo $DOCKER_PASS | docker login hubdc.dso.local -u $DOCKER_USER --password-stdin"
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
                    sh "docker run --rm --entrypoint sleep -d --name test-pipeline-gun -p 8080:8080 ${DOCKER_IMAGE} 180"
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
