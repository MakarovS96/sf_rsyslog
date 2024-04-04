FROM ubuntu

COPY start.sh .

COPY cron/hello-cron /etc/cron.d/hello-cron
RUN chmod 0755 start.sh && chmod 0644 /etc/cron.d/hello-cron && touch /var/log/cron.log

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update -qq && \
    apt-get upgrade -y -qq && \
    apt-get install -y -qq dialog apt-utils cron && \
    apt-get install -y -qq --no-install-recommends rsyslog

CMD [ "./start.sh", "rsyslogd", "-dn" ]
