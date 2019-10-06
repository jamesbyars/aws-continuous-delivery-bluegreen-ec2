pipeline {
    agent any

    parameters {
        choice(name: 'AMI_ID', choices: ['ami-0532897ea68646ce2'], description: 'Pick something')

        choice(name: 'EC2_INSTANCE_SIZE', choices: ['t2.micro'], description: 'Pick something')

        choice(name: 'EC2_KEY_NAME', choices: ['TestCDKP'], description: 'Pick something')

        choice(name: 'EC2_INSTANCE_SECURITY_GROUP', choices: ['sg-0cc3ddd38bf36da58'], description: 'Pick something')
        
        choice(name: 'EC2_INSTANCE_SUBNET_ID', choices: ['subnet-0275526f11c557ad3'], description: 'Pick something')

        text(name: 'EC2_INSTANCE_NAME', defaultValue: '', description: 'Name of the EC2 Instance')
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                // sh 'aws s3 ls'
            }
        }
        stage('Provision new EC2 Instance') {
            steps {
                // sh 'aws ec2 run-instances --region us-east-1 --image-id ${AMI_ID} --count 1 --instance-type ${EC2_INSTANCE_SIZE} --key-name ${EC2_KEY_NAME} --security-group-ids ${EC2_INSTANCE_SECURITY_GROUP} --subnet-id ${EC2_INSTANCE_SUBNET_ID} --tag-specifications \'ResourceType=instance,Tags=[{Key=Name,Value=${EC2_INSTANCE_NAME}]\' ' 
                // sh 'aws ec2 wait instance-exists'

                sh "instance_id=aws ec2 run-instances --region us-east-1 --image-id ${AMI_ID} --count 1 --instance-type ${EC2_INSTANCE_SIZE} --key-name ${EC2_KEY_NAME} --security-group-ids ${EC2_INSTANCE_SECURITY_GROUP} --subnet-id ${EC2_INSTANCE_SUBNET_ID} --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=${EC2_INSTANCE_NAME}}]'  --output text --query 'Instances[*].InstanceId'"
            }
        }
        stage('Wait for instance to come online') {
            sh """ 
                while state=aws ec2 describe-instances --instance-ids $instance_id --output text --query 'Reservations[*].Instances[*].State.Name'; test "$state" = "pending"; do
                    sleep 1; echo -n '.'
                done; echo " $state"
            """
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