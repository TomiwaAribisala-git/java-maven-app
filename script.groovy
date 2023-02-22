def buildJar() {
    echo "building the application..."
    sh 'mvn package'
} 

def buildImage() {
    echo "building the docker image..."
    withCredentials([usernamePassword(credentialsId: 'docker-hub0repo-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        sh 'docker build -t tomiwa97/docker_app:jma-1.1 .'
        sh "echo $PASS | docker login -u $USER --password-stdin"
        sh 'docker push tomiwa97/docker_app:jma-1.1'
    }
} 

def deployApp() {
    echo 'deploying the application...'
} 
