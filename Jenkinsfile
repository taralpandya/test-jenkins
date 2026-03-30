pipeline {
  agent { label 'docker' }

  options {
    timestamps()
  }

  environment {
    IMAGE_NAME = 'ghcr.io/taralpandya/test-jenkins'
    IMAGE_TAG = "${env.BUILD_NUMBER}"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Verify Agent') {
      steps {
        sh '''
          echo "Running on $(hostname)"
          whoami
          pwd
          git --version
          docker version
        '''
      }
    }

    stage('Login to GHCR') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'ghcr-creds',
          usernameVariable: 'GHCR_USER',
          passwordVariable: 'GHCR_TOKEN'
        )]) {
          sh '''
            echo "$GHCR_TOKEN" | docker login ghcr.io -u "$GHCR_USER" --password-stdin
          '''
        }
      }
    }

    stage('Build Image') {
      steps {
        sh '''
          docker build -t $IMAGE_NAME:$IMAGE_TAG .
          docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest
        '''
      }
    }

    stage('Push Image') {
      steps {
        sh '''
          docker push $IMAGE_NAME:$IMAGE_TAG
          docker push $IMAGE_NAME:latest
        '''
      }
    }
  }
}
