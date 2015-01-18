#!/bin/sh

#permission fixer for fuse dev
chown root:fuse /dev/fuse
chmod 770 /dev/fuse

#permission fixer for kvm dev
chown root:kvm /dev/kvm
chmod 770 /dev/kvm


