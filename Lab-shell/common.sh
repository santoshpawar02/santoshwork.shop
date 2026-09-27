systemd_setup() {
    echo "Setting up systemd service..."
    systemctl daemon-reload
    systemctl enable $component 
    systemctl restart $component
}

artifact_download() {
    echo "Setting up $component artifact..."
    rm -rf /app 
    mkdir /app 
    curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip
    cd /app 
    unzip /tmp/$component.zip
}

app_prereq() {
    echo "Setting up $component prerequisites..."
    useradd roboshop
    cp -r $component.service /etc/systemd/system/$component.service
}


nodejs_app_setup() {
    echo "Setting up $component NodeJS service..."
    dnf module disable nodejs -y
    dnf module enable nodejs:20 -y
    dnf install nodejs -y
    app_prereq
    artifact_download
    cd /app 
    npm install 
    systemd_setup
}


maven_app_setup() {
    echo "Setting up $component Maven service..."
    dnf install maven -y
    app_prereq
    artifact_download
    cd /app 
    mvn clean package 
    mv target/$component-1.0.jar $component.jar 
}


python_app_setup() {
    echo "Setting up $component Python service..."
    dnf install python36 gcc python3-devel -y
    app_prereq
    artifact_download
    cd /app 
    pip3.6 install -r requirements.txt 
    systemd_setup
}


print_head (){
  echo -e "\e[32m$*\e[0m"
  echo -e "\e[32m############################\e[0m" &>>$log_file
  echo -e "\e[32m$*\e[0m" &>>$log_file
  echo -e "\e[32m############################\e[0m" &>>$log_file
}

log_file="/tmp/roboshop.log"
rm -f $log_file