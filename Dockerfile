FROM centos:7

MAINTAINER Igor Zubkov <igor.zubkov@gmail.com>

RUN yum upgrade -y

RUN yum install git gcc make bzip2 openssl-devel readline-devel zlib-devel -y

RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv

RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build

ENV PATH /root/.rbenv/bin:$PATH

RUN cd /root/.rbenv && src/configure && make -C src

RUN rbenv install -v 2.4.1

RUN rbenv global 2.4.1

# RUN set -ex && echo 'export PATH="/root/.rbenv/bin:$PATH"' >> /root/.bash_profile

# RUN set -ex && echo 'eval "$(rbenv init -)"' >> /root/.bash_profile

# RUN set -ex && echo 'eval "$(rbenv init -)"' >> /root/.profile

# RUN set -ex && echo 'eval "$(rbenv init -)"' >> /etc/profile

# RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

# RUN eval "$(rbenv init -)"

# RUN which gem

# RUN gem update --system

# ENV BUNDLER_VERSION 1.15.0.pre.2

# RUN gem install bundler --version "$BUNDLER_VERSION"

# RUN gem i bundler -v 1.15.0.pre.2

# RUN mkdir -p /srv/evemonk

# RUN git clone https://github.com/biow0lf/evemonk.git /srv/evemonk

# ENV RAILS_ENV production

# RUN type rbenv

# RUN ruby -v

# RUN gem -v

# RUN bundle -v

# RUN bundle install --without development test

CMD ["/bin/bash"]

