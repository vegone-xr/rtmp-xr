export NGINX_VERSION=nginx-1.19.10
export NGINX_RTMP_MODULE_VERSION=1.2.1

sudo apt update && sudo apt upgrade -y
sudo apt install -y ca-certificates openssl libssl-dev

# Download and decompress Nginx
mkdir -p /tmp/build/nginx
cd /tmp/build/nginx
wget -O ${NGINX_VERSION}.tar.gz https://nginx.org/download/${NGINX_VERSION}.tar.gz
tar -zxf ${NGINX_VERSION}.tar.gz

# Download and decompress RTMP module
mkdir -p /tmp/build/nginx-rtmp-module
cd /tmp/build/nginx-rtmp-module
wget -O nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}.tar.gz https://github.com/arut/nginx-rtmp-module/archive/v${NGINX_RTMP_MODULE_VERSION}.tar.gz
tar -zxf nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}.tar.gz
cd nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}

# Build and Install Nginx
sudo apt install -y build-essential libpcre3-dev zlib1g-dev
cd /tmp/build/nginx/${NGINX_VERSION}
./configure --sbin-path=/usr/local/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --pid-path=/var/run/nginx/nginx.pid --lock-path=/var/lock/nginx/nginx.lock --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/tmp/nginx-client-body --with-http_ssl_module --with-threads --with-ipv6 --add-module=/tmp/build/nginx-rtmp-module/nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION} --with-cc-opt="-Wimplicit-fallthrough=0"
make -j $(getconf _NPROCESSORS_ONLN)
sudo make install
mkdir /var/lock/nginx
rm -rf /tmp/build
sudo mkdir -p /usr/local/nginx/logs
sudo wget -O /etc/systemd/system/nginx.service https://raw.githubusercontent.com/vegone-xr/rtmp-xr/main/server/nginx.service
sudo systemctl daemon-reload
# sudo nginx
# sudo nginx -s reload
# sudo nginx -s stop
# sudo systemctl enable nginx
sudo systemctl start nginx

# Config Nginx
sudo wget -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/vegone-xr/rtmp-xr/main/server/nginx.conf
sudo nginx -s reload

# Install And Run NodeJs
wget -qO- https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g pm2
wget -O /home/ubuntu/server.js https://raw.githubusercontent.com/vegone-xr/rtmp-xr/main/server/server.js
pm2 start server.js
pm2 startup systemd