pipeline {
  agent {
    docker {
      image 'blang/latex:ubuntu'
      args '-u root'
    }
  }

  environment {
    LANG = 'en_US.UTF-8'
    LANGUAGE = 'en_US:en'
    LC_ALL = 'en_US.UTF-8'
    REACT_APP_REPO = 'christophersherman/csherman.net'
    REACT_APP_BRANCH = 'master'
  }

  stages {
    stage('Setup') {
      steps {
        sh '''
          apt-get update
          apt-get install -y git npm sudo curl texlive-full biber locales
          locale-gen en_US.UTF-8
          update-locale LANG=en_US.UTF-8
          useradd -m -s /bin/bash jenkins
          echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
          mkdir -p /workspace
          chown -R jenkins:jenkins /workspace
          curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
          apt-get install -y nodejs
          echo "Setup complete"
        '''
      }
    }
    stage('Checkout LaTeX Repo') {
      steps {
        script {
          sh 'sudo -u jenkins -H bash -c "git clone https://github.com/christophersherman/my-resume.git /workspace"'
        }
      }
    }
    stage('Build LaTeX') {
      steps {
        script {
          sh '''
            sudo -u jenkins -H bash -c "cd /workspace && pdflatex -interaction=nonstopmode my_resume.tex"
            sudo -u jenkins -H bash -c "cd /workspace && biber my_resume || true"
            sudo -u jenkins -H bash -c "cd /workspace && pdflatex -interaction=nonstopmode my_resume.tex"
            sudo -u jenkins -H bash -c "cd /workspace && pdflatex -interaction=nonstopmode my_resume.tex"
          '''
        }
      }
    }
    stage('Archive PDF') {
      steps {
        archiveArtifacts artifacts: 'my_resume.pdf', allowEmptyArchive: false
      }
    }
    stage('Checkout React App Repo') {
      steps {
        withCredentials([string(credentialsId: 'github_token', variable: 'GITHUB_TOKEN')]) {
          script {
            sh 'sudo -u jenkins -H bash -c "git clone https://${GITHUB_TOKEN}@github.com/${REACT_APP_REPO}.git /workspace/react-app"'
          }
        }
      }
    }
    stage('Copy Resume to React App') {
      steps {
        script {
          sh 'sudo -u jenkins -H bash -c "cp /workspace/my_resume.pdf /workspace/react-app/public/resume.pdf"'
        }
      }
    }
    stage('Commit and Push Changes') {
      steps {
        withCredentials([string(credentialsId: 'github_token', variable: 'GITHUB_TOKEN')]) {
          script {
            sh '''
              cd /workspace/react-app
              git config --global user.name 'jenkins'
              git config --global user.email 'jenkins@csherman.net'
              git add public/resume.pdf
              git commit -m "Update resume.pdf"
              git remote set-url origin https://${GITHUB_TOKEN}@github.com/${REACT_APP_REPO}.git
              git push origin ${REACT_APP_BRANCH}
            '''
          }
        }
      }
    }
  }
}
