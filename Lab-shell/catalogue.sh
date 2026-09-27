source common.sh
component=catalogue
cp -r mongo.repo /etc/yum.repos.d/mongo.repo
nodejs_app_setup
dnf install mongodb-mongosh -y
mongosh --host mongo-dev.santoshwork.shop </app/db/master-data.js