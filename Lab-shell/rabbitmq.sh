source common.sh
component=rabbitmq
print_head "Copying RabbitMQ Repo file"
cp -r rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$log_file
exit_status_print $?
print_head "Installing RabbitMQ"
dnf install rabbitmq-server -y &>>$log_file
exit_status_print $?

print_head "Starting RabbitMQ"
systemctl enable rabbitmq-server &>>$log_file
systemctl start rabbitmq-server &>>$log_file
exit_status_print $?

print_head "Setting up RabbitMQ User"
rabbitmqctl add_user roboshop roboshop123 &>>$log_file
exit_status_print $?
print_head "Setting up RabbitMQ Permissions"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
exit_status_print $?
print_head "Setting up systemd service"
systemd_setup