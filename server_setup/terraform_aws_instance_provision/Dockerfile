FROM alpine:latest
MAINTAINER "HashiCorp Terraform Team <terraform@hashicorp.com>"

ENV TERRAFORM_VERSION=0.12.9
ENV TERRAFORM_SHA256SUM=b337c885526a8a653075551ac5363a09925ce9cf141f4e9a0d9f497842c85ad5

RUN apk add --update git bash wget

ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS ./

# RUN sed -i '/terraform_${TERRAFORM_VERSION}_linux_amd64.zip/!d' terraform_${TERRAFORM_VERSION}_SHA256SUMS
# RUN sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

WORKDIR /home

ADD *.tf ./

RUN terraform init

ENV AWS_ACCESS_KEY_ID=AKIAUJTQ4H77OUVDXMSL
ENV AWS_SECRET_ACCESS_KEY=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

# ENTRYPOINT ["/bin/terraform"]