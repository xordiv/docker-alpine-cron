FROM alpine:latest
MAINTAINER d@d.ru
 
RUN apk update && apk add dcron curl wget rsync ca-certificates && rm -rf /var/cache/apk/*

RUN mkdir -p /var/log/cron && mkdir -m 0644 -p /var/spool/cron/crontabs && touch /var/log/cron/cron.log && mkdir -m 0644 -p /etc/cron.d

COPY /scripts/* /

ENTRYPOINT ["/docker-entry.sh"]
CMD ["/docker-cmd.sh"]
