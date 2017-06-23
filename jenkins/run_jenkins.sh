#!/bin/bash
datapath="$(pwd)/data"
image="jenkins_mod"
docker build -t $image:latest .
docker run -d -p 8080:8080 -p 50000:50000 -v $datapath:/var/jenkins_home $image
