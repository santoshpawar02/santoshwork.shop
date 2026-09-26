systemd_setup() {
    echo "Setting up systemd service..."
    systemctl daemon-reload
    systemctl enable nginx 
    systemctl restart nginx
}