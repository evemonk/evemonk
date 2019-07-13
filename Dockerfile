FROM ruby:2.6.3-slim

LABEL maintainer="Igor Zubkov <igor.zubkov@gmail.com>"

RUN apt-get update -y && \
    apt-get dist-upgrade -y && \
    apt-get install gnupg2 git gcc make wget curl wait-for-it libjemalloc2 libjemalloc-dev -y

RUN sh -c 'wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -'

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update -y && \
    apt-get install postgresql-client-11 postgresql-11 libpq-dev postgresql-server-dev-10 -y

RUN sh -c 'curl -sL https://deb.nodesource.com/setup_10.x | bash -'

RUN sh -c 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -'

RUN sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list'

RUN apt-get update -y && \
    apt-get install nodejs yarn -y

RUN apt-get autoremove -y && \
    apt-get clean -y

RUN mkdir -p /app

WORKDIR /app

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

ENV RAILS_ENV production

ENV BUNDLER_VERSION 2.0.2

RUN gem install bundler --version "$BUNDLER_VERSION" --force

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# two jobs
RUN bundle config --global jobs 2

# install only production gems without development and test
RUN bundle config --global without development test

# retry 5 times before fail
RUN bundle config --global retry 5

RUN bundle install

COPY package.json package.json

COPY yarn.lock yarn.lock

RUN yarn install

COPY . .

RUN bundle exec rake SECRET_KEY_BASE=blablabla DB_ADAPTER=nulldb assets:precompile

ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libjemalloc.so.1

VOLUME ['/shared']

EXPOSE 3000

CMD ['rails', 'server', '-b', '0.0.0.0']
