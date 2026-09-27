source common.sh
component=redis
print_head "Disabling Redis Module"
dnf module disable redis -y &>>$log_file
exit_status_print $?
print_head "Enabling Redis Module"
dnf module enable redis:7 -y &>>$log_file
exit_status_print $?
print_head "Installing Redis"
dnf install redis -y  &>>$log_file
exit_status_print $?                        
print_head "Updating Redis Configuration"
sed -i -e 's/127.0.0.0/0.0.0.0/g' -e 's/protected-mode yes/protected-mode no/g' /etc/redis/redis.conf &>>$log_file
exit_status_print $?
print_head "Setting up systemd service"
systemd_setup