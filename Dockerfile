FROM nginx:stable-alpine

COPY _site /usr/share/nginx/html
