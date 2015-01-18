#!/bin/sh

service libvirt-bin start && service postfix start && su -l vct -- -c "/home/vct/confine-dist/utils/vct/vct_system_init"
