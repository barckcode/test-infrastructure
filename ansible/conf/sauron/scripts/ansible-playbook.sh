#!/bin/bash
docker exec -it ansible /usr/local/bin/ansible-playbook $1 $2 $3
