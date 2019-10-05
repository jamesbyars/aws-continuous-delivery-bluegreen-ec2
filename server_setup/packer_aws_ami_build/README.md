# AWS - CD Prod AMI Packer

I've been running this locally.  I really don't want to mess with installing 
Docker on my Jenkins server.  Plus, I don't intend on building a new AMI for 
every release.  The application bundle should contain everything it needs to 
run so deployment should look as simple as copying the package to the server 
and firing it up.

Additionally, building the AMI takes ~5 minutes which is too long for changes 
to run in the pipeline - I'm looking to go from commit to production in 1-3 
minutes, tops.

## Local Execution of This Stuff

### Build Docker Image

`docker build -t packer_aws_ami .`

### Inspect template

`docker run packer_aws_ami inspect /home/template.json`

### Build AMI

`docker run packer_aws_ami build -var 'aws_access_key=' -var 'aws_secret_key=' /home/template.json`

---

# TODO

Create a new pipeline in Jenkins to provision a new AMI and create suite of 
tests to verify it.
