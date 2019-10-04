# AWS - CD Prod AMI Packer

## Build Docker Image

`docker build -t packer_aws_ami .`

## Inspect template

`docker run packer_aws_ami inspect /home/template.json`

## Build AMI

`docker run packer_aws_ami build -var 'aws_access_key=' -var 'aws_secret_key=' /home/template.json`
