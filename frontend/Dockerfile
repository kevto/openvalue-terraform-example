FROM nginx:1.20-alpine
EXPOSE 80
COPY ./dist/jworld /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/templates/nginx.conf.template
ENV NGINX_ENVSUBST_OUTPUT_DIR=/etc/nginx
