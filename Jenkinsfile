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

                sh "echo '' > instance_id.txt"
                sh "echo '' > ip_address.txt"
            }
        }
        stage('Provision new EC2 Instance') {
            steps {
                
                sh """ 
                    instance_id=`aws ec2 run-instances --associate-public-ip-address --region us-east-1 --image-id ${AMI_ID} --count 1 --instance-type ${EC2_INSTANCE_SIZE} --key-name ${EC2_KEY_NAME} --security-group-ids ${EC2_INSTANCE_SECURITY_GROUP} --subnet-id ${EC2_INSTANCE_SUBNET_ID} --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=${EC2_INSTANCE_NAME}}]'  --output text --query 'Instances[*].InstanceId'` 

                    echo "\$instance_id" > instance_id.txt
                    """
            }
        }
        stage('Wait for EC2 to Be Running') {
            steps {
                script {
                    instance_id = readFile('instance_id.txt').trim()
                }
                echo "entering describe instances"
                sh """ 
                    while state=`aws ec2 describe-instances --instance-ids ${instance_id} --output text --query 'Reservations[*].Instances[*].State.Name'`; test "\$state" = "pending"; do
                      sleep 1; echo -n '.'
                    done; echo "\$state"
                    
                    ip_address=`aws ec2 describe-instances --instance-ids ${instance_id} --output text --query 'Reservations[*].Instances[*].PublicIpAddress'`
                    echo "\$ip_address" > ip_address.txt
                    """
            }
        }
        stage('Smoke test instance configs') {
            options {
                retry(3)
            }
            steps {
                script {
                    instance_id = readFile('instance_id.txt').trim()
                    ip_address = readFile('ip_address.txt').trim()
                }

                // Port 22 should be open
                sh "nc -z -w20 ${ip_address} 22"
                echo "Result from nc (should be 0)"
                sh "echo \$?"
            }
        }
        stage('Test') {

            input {
                message "Do a manual review of the app"
                ok "Go to PROD!"    
            }

            steps {
                echo 'Testing..'

                echo "${instance_id}"
                echo "${ip_address}"

                
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
    post {
        always {
            echo 'One way or another, I have finished'
            // deleteDir() /* clean up our workspace */
        }
        success {
            echo 'I succeeeded!'
        }
        unstable {
            echo 'I am unstable :/'
        }
        failure {
            echo 'I failed :('

            script {
                instance_id = readFile('instance_id.txt').trim()
            }

            sh "aws ec2 terminate-instances --instance-ids ${instance_id}"

        }
        changed {
            echo 'Things were different before...'
        }
    }
}