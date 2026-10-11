@Library('Shared') _

pipeline {
agent {
label 'dev-server'
}
stages {
    stage('Clone Code') {
        steps {
            sh 'whoami'

            clone(
                'https://github.com/LondheShubham153/django-notes-app.git',
                'main'
            )
        }
    }

    stage('Code Build') {
        steps {
            dockerbuild('notes-app', 'latest')
        }
    }

    stage('Push to DockerHub') {
        steps {
            dockerpush('dockerHubCreds', 'notes-app', 'latest')
        }
    }

    stage('Deploy') {
        steps {
            deploy()
        }
    }
}

post {
    success {
        echo 'CI/CD Pipeline completed successfully!'
    }

    failure {
        echo 'CI/CD Pipeline failed. Please check the Console Output.'
    }
}
}
