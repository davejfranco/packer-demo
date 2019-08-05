#!/bin/bash

#yum update -y
mv /etc/yum.repos.d/public-yum-ol7.repo /etc/yum.repos.d/public-yum-ol7.repo.bak
wget -O /etc/yum.repos.d/public-yum-ol7.repo http://yum.oracle.com/public-yum-ol7.repo
yum install -y yum-utils
yum-config-manager --enable ol7_developer_php72

cat > /etc/yum.repos.d/nginx.repo <<'EOF'
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/rhel/7/$basearch/
gpgcheck=0
enabled=1
EOF

#Update repo
yum update -y

#Install nginx
yum install -y nginx vim unzip php php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-mcrypt php-ldap php-zip php-curl

#Install wordpress
wget http://wordpress.org/latest.zip && unzip latest.zip
mkdir -p /var/www/html && mv wordpress/ /var/www/html
chown -R nginx:nginx /var/www/html/wordpress
chmod -R 775 /var/www/html/wordpress

cp /vagrant/vmsimgs/wordpress/php.ini /etc/php.ini
rm /etc/nginx/conf.d/default.conf
cp /vagrant/vmsimgs/wordpress/wordpress.conf /etc/nginx/conf.d/ && chown nginx:nginx /etc/nginx/conf.d/wordpress.conf

systemctl start php-fpm
systemctl start nginx 