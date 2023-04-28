pipeline {
    agent any
    stages {
        stage("increment version") {
            steps{
                script {
                    echo "incrementing app version..."
                    withMaven(maven: 'maven-3.9') {
                        sh 'mvn build-helper:parse-version versions:set \
                        -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                        versions:commit'
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1] 
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"  
                    }            
                }
            }
        }
        stage("commit version update") {
            steps {
                script {
                    echo "committing version update to git repository(to effect pom.xml file)..."
                     withCredentials([usernamePassword(credentialsId: 'github-pan-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                         sh 'git config --global user.email "tomiwaaribisala@gmail.com"'
                         sh 'git config --global user.name "TomiwaAribisala-git"'
                         sh 'git status'
                         sh 'git branch'
                         sh 'git config --list'
                         sh "git remote set-url origin https://${USER}:${PASS}@github.com/TomiwaAribisala-git/java-maven-app.git"
                         sh 'git add .'
                         sh 'git commit -m "ci: version latest"'
                         sh 'git push origin HEAD:master'
                     }
                }
            }
        }
        stage("build jar file") {
            steps {
                script {
                    echo "building the application..."
                    withMaven(maven: 'maven-3.9') {
                        sh "mvn clean package"
                    }
                }
            }
        }
        stage("build image") {
            steps {
                script {
                    echo "building the docker image..."
                    withCredentials([usernamePassword(credentialsId: 'docker-hub0repo-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t tomiwa97/docker_app:${IMAGE_NAME} ."
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh 'docker push tomiwa97/docker_app:${IMAGE_NAME}'
                    }
                }
            }
        }
        stage("deploy to k8s cluster") {
            steps {
                script {
                    echo 'deploying docker image to EC2...'
                }
            }
        }
    }   
}
