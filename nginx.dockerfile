FROM nginx:stable-alpine

# COPY ./ssl/localhost.crt /etc/nginx/localhost.crt
# COPY ./ssl/localhost.key /etc/nginx/localhost.key

RUN mkdir -p /etc/ssl/certs/
RUN mkdir -p /etc/ssl/private/

COPY ./ssl/unify.local+1.pem /etc/ssl/certs/nginx-selfsigned.crt
COPY ./ssl/unify.local+1-key.pem /etc/ssl/private/nginx-selfsigned.key

COPY ./ssl/self-signed.conf /etc/nginx/snippets/self-signed.conf
COPY ./ssl/ssl-params.conf /etc/nginx/snippets/ssl-params.conf

COPY ./ssl/dhparam.pem /etc/nginx/dhparam.pem

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf


RUN mkdir -p /var/www/html

RUN addgroup -g 1001 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN chown laravel:laravel /var/www/html
