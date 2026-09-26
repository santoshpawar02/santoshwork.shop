source common.sh
component=cart
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
cp -r cart.service /etc/systemd/system/cart.service
useradd roboshop
rm -rf /app 
mkdir /app 
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app 
unzip /tmp/cart.zip
cd /app 
npm install 
system_setup