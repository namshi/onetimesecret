FROM ruby:2.0

ENV RACK_ENV dev

COPY . /src
WORKDIR /src

RUN mkdir /etc/onetime
RUN cp -r etc/* /etc/onetime/ && \
    cp run.sh /run.sh && \
    chmod a+x /run.sh
RUN mkdir -p /var/log/onetime
RUN touch /var/log/onetime/redis.log
RUN mkdir -p /var/lib/onetime/

RUN bundle install
RUN bundler

EXPOSE 8080

CMD ["/run.sh"]
