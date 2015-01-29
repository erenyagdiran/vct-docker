#!/bin/sh

exec /sbin/setuser vct sudo service libvirt-bin start && sudo service postfix start && sudo service rabbitmq-server restart && exec "/home/vct/confine-dist/utils/vct/vct_system_init"
