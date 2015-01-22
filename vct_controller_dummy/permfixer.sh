#!/bin/sh

#permission fixer for fuse dev
exec chown root:fuse /dev/fuse
exec chmod 770 /dev/fuse

#permission fixer for kvm dev
exec chown root:kvm /dev/kvm
exec chmod 770 /dev/kvm


