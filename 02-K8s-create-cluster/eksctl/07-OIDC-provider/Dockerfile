FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
  vim \
  sudo \
python3-pip

RUN pip3 install awscli

RUN usermod -aG sudo jenkins

RUN echo '%sudo  ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN groupdadd -g 994 docker

RUN usermod -aG docker jenkins
USER jenkins
