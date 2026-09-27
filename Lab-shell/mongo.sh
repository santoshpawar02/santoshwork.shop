source common.sh
component=mongo
print_head "Copying Mongo Repo file"
cp -r mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
exit_status_print $?
print_head "Installing MongoDB" 
dnf install mongodb-org -y &>>$log_file
exit_status_print $?
print_head "Starting MongoDB"
systemctl enable mongod &>>$log_file
systemctl start mongod &>>$log_file
exit_status_print $?
print_head "Updating MongoDB Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0/g'  /etc/mongod.conf &>>$log_file
exit_status_print $?
print_head "Setting up systemd service"
systemd_setup