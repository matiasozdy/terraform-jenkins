#!/bin/bash
for a in `cat main.tf | grep resource | cut -d" " -f3`; do
b="${a%\"}"
b="${b#\"}"
echo 'output "'$b'" {'
echo 'value = ["${aws_security_group.'$b'.id}"]'
echo '}'
done
