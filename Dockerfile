FROM williamyeh/ansible:ubuntu16.04

# Storing the Buildnumber within the image as environment variable CONT_IMG_VER
ARG CONT_IMG_VER
ENV CONT_IMG_VER ${CONT_IMG_VER:-v0}

RUN apt-get update

# AWS CLI needs the PYTHONIOENCODING environment varialbe to handle UTF-8 correctly:
ENV PYTHONIOENCODING=UTF-8

RUN apt-get update && \
    apt-get install -y \
    less \
    curl \
    nano \
    python \
    python-pip \
    python-virtualenv \
    python-lxml \
    python-pexpect \
    openssh-client \
    jq \
    git \
    vim \
    unzip \
    sudo \
    openjdk-8-jdk  \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    groff \
    net-tools
    


RUN pip install awscli j2cli[yaml] boto boto3 docker-py

WORKDIR /opt
Add http://mirror.yannic-bonenberger.com/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.zip apache-maven-3.5.0-bin.zip
RUN unzip apache-maven-3.5.0-bin.zip && echo 'export PATH=$PATH:/opt/apache-maven-3.5.0/bin' >> /root/.bashrc

# Install Docker-ce to use Docker in Docker.
# To really use docker in docker you have to forward the docker port with this port mapping: "-v /var/run/docker.sock:/var/run/docker.sock"
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       wheezy \
       stable"

RUN apt-get -y update && \
    apt-get -y install sudo docker-ce

# add the host-ip address as dockerhost to etc hosts: https://www.reddit.com/r/devops/comments/6d6dcu/connecting_to_localhost_of_the_machine_from/
RUN echo 'echo $(netstat -nr | grep '"'"'^0\.0\.0\.0'"'"' | awk '"'"'{print $2}'"'"' ) dockerhost >> /etc/hosts' >> /root/.bashrc

RUN pip install --upgrade pip && pip install ansible --upgrade

WORKDIR /project
