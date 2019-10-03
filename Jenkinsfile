pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'aws s3 ls'
            }
        }
        stage('Provision new EC2 Instance') {
            steps {
                sh 'aws ec2 run-instances --image-id ami-0b69ea66ff7391e80 --count 1 --instance-type t2.micro --key-name testkp --security-group-ids sg-01401b093a720bc33 --subnet-id subnet-0dc6c8185308716b7'
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