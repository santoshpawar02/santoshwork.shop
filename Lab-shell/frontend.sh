source common.sh
component=frontend


print_head "Disabling Nginx"
dnf module disable nginx -y &>>$log_file
exit_status_print $?

print_head "Enabling Nginx"
dnf module enable nginx:1.24 -y &>>$log_file
exit_status_print $?

print_head "Installing Nginx"
dnf install nginx -y    &>> $log_file
exit_status_print $?
cp -r nginx.conf /etc/nginx/nginx.conf



rm -rf /usr/share/nginx/html/* &>> $log_file

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip  &>> $log_file
exit_status_print $?
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>> $log_file
exit_status_print $?

print_head "Starting Nginx"
systemctl enable nginx  &>> $log_file
systemctl restart nginx &>> $log_file
exit_status_print $?