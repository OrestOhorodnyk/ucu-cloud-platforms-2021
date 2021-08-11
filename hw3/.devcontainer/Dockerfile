FROM ubuntu:20.04

ENV TERRAFORM_VERSION=1.0.1
ENV GOOGLE_APPLICATION_CREDENTIALS="/workspaces/ucu-cloud-platforms-2021/hw3/task1/terraform/key/key.json"

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

RUN apt-get update && \
    apt-get --only-upgrade install \ 
    google-cloud-sdk-cloud-build-local \
    google-cloud-sdk-app-engine-java \
    google-cloud-sdk-app-engine-python \
    google-cloud-sdk-skaffold \
    google-cloud-sdk kubectl \
    google-cloud-sdk-app-engine-go \
    google-cloud-sdk-app-engine-grpc \
    google-cloud-sdk-local-extract \
    google-cloud-sdk-config-connector \
    google-cloud-sdk-anthos-auth \
    google-cloud-sdk-minikube \
    google-cloud-sdk-kpt \
    google-cloud-sdk-firestore-emulator \
    google-cloud-sdk-cbt \
    google-cloud-sdk-spanner-emulator \
    google-cloud-sdk-kubectl-oidc \
    google-cloud-sdk-datalab \
    google-cloud-sdk-pubsub-emulator \
    google-cloud-sdk-bigtable-emulator \
    google-cloud-sdk-datastore-emulator \
    google-cloud-sdk-app-engine-python-extras

    



