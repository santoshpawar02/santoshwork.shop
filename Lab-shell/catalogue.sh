source common.sh
component=catalogue
print_head "Copying Mongo Repo file"
cp -r mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
exit_status_print $?
nodejs_app_setup
print_head "Installing MongoDB Shell"
dnf install mongodb-mongosh -y &>>$log_file
exit_status_print $?
print_head "Loading Catalogue Master Data"
mongosh --host mongo-dev.santoshwork.shop </app/db/master-data.js  &>>$log_file 
exit_status_print $?