# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.16

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Non interactive package installation
ENV DEBIAN_FRONTEND noninteractive

#Create a system user for running the server
Run useradd -s /bin/bash -d /home/confine -m confine
Run echo "confine:confine"|chpasswd
Run echo 'confine  ALL = (root) NOPASSWD: ALL' > /etc/sudoers.d/local-confine

#Install confine-contoller's source code
RUN apt-get update && apt-get install -y python-pip python-urllib3 git
RUN su confine -c "sudo pip install confine-controller"

#override github repo
RUN rm -rf /usr/local/lib/python2.7/dist-packages/controller
RUN su confine -c "sudo git clone https://github.com/erenyagdiran/vct-controller.git /home/confine/controller"
RUN su confine -c "sudo cp -r /home/confine/controller/controller /usr/local/lib/python2.7/dist-packages/controller"

#Install requirements
RUN su confine -c "sudo controller-admin.sh install_requirements"

#create project
RUN su confine -c "cd /home/confine && controller-admin.sh clone confine"


#this is the installer
COPY controller_only_installer.bash /root/
RUN /bin/bash /root/controller_only_installer.bash 

#vct init
#COPY vct_init /sbin/vct_init
#CMD ["/sbin/vct_init"]

RUN mkdir /etc/service/vct_init
ADD vct_init.sh /etc/service/vct_init/run

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
