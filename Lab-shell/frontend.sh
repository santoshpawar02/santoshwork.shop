print_head (){
  echo -e "\e[1;32m$1\e[0m"
}

source common.sh
component=frontend


print_head "Disabling Nginx"
dnf module disable nginx -y

print_head "Enabling Nginx"
dnf module enable nginx:1.24 -y

print_head "Installing Nginx"
dnf install nginx -y
#cp -r nginx.conf /etc/nginx/nginx.conf



rm -rf /usr/share/nginx/html/* 

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

cd /usr/share/nginx/html 
unzip /tmp/frontend.zip

print_head "Starting Nginx"
systemd_setup