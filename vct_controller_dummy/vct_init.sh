#!/bin/sh

exec /sbin/setuser vct sudo service libvirt-bin start && sudo service postfix start && exec "/home/vct/confine-dist/utils/vct/vct_system_init"
