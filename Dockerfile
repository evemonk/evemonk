FROM ruby:3.0.2-slim AS builder

RUN set -eux; \
    apt-get update -y ; \
    apt-get dist-upgrade -y ; \
    apt-get install git make gcc g++ libpq-dev curl --no-install-recommends -y ; \
    curl -sL https://deb.nodesource.com/setup_14.x | bash -; \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -; \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list ; \
    apt-get update -y ; \
    apt-get install nodejs yarn --no-install-recommends -y ; \
    apt-get autoremove -y ; \
    apt-get clean -y ; \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app

WORKDIR /app

COPY .ruby-version .ruby-version

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

ENV RAILS_ENV production

ENV RAILS_LOG_TO_STDOUT true

ENV RUBYGEMS_VERSION 3.2.24

RUN gem update --system "$RUBYGEMS_VERSION"

ENV BUNDLER_VERSION 2.2.24

# skipcq: DOK-DL3028
RUN gem install bundler --version "$BUNDLER_VERSION" --force

RUN gem --version

RUN bundle --version

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config set --global frozen 1

# two jobs
RUN bundle config set --global jobs 2

# install only production gems without development and test
RUN bundle config set --global without development test

# retry 5 times before fail
RUN bundle config set --global retry 5

RUN bundle install

RUN rm -rf /usr/local/bundle/cache/*.gem

RUN find /usr/local/bundle/gems/ -name "*.c" -delete

RUN find /usr/local/bundle/gems/ -name "*.o" -delete

#13 4.840
#13 4.840 ------------------------------------------------------------------------------
#13 4.840
#13 4.840 RubyGems installed the following executables:
#13 4.840 	/usr/local/bin/gem
#13 4.840 	/usr/local/bin/bundle
#13 4.840 	/usr/local/bin/bundler

COPY . .

RUN bundle exec bootsnap precompile --gemfile app/ lib/

# The SECRET_KEY_BASE here isn't used. Precomiling assets doesn't use your
# secret key, but Rails will fail to initialize if it isn't set.

# The DATABASE_URL here isn't used. Precomiling assets doesn't use your
# database, but Rails will fail to initialize if it isn't set.

RUN set -eux; \
    yarn install --frozen-lockfile ; \
    yarn cache clean ; \
    bundle exec rake SECRET_KEY_BASE=no DATABASE_URL="postgres://postgres@postgresql/evemonk_production?pool=1&encoding=unicode" assets:precompile ; \
    rm -rf node_modules/

FROM ruby:3.0.2-slim

RUN set -eux; \
    apt-get update -y ; \
    apt-get dist-upgrade -y ; \
    apt-get install libpq5 wait-for-it libjemalloc2 shared-mime-info --no-install-recommends -y ; \
    apt-get autoremove -y ; \
    apt-get clean -y ; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN groupadd --gid 1000 app

RUN useradd --uid 1000 --no-log-init --create-home --gid app app

USER app

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY --from=builder --chown=app:app /app /app

ENV RAILS_ENV production

ENV RAILS_LOG_TO_STDOUT true

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

EXPOSE 3000/tcp

RUN rails server

CMD ["rails", "server", "-b", "0.0.0.0"]

#ENV RAILS_SERVE_STATIC_FILES true
