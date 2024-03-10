pipeline{
  agent none
  environment{
    DOCKERHUB_CREDENTIALS= credentials('dockerhub-jenkins-agent3')
    DOCKER_USER='lokeshjwork'
    DOCKER_REPO='devops-integration'
    IMAGE_TAG='springboot'
  }
  stages{
    stage('Git checkout'){
      agent {label 'agent3'}
      steps{
        git branch: 'master', url: 'https://github.com/Lokeshwork/spring-boot-dockerize.git'
      }
    }
    stage('Docker build'){
      agent {label 'agent3'}
      steps{
        script{
          sh 'docker build -t ${DOCKER_USER}/${DOCKER_REPO}:${IMAGE_TAG} .'
        }
      }
    }
    stage('Docker login'){
      agent {label 'agent3'}
      steps{
         sh 'docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW> --password-stdin'
        }
      }
    stage('docker push'){
      agent {label 'agent3'}
      steps{
        sh 'docker push ${DOCKER_USER}/${DOCKER_REPO}:${IMAGE_TAG}'
      }
    }
    stage('deploy to Kubernetes'){
      agent {label 'kubernetes'}
      steps{
        sh 'kubectl apply -f deploymentservice.yaml'
      }
    }
  }
}
