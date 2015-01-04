# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:0.9.15

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

 #No support for i386 as of 5.Nov.2014
 RUN echo 'we are running some # of cool things'
 MAINTAINER "Eren Yagdiran"
 #Now starting..
 #Disable to install recommended packages
 Run echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf
 #Disable interactive installation
 ENV DEBIAN_FRONTEND noninteractive
 #Install the base packages
 Run apt-get update && apt-get install -y \
  locales git sudo libvirt-bin module-init-tools python-pip fuse makedev \
  inetutils-syslogd postfix mutt ca-certificates \
  vim-tiny nano screen w3m less
 #Adding vct user
 Run useradd -s /bin/bash -d /home/vct -m vct
 #Setting passwd to "Confine"
 Run echo "vct:confine"|chpasswd
 #Late Command
 Run adduser vct libvirtd; \
  adduser vct fuse; \
  #sed -i -e 's/^[^a-z]*\\(en_US.UTF-8 UTF-8\\) */\\1/' /etc/locale.gen; \
  locale-gen;
 #Set rootpasswd
 Run echo "root:confine"|chpasswd
 #Clone git repo
 Run su -l vct -- -c "git clone -b testing 'https://github.com/erenyagdiran/confine-dist.git' /home/vct/confine-dist"
 #Append $PATH variable
 Run su -l vct -- -c 'echo PATH="$HOME/confine-dist/utils/vct:$PATH" >> /home/vct/.bashrc'
 #Passwordless Sudo
 Run echo 'vct  ALL = (root) NOPASSWD: ALL' > /etc/sudoers.d/local-vct
 Run chmod 0440 /etc/sudoers.d/local-vct
 #Sudo Ask No
 Run echo 'VCT_KERNEL_MODULES=' >> /home/vct/confine-dist/utils/vct/vct.conf.overrides
 Run echo 'VCT_SUDO_ASK=NO' >> /home/vct/confine-dist/utils/vct/vct.conf.overrides

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
