#!/bin/bash
ansible-playbook upstart.yml --tags=exec -c local
/bin/sleep infinity
