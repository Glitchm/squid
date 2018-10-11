FROM alpine:3.8

ENV SQUID_VERSION=3.5.27-r2 \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=squid

RUN apk update && apk add squid=${SQUID_VERSION} \
    && apk add curl \
    && rm -rf /var/cache/apk/*
    
COPY entrypoint.sh /usr/local/bin

RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]

EXPOSE 3128/tcp
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]