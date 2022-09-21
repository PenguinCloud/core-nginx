FROM code-dal1.penguintech.group:5050/ptg/standards/docker-ansible-image
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# UPDATE as needed
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y

# PUT YER ARGS in here
ARG RTMP_LINK="https://github.com/arut/nginx-rtmp-module.git"
ARG MODSEC_LINK="https://github.com/SpiderLabs/ModSecurity.git"
ARG SEC_HEADERS_LINK="https://github.com/GetPageSpeed/ngx_security_headers.git"
ARG NGINX_URL="http://nginx.org/download/nginx-1.22.0.tar.gz"
ARG NGINX_VERSION="1.22.0"
ARG NGINX_GZIP="on"
ARG HTTPS_ENABLE="self signed"
ARG FPM_ENABLE="yes"
# Change this to actual title for Default
ARG APP_TITLE="NGINX"

# BUILD IT!
RUN ansible-playbook build.yml -c local

ENV WORKER_CONNECTIONS="1024"
# ENV RTMP_EBABLE="no" Not needed
# ENV RTMP_HLS="on"
# ENV RTMP_RECORD="on" Not needed
# ENV RTMP_PORT="1935"
# ENV RTMP_USER="user" Not needed
# ENV RTMP_PASS="123456" Not nedded
# ENV RTMP_DEST_URL="rtmp.penguintech.group"
## Recommend alphanumeric
#ENV RTMP_DEST_KEY="notAkey" Not Needed
#ENV STREAM_ENABLE="no" Not Nneeded
#ENV STREAM_PORT="2525" Not needed
#ENV STREAM_PROTO="tcp"  Not needed
#ENV STREAM_BUFFER="16k" Not needed
#ENV HTTP_ENABLE="yes" Not needed
ENV HTTP_SERVER_NAME="Nginx"
#ENV HTTP_PORT="80"
#ENV HTTP_ROOT="/var/www/public_html" Not needed # Not needed
#ENV HTTPS_ENABLE="self signed"
#ENV HTTPS_REDIRECT="yes"
#ENV HTTPS_ROOT="/opt/nginx" Not needed
#ENV HTTPS_PORT="443"
ENV HTTPS_KEYSIZE="4096"
ENV HTTPS_TLD="example.penguintech.group"
ENV HTTPS_EMAIL="iainjenkins@webmail.co.za"
ENV HTTPS_METHOD="BYOC"
ENV HTTPS_NAME="name"
ENV HTTPS_COUNTRY="US"
ENV HTTPS_KEYTYPE="RSA"
#ENV UPSTREAM_ENABLE="no"
#ENV STREAM_LBMETHOD="none" # Not needed
#ENV UPSTREAM_SSLVERIFY="yes"
#ENV UPSTREAM_DEST1_ENABLE="yes"
#ENV UPSTREAM_DEST1_IP="127.0.0.1"
#ENV UPSTREAM_DEST1_PORT="2525"
#ENV UPSTREAM_DEST1_FAILS="5"
#ENV UPSTREAM_DEST1_TIMEOUT="5"
#ENV UPSTREAM_DEST1_KEEPALIVE="30"
#ENV UPSTREAM_DEST2_ENABLE="127.0.0.1"
#ENV UPSTREAM_DEST2_PORT="2525"
#ENV UPSTREAM_DEST2_FAILS="5"
#ENV UPSTREAM_DEST2_TIMEOUT="5"
#ENV UPSTREAM_DEST2_KEEPALIVE="30"
#ENV UPSTREAM_DEST3_ENABLE="no"
#ENV UPSTREAM_DEST3_IP="127.0.0.1"
#ENV UPSTREAM_DEST3_PORT="2525"
#ENV UPSTREAM_DEST3_FAILS="5"
#ENV UPSTREAM_DEST3_TIMEOUT="5"
#ENV UPSTREAM_DEST3_KEEPALIVE="30"
#ENV UPSTREAM_DEST4_ENABLE="no"
#ENV UPSTREAM_DEST4_IP="127.0.0.1"
#ENV UPSTREAM_DEST4_PORT="2525"
#ENV UPSTREAM_DEST4_FAILS="5"
#ENV UPSTREAM_DEST4_KEEPALIVE="30"
#ENV UPSTREAM_DEST5_ENABLE="no"
#ENV UPSTREAM_DEST5_IP="127.0.0.1"
#ENV UPSTREAM_DEST5_PORT="2525"
#ENV UPSTREAM_DEST5_FAILS="5"
#ENV UPSTREAM_DEST5_TIMEOUT="5"
#ENV UPSTREAM_DEST5_KEEPALIVE="30"

EXPOSE  80 443 1935

RUN ansible-playbook entrypoint.yml --tags run -c local

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Switch to non-root user
# USER ptg-user

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]


# Config notes /sites-enabled - HTTP local / proxy
#/streams-enabled - TCP/UDP
#/rtmp-enabled - RT
#/upstreams - Upstreams