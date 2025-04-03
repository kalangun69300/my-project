pipeline {
    agent { label 'slave01' }

    stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'sonarqube'
                    withSonarQubeEnv() {

                        def sonarProjectKey = 'my-project'
                        
                        sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=${sonarProjectKey}"
                    }
                }
            }
        }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t my-project:latest ."
                }
            }
        }

        stage('Deploy to Docker Runtime') {
            steps {
                script {
                    sh """
                    docker stop my-container || true
                    docker rm my-container || true
                    docker run -d --name my-container -p 3000:3000 my-project:latest
                    """
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
