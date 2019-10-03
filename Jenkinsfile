pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                aws s3 ls
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}