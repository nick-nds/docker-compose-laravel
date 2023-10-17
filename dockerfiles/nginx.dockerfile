FROM nginx:stable-alpine

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

# MacOS staff group's gid is 20, so is the dialout group in alpine linux. We're not using it, let's just remove it.
RUN delgroup dialout

RUN addgroup -g ${GID} --system laravel
RUN adduser -G laravel --system -D -s /bin/sh -u ${UID} laravel
RUN sed -i "s/user  nginx/user laravel/g" /etc/nginx/nginx.conf


ADD ./nginx/default.conf /etc/nginx/conf.d/

RUN mkdir -p /etc/ssl/certs/
RUN mkdir -p /etc/ssl/private/

# COPY ./ssl/backend.test+4.pem /etc/ssl/certs/nginx-selfsigned.crt
# COPY ./ssl/backend.test+4-key.pem /etc/ssl/private/nginx-selfsigned.key
# 
# COPY ./ssl/self-signed.conf /etc/nginx/snippets/self-signed.conf
# COPY ./ssl/ssl-params.conf /etc/nginx/snippets/ssl-params.conf

# COPY ./ssl/dhparam.pem /etc/nginx/dhparam.pem

RUN mkdir -p /var/www/html
