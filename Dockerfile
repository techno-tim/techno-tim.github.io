FROM nginx:alpine

COPY _site /usr/share/nginx/html
COPY ads.txt /usr/share/nginx/html
