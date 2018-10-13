FROM alpine:3.8

ENV SQUID_VERSION=3.5.27-r2

RUN apk add --no-cache squid=${SQUID_VERSION} \
    curl
    
COPY entrypoint.sh /usr/local/bin

RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]

EXPOSE 3128/tcp
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]