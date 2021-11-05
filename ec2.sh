#!/bin/bash
# Generic EC2

export KEYS_DIR=~/Desktop/earth/keys

# List all keys in keys directory.
function ec2-key-list {
    ls -l $KEYS_DIR;
}

# Make a key read only
function ec2-key-lock {
    local KEY=$1
    chmod 400 $KEY;
}

# SSH to your EC2 instance
function ec2-ssh {
    local USER="ec2-user"
    local PUBLIC_IP=$1
    local PRIVATE_KEY=$2
    ssh $USER@$PUBLIC_IP -i $KEYS_DIR/$PRIVATE_KEY
}
