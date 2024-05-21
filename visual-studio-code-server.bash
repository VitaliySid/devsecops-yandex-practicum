curl -fOL https://github.com/coder/code-server/releases/download/v4.6.0/code-server_4.6.0_amd64.deb
sudo dpkg -i code-server_4.6.0_amd64.deb
sudo systemctl enable --now code-server@$USER

#~/.config/code-server/config.yaml
# change password

sudo systemctl restart code-server@$USER
sudo apt install -y nginx certbot python3-certbot-nginx

# use https://sslip.io/

# server {
#     listen 80;
#     listen [::]:80;
#     server_name code.158.160.96.226.sslip.io;

#     location / {
#       proxy_pass http://localhost:8080/;
#       proxy_set_header Host $host;
#       proxy_set_header Upgrade $http_upgrade;
#       proxy_set_header Connection upgrade;
#       proxy_set_header Accept-Encoding gzip;
#     }
# }

sudo ln -s ../sites-available/code-server /etc/nginx/sites-enabled/code-server
sudo certbot --non-interactive --redirect --agree-tos --nginx -d code.178.154.225.203.sslip.io -m qwuens@gmail.com
