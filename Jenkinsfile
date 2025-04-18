pipeline {
    agent { label 'slave01' }

    parameters {
        choice(name: 'run_time', choices: ['Run the container for 3 minutes', 'Keep the container running'], description: 'Select the duration for which the container should run')
    }

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
                    // ใช้ credentials เพื่อ login ไป Harbor
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
                    if (params.run_time == 'Run the container for 3 minutes') {
                        sh """docker run --rm -d --entrypoint '' --name ${JOB_NAME} -p 8080:8080 ${DOCKER_IMAGE} sh -c "npx serve -s dist -p 8080 & sleep 30" """
                        sh "docker stop ${JOB_NAME}"
                    } else {
                        sh "docker run --rm -d --name ${JOB_NAME} -p 8080:8080 ${DOCKER_IMAGE}"
                    }
                    echo "Running healthcheck..."
                    sh "docker inspect --format='{{.State.Health.Status}}' ${JOB_NAME}"
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
