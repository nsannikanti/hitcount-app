pipeline {
    agent { label 'docker-label'}

    stages {
        stage('clone') {
            steps {
              checkout scm
            }     
        }
        stage('docker-build') {
            steps {              
               sh "docker build -t web ."
               sh "docker tag web nsannika/mineimages/web:4.0"
            }     
        }      
        stage('deployment') {
            steps { 
              sshagent (credentials: ['ubuntu']) {
                    sh 'ssh -o StrictHostKeyChecking=no -l ubuntu 172.31.0.118 docker-compose up -d'
                }
            }     
        }
    }
}
