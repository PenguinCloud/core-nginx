FROM penguintech/core-ansible
LABEL maintainer="Penguinz Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
COPY . /opt/manager/
WORKDIR /opt/manager
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y
# URL of source code for nginx
ARG NGINX_URL="http://nginx.org/download/nginx-1.20.2.tar.gz"
ARG NGINX_VERSION="1.20.2"
# on / off
ARG NGINX_GZIP="on"
ARG FPM_ENABLE="yes"
RUN ansible-playbook upstart.yml --tags build -c local
# PUT YER ENVS in here
RUN ansible-playbook upstart.yml --tags run -c local
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]
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
RUN ansible-playbook upstart.yml --tags run -c local
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]
