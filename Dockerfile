FROM registry.fedoraproject.org/fedora-minimal:34

SHELL ["/bin/bash", "-l", "-c"]

RUN microdnf update -y && \
  microdnf -y install \
  nginx && \
  microdnf clean all

ONBUILD RUN chown -R nginx:nginx /var/log/nginx \
    && chmod -R g+w /var/cache/nginx \
    && chown -R nginx:nginx /etc/nginx \
    && chmod -R g+w /etc/nginx

COPY nginx.conf /etc/nginx/nginx.conf

USER nginx

CMD ["nginx", "-g", "daemon off;"]