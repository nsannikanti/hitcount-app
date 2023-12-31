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
               sh "sudo chown ubuntu:ubuntu /var/run/docker.sock"
               sh "docker build -t web ."
               sh "docker tag web nsannika/web:4.0"
               sh "docker tag web:latest 109387072744.dkr.ecr.ap-south-1.amazonaws.com/web:4.0"
            }     
        }
         stage('docker-push') {
            steps { 
                withCredentials([string(credentialsId: 'dockerpassword', variable: 'dockerpass')]) {
                        sh 'docker login -u "nsannika" -p "${dockerpass}"'
                        sh "docker push nsannika/web:4.0"
                }
            }     
        }
        stage('ecr-push') {
            steps { 
                withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: "awscredentials",
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {					  
		      sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 109387072744.dkr.ecr.ap-south-1.amazonaws.com"
                      sh "docker push 109387072744.dkr.ecr.ap-south-1.amazonaws.com/web:4.0"
                }
            }     
        }  
        stage('deployment') {
            steps { 
              sshagent (credentials: ['ubuntu']) {
                    sh 'scp -o StrictHostKeyChecking=no deploy.sh ubuntu@172.31.39.86:/tmp/'
                    sh 'ssh -o StrictHostKeyChecking=no -l ubuntu 172.31.39.86 docker-compose -f docker-compose.yml up -d'
                }
            }     
        }
    }
}
