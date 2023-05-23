#!/bin/bash

ID_RSA=~/.ssh/id_rsa.pub 

if [ ! -f $ID_RSA ]; then       
expect -c "spawn ssh-keygen" \
                   -c "expect -re \":\"" \
                   -c "send \"\r\"" \
                   -c "expect -re \":\"" \
                   -c "send \"\r\"" \
                   -c "expect -re \":\"" \
                   -c "send \"\r\"" \
                   -c "puts \" \n * ssh-keygen success!!#3 *\"" \
                   -c "interact"
fi

NAME=`whoami`



