#!/bin/bash

sudo su <<HERE

yum install httpd -y 
apachectl start
systemctl enable httpd
apachectl configtest
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --reload
echo 'This is Oracle webserver was build using Packer for the OCI Workshop' > /var/www/html/index.html
HERE