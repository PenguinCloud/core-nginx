FROM code-dal1.penguintech.group:5050/ptg/standards/docker-ansible-image:stable
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# UPDATE as needed
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y

# PUT YER ARGS in here
# Change this to actual title for Default
ARG APP_TITLE="NGINX"

# BUILD IT!
RUN ansible-playbook build.yml -c local

ENV RUN_PHPFPM="yes"
ENV CONFIG_WEBSERVER="no"
ENV HTTP_PORT="8080"
ENV HTTPS_PORT="8443"
ENV SERVER_ADDRESS="localhost"
ENV PROJECT_NAME="example"
ENV PROJECT_DIRECTORY="/opt/example"
ENV PROTOCOL="https"
ENV CPU_COUNT="2"
ENV FILE_LIMIT="1042"
ENV ORGANIZATION_NAME="name"
ENV ORGANIZATION_COUNTRY="US"
ENV ORGANIZATION_EMAIL="admin@localhost"
ENV SERVER_ADDRESS="localhost"
ENV CONFIG_REVERSE_PROXY="yes"
ENV PROXY_ADDRESS="http://localhost:8080"

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Switch to non-root user
USER ptg-user

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]


