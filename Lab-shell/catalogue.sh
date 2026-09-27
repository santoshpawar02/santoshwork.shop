source common.sh
component=catalogue
print_head "Copying Mongo Repo file"
cp -r mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
nodejs_app_setup
print_head "Installing MongoDB Shell"
dnf install mongodb-mongosh -y &>>$log_file
print_head "Loading Catalogue Master Data"
mongosh --host mongo-dev.santoshwork.shop </app/db/master-data.js  &>>$log_file 