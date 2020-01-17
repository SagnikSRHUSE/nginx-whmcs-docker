FROM nginx:stable

MAINTAINER Sagnik Sasmal, <sagnik@sagnik.me>

# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive

# Customization of the nginx user and group ids in the image. It's 101:101 in
# the base image. Here we use 33 which is the user id and group id for www-data
# on Ubuntu, Debian, etc.
ARG nginx_uid=33
ARG nginx_gid=33

# The worker processes in the nginx image run as the user nginx with group
# nginx. This is where we override their respective uid and guid to something
# else that lines up better with file permissions.
# The -o switch allows reusing an existing user id
RUN usermod -u $nginx_uid -o nginx && groupmod -g $nginx_gid -o nginx
