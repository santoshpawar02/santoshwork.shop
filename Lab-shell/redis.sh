source common.sh
component=redis
dnf module disable redis -y
dnf module enable redis:7 -y
dnf install redis -y 
sed -i -e 's/127.0.0.0/0.0.0.0/g' -e 's/protected-mode yes/protected-mode no/g' /etc/redis/redis.conf
systemd_setup