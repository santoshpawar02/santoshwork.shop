dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
cp -r catalogue.service /etc/systemd/system/catalogue.service
useradd roboshop
mkdir /app 
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip 
cd /app 
unzip /tmp/catalogue.zip
cd /app 
npm install 
cp -r mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-mongosh -y
systemctl daemon-reload
mongosh --host MONGODB-SERVER-IPADDRESS </app/db/master-data.js