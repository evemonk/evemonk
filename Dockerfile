FROM registry.docker.com/library/ruby:3.4.4-slim@sha256:ca08f3de8ee66e49dc68a97b80a5d96c71f23627214d0ff16a7b48f671833158 AS builder

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# skipcq: DOK-DL3008
RUN set -eux; \
    apt-get update -y ; \
    apt-get dist-upgrade -y ; \
    apt-get install git patch xz-utils gcc make g++ libpq-dev curl nodejs --no-install-recommends libyaml-dev -y ; \
    apt-get autoremove -y ; \
    apt-get clean -y ; \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app

WORKDIR /app

COPY .ruby-version .ruby-version

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

ENV RAILS_ENV=production

ENV RAILS_LOG_TO_STDOUT=true

RUN gem update --system "3.6.9"

# skipcq: DOK-DL3028
RUN gem install bundler --version "2.6.9" --force

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

COPY . .

RUN cp -f /app/config/evemonk.example.yml /app/config/evemonk.yml

# The SECRET_KEY_BASE here isn't used. Precomiling assets doesn't use your
# secret key, but Rails will fail to initialize if it isn't set.

# The DATABASE_URL here isn't used. Precomiling assets doesn't use your
# database, but Rails will fail to initialize if it isn't set.

# The DEVISE_MAILER_SENDER here isn't used. Precomiling assets doesn't use your
# secret key, but Rails will fail to initialize if it isn't set.

# The DEVISE_PEPPER here isn't used. Precomiling assets doesn't use your
# secret key, but Rails will fail to initialize if it isn't set.

RUN bundle exec rake SECRET_KEY_BASE=no \
    DEVISE_MAILER_SENDER=no \
    DEVISE_PEPPER=no \
    DATABASE_URL="postgres://postgres@postgresql/evemonk_production?pool=1&encoding=unicode" \
    assets:precompile

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

FROM registry.docker.com/library/ruby:3.4.4-slim@sha256:ca08f3de8ee66e49dc68a97b80a5d96c71f23627214d0ff16a7b48f671833158

# skipcq: DOK-DL3008
RUN set -eux; \
    apt-get update -y ; \
    apt-get dist-upgrade -y ; \
    apt-get install libpq5 libcurl4 libjemalloc2 shared-mime-info nodejs --no-install-recommends -y ; \
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

# install only production gems without development and test
RUN bundle config set --global without development test

RUN bundle exec bootsnap precompile --gemfile

ARG COMMIT=""

ENV COMMIT_SHA=${COMMIT}

ENV RAILS_ENV=production

ENV RAILS_LOG_TO_STDOUT=true

ENV RAILS_SERVE_STATIC_FILES=true

ENV BOOTSNAP_LOG=true

ENV BOOTSNAP_READONLY=true

ENV RUBY_YJIT_ENABLE=1

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

EXPOSE 3000/tcp

CMD ["bundle", "exec", "rails", "server", "--binding=0.0.0.0"]
