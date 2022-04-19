FROM penguintech/core-ansible
MAINTAINER Penguin Technologies Group
COPY . /opt/nginx/
# URL of source code for nginx
ARG NGINX_URL="http://nginx.org/download/nginx-1.20.2.tar.gz"
# on / off
ARG NGINX_GZIP="on"
ENV NGINX_DOMAIN="default.penguintech.group"
# tuple of 2
ENV CERT_KEYSIZE="4096"
ENV CERT_EMAIL="na@example.org"
# yes / no
ENV RTMP_ENABLE="yes"
# on / off
ENV RTMP_HLS="on"
# on / off
ENV RTMP_RECORD="on"
ENV RTMP_PORT="1935"
ENV RTMP_USER="user"
ENV RTMP_PASS="123456"
ENV RTMP_DEST_URL="rtmp.penguintech.group"
# Recommend alphanumeric
ENV RTMP_DEST_KEY="notAkey"
WORKDIR "/opt/nginx"
RUN ansible-playbook /opt/nginx/upstart.yml -c local --tags build
RUN ln -sf /dev/stdout /var/log/access.log && ln -sf /dev/stderr /var/log/error.log
ENTRYPOINT ["ansible-playbook", "/opt/nginx/upstart.yml", "-c", "local", "--tags", "run,exec"]
