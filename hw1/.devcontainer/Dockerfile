FROM ubuntu:20.04

ENV TERRAFORM_VERSION=1.0.1
ENV GOOGLE_APPLICATION_CREDENTIALS="/workspaces/ucu-cloud-platforms-2021/hw1/terraform/key/key.json"

RUN apt-get -y update
RUN apt-get -y install \
    unzip \
    curl \
    ca-certificates \
    apt-transport-https \
    lsb-release \
    gnupg \
    git

RUN curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    terraform version

### gcloud

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
      tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \ 
      curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
      apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && \
      apt-get install google-cloud-sdk -y



