FROM registry.fedoraproject.org/fedora-minimal:34

SHELL ["/bin/bash", "-l", "-c"]

RUN microdnf update -y && \
  microdnf -y install \
  nginx && \
  microdnf clean all

COPY nginx.conf /etc/nginx/nginx.conf

USER nginx

CMD ["nginx", "-g", "daemon off;"]
