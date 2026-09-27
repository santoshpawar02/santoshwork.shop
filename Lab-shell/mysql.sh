source common.sh
component=mysql
print_head "Installing MySQL"
dnf install mysql-server -y &>>$log_file
exit_status_print $?
print_head "Starting MySQL"
systemctl enable mysqld &>>$log_file
systemctl start mysqld  &>>$log_file
exit_status_print $?
print_head "Setting up MySQL Root Password" 
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file
exit_status_print $?
systemd_setup 