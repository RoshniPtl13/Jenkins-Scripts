pipeline {
    agent any
    stages {
        stage("git clone"){
            steps{
                git branch: 'main', url: 'https://github.com/ChetanRajpal/jenks-test-docker.git'
            }
        }
        
        stage("Build Docker Image"){
            steps {
                script {
                    sh 'sudo docker build -t krazykrait/portfolio-1.0 .'
                }
            }
        }
        
        stage("Push Docker Image"){
            steps {
                script {
                        withCredentials([string(credentialsId: 'krazykrait', variable: 'dockerhubpwd')]) {
                        sh 'sudo docker login -u krazykrait -p ${dockerhubpwd}'
                        }
                        
                        sh 'sudo docker push krazykrait/portfolio-1.0'
                }
            }
        }
    }
}
