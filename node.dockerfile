FROM node:18.6.0-alpine3.15
# RUN echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p
# RUN sysctl -w fs.inotify.max_user_watches=524288
USER node
