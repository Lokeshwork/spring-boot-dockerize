pipeline{
  agent none
  environment{
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
          sh "docker build -t ${DOCKER_USER}/${DOCKER_REPO}:{IMAGE_TAG} ."
        }
      }
    }
    stage('Docker login'){
      agent {label 'agent1'}
      steps{
        withCredentials([usernamePassword(credentialsId: 'docker-creds', passwordVariable: 'docker_pwd', usernameVariable: 'docker_user')]) {
          sh "docker login -u ${docker_user} -p ${docker_pwd}
        }
      }
    }
    stage('docker push'){
      agent {label 'agent1'}
      steps{
        sh "docker push ${DOCKER_USER}/${DOCKER_REPO}:{IMAGE_TAG}"
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
