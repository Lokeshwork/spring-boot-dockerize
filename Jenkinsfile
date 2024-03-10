pipeline{
  agent none
  environment{
    DOCKERHUB_CREDENTIALS= credentials('docker-creds')
    DOCKER_USER="aithal2024"
    DOCKER_REPO="artisantek"
    IMAGE_TAG="springboot"
  }
  stages{
    stage('Git checkout'){
      agent {label 'agent1'}
      steps{
        git branch: 'master', url: 'https://github.com/devopshype/spring-boot-dockerize'
      }
    }
    stage('Docker build'){
      agent {label 'agent1'}
      steps{
        script{
          sh 'docker build -t ${DOCKER_USER}/${DOCKER_REPO}:{IMAGE_TAG} .'
        }
      }
    }
    stage('Docker login'){
      agent {label 'agent1'}
      steps{
         sh 'docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW> --password-stdin'
        }
      }
    stage('docker push'){
      agent {label 'agent1'}
      steps{
        sh 'docker push ${DOCKER_USER}/${DOCKER_REPO}:{IMAGE_TAG}'
      }
    }
    stage('deploy to Kubernetes'){
      agent {label 'agent2'}
      steps{
        sh 'kubectl apply -f deploymentservice.yaml'
      }
    }
  }
}
