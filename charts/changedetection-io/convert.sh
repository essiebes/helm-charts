#!/bin/bash
kompose convert --chart --controller=statefulset --pvc-request-size=100Mi --replicas=1 --with-kompose-annotation=false -f docker-compose.yml  -o .