FROM centos:7

LABEL maintainer="Igor Zubkov <igor.zubkov@gmail.com>"

RUN yum upgrade -y -q

RUN yum install epel-release -y -q

RUN yum install git gcc make bzip2 libyaml-devel openssl-devel \
	readline-devel zlib-devel postgresql-devel nodejs npm --enablerepo=epel -y -q

RUN echo 'gem: --no-rdoc --no-ri' > /root/.gemrc

RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv

RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build

ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH

RUN cd /root/.rbenv && src/configure && make -C src

RUN rbenv install 2.6.0-rc1

RUN rbenv global 2.6.0-rc1

RUN echo 'eval "$(rbenv init -)"' >> /root/.bash_profile

RUN gem update --system

ENV BUNDLER_VERSION 1.17.1

RUN gem install bundler --version "$BUNDLER_VERSION" --force

RUN mkdir -p /srv/evemonk

RUN git clone https://github.com/biow0lf/evemonk.git /srv/evemonk

WORKDIR /srv/evemonk

ENV RAILS_ENV production

RUN bundle install --quiet --without development test

RUN rbenv rehash

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
