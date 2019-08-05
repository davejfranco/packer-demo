#!/bin/bash

set -x 

export LC_ALL=C

export NEWPASS="$1"
export WPPASS="$2"


#Instal mysql
yum update -y 
wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
rpm -Uvh mysql80-community-release-el7-3.noarch.rpm
yum install mysql-community-server -y

#Start mysql service
systemctl start mysqld  

#Change mysql default root password
MYSQLPASS=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $13}')
echo "changing root password"
sleep 2
mysql -u root -p"$MYSQLPASS" --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$NEWPASS';"


echo "creating mysql setup script"
sleep 2
cat << EOF > /tmp/wp_setup.sql
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;

CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'wordpressuser'@'%' IDENTIFIED BY '$WPPASS';
GRANT ALL ON wordpress.* TO 'wordpressuser'@'%';
EOF

#Setup wordpress DB
echo "running setup script..."
sleep 2
mysql -u root -p"$NEWPASS" < /tmp/wp_setup.sql
echo "done!"
