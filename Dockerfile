FROM ruby:1.9

# dependencies
RUN apt-get update
# later on we'll put redis in docker-compose
# for now let me do it the ghetto way
RUN apt-get install -y redis-server

# get the code!
COPY . /src
WORKDIR /src

# we need some dirs / configs
RUN mkdir /etc/onetime
RUN cp -r etc/* /etc/onetime/
RUN mkdir -p /var/log/onetime
RUN touch /var/log/onetime/redis.log
RUN mkdir -p /var/lib/onetime/

# prepare the ruby magic
RUN bundle install
RUN bundler

# we'll need to go outside
EXPOSE 7143

# fun!
CMD redis-server /etc/onetime/redis.conf && bundle exec thin -e dev -R config.ru -p 7143 start
