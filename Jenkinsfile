pipeline {
    agent any
    stages {
        stage("build jar") {
            steps {
                echo "building the application..."
                withMaven(maven: 'mvn') {
                    sh "mvn package"
                }
            }
        }
        stage("build image") {
            steps {
                echo "building the docker image..."
                withCredentials([usernamePassword(credentialsId: 'docker-hub0repo-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh 'docker build -t tomiwa97/docker_app:jma-1.1 .'
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh 'docker push tomiwa97/docker_app:jma-1.1'
                }
            }
        }
        stage("deploy") {
            steps {
                echo 'deploying the application...'
            }
        }
    }   
}
