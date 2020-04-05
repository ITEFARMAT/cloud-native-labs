#Choose your favourite linux distro - here we use alpine: Docker-tailored minimal linux 
FROM alpine:3.11

#Install any prerequisites (like python for gcloud, shell of your choice, etc). Consider upgrading pip to the latest version
RUN apk --no-cache add curl wget unzip bash git openssl nano

#Download copy terraform binary to executable dir (https://www.terraform.io/downloads.html)
RUN wget -q https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip && \
    unzip terraform_0.12.24_linux_amd64.zip && mv terraform /usr/local/bin/ && \
    rm terraform_0.12.24_linux_amd64.zip

#Install kubectl command: https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

#Install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

#Create the workdir of your choice. Set the workdir as an active directory, set HOME env variable to point to your directory
RUN mkdir -p /home/michal
ENV HOME=/home/michal
WORKDIR /home/michal

#Define your home directory as volume, to persist and easily exchange data
VOLUME /home/michal

#Define an entrypoint, pointing to your favourite shell
ENTRYPOINT /bin/bash
