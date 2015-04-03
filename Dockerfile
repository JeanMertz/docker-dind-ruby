FROM jpetazzo/dind:latest
MAINTAINER Jean Mertz <jean@blendle.com>

ENV LOG file
ENV BUNDLE_FROZEN 1
ENV BUNDLE_PATH /usr/local/bundle
ENV BUNDLE_BIN ${BUNDLE_PATH}/bin
ENV BUNDLE_APP_CONFIG $BUNDLE_PATH
ENV DOCKER_DAEMON_ARGS --storage-driver=overlay --storage-opt=dm.mountopt=nodiscard

ENV RUBY_VERSION 2.1.3

RUN apt-get update                                                     \
    && apt-get -y install build-essential                              \
    && wget -O ruby-install-0.5.0.tar.gz                               \
      https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz \
    && tar -xzvf ruby-install-0.5.0.tar.gz                             \
    && cd ruby-install-0.5.0                                           \
    && sudo make install                                               \
    && cd ..                                                           \
    && rm -r ruby-install-0.5.0                                        \
    && apt-get -y purge build-essential                                \
    && apt-get -y autoremove

RUN ruby-install ruby $RUBY_VERSION -- --disable-install-rdoc \
    && rm -r /usr/local/src/ruby-${RUBY_VERSION}*

RUN mkdir -p /opt/rubies/ruby-${RUBY_VERSION}/etc \
    && echo 'gem: --no-document' > /opt/rubies/ruby-${RUBY_VERSION}/etc/gemrc

ENV PATH $PATH:/opt/rubies/ruby-${RUBY_VERSION}/bin

RUN gem install bundler \
    && bundle config --global jobs $(nproc)

ENTRYPOINT ["wrapdocker"]
