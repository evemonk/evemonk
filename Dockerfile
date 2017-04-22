FROM centos:7

MAINTAINER Igor Zubkov <igor.zubkov@gmail.com>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r evemonk && useradd -r -g evemonk evemonk

RUN yum upgrade -y && yum install git -y

RUN git clone https://github.com/biow0lf/evemonk.git /usr/srv/evemonk \
	&& chown -R evemonk:evemonk /usr/srv/evemonk

WORKDIR /usr/src/evemonk

ENV RAILS_ENV production

RUN bundle install --without development test

CMD ["/bin/bash"]

