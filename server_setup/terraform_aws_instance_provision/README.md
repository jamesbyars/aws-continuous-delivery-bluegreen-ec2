# AWS - CD Prod AMI Terraform

## NOTE!!!

Really, this doesn't belong here.  It should never be run locally.  

This job should run in Jenkins

Probably don't need Dockerfile

## Experimental

Build AMI

`docker build -t terraform_aws_provision_ami .`

Plan

`docker run terraform_aws_provision_ami plan`

Apply

`docker run -it terraform_aws_provision_ami apply -auto-approve`

---


`docker run -it terraform_aws_provision_ami plan -var="aws_access_key=abc123" -var="aws_secret_key=abc123" -var="aws_key_pair=abc123"`






