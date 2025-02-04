FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# SYSTEM
RUN apt-get -qq update
RUN apt-get -qq dist-upgrade -y
RUN apt-get -qq autoremove -y
RUN apt-get -qq install -y apt-utils
RUN apt-get -qq install -y ca-certificates tzdata
RUN apt-get -qq install -y curl wget
RUN apt-get -qq install -y software-properties-common
RUN apt-get -qq install -y apt-transport-https
RUN apt-get -qq install -y sudo

# ENVIRONMENT
RUN apt-get -qq install -y git perl ruby
RUN apt-get -qq install -y build-essential
RUN apt-get -qq install -y openjdk-8-jdk ant ant-optional maven
RUN apt-get -qq install -y debhelper

# USERS
RUN useradd -ms /bin/bash -G sudo build
RUN sed -i -e '/^%sudo/s/)\s*ALL$/) NOPASSWD: ALL/' /etc/sudoers
RUN cd /home/build
USER build
RUN mkdir -p /home/build/.ssh
RUN sudo chown -R build:build /home/build/.ssh
RUN sudo apt-get install rsync -y


# REDUCE PRIVILEGE
USER build
WORKDIR /home/build
CMD [ "/bin/bash", "mybuild.sh" ]
