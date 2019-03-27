FROM ruby:2.6.2-slim

LABEL maintainer="Igor Zubkov <igor.zubkov@gmail.com>"

RUN apt-get update -y && \
    apt-get dist-upgrade -y && \
    apt-get install gnupg2 git gcc make wget -y

RUN sh -c 'wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -'

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update -y && \
    apt-get install postgresql-client-11 postgresql-11 libpq-dev postgresql-server-dev-10 -y

RUN apt-get autoremove -y && \
    apt-get clean -y

RUN mkdir -p /app

WORKDIR /app

COPY . .

ENV BUNDLER_VERSION 2.0.1

RUN gem install bundler --version "$BUNDLER_VERSION" --force

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

ENV RAILS_ENV production

RUN bundle install --without development test

# RUN yum install bzip2 libyaml-devel openssl-devel \
# 	readline-devel zlib-devel postgresql-devel nodejs npm --enablerepo=epel -y -q

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
