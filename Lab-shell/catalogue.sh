source common.sh
component=catalogue

dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
cp -r catalogue.service /etc/systemd/system/catalogue.service
cp -r mongo.repo /etc/yum.repos.d/mongo.repo
useradd roboshop
rm -rf /app 
mkdir /app 
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip 
cd /app 
unzip /tmp/catalogue.zip
cd /app 
npm install 
dnf install mongodb-mongosh -y
system_setup
mongosh --host mongo-dev.santoshwork.shop </app/db/master-data.js