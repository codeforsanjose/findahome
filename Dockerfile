# Findahome basically requires two language run times:
#
# Node and Ruby
#
# As such, I included the node container image here and will
# handle setting up all the Ruby requirements within this
# dockerfile.
#
# Note that alpine is used as the distribution for a lighter
# image footprint. This requires more code but results in a
# substantially smaller image.
#
#
FROM node:6.10.0-alpine

# Make sure that Ruby doesn't include unnecessary documentation
#
#
ENV CONFIGURE_OPTS --disable-install-doc

# Let's install and update the command line tools that
# are needed for installing the dependencies.
#
# While we're here, let's install the prerequisites for
# compiling Ruby and the various C extensions used by
# some of the gems we require.
#
#
RUN npm install -g ember-cli && \
    npm install -g bower && \
    echo '{ "allow_root": true }' > /root/.bowerrc && \
    echo 'ipv6' >> /etc/modules && \
    apk --update add git \
      bash \
      linux-headers \
      postgresql-dev \
      libpq \
      libxml2-dev \
      libc-dev \
      libxslt-dev \
      build-base \
      readline-dev \
      wget \
      curl \
      openssl \
      openssl-dev && \
    rm -rf /var/cache/apk/*

# To avoid security concerns, I'm going to run Findahome under
# a findahome user.
#
#
RUN addgroup findahome && \
    adduser -s /bin/bash -D -G findahome findahome && \
    chown -R findahome:findahome /home/findahome

# Setup rbenv - which will manage the Ruby version for us
#
#
USER findahome
RUN git clone https://github.com/rbenv/rbenv.git /home/findahome/.rbenv && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/findahome/.bash_profile && \
    echo 'eval "$(rbenv init -)"' >> /home/findahome/.bash_profile && \
    git clone https://github.com/rbenv/ruby-build.git /home/findahome/.rbenv/plugins/ruby-build

# I'm defaulting to a login bash shell for handling rbenv
#
#
RUN /bin/bash -l -c "rbenv install 2.3.3 && \
                     rbenv rehash && \
                     rbenv global 2.3.3 && \
                     gem install bundler --no-ri --no-rdoc"

# This is somewhat awkward. When a local directory gets copied into
# a docker container image, it is initially owned by root. This means
# that I have to switch back to root in order to give ownership of the
# findahome directory to the findahome user. This results in a larger
# image due to the extra layering.
#
# The docker team recognizes that it's a problem but are reluctant to
# modify the behavior of the copy directive due to it being a breaking
# change. This is the only way.
#
#
COPY . /home/findahome/findahome
USER root
RUN chown -R findahome:findahome /home/findahome/findahome
USER findahome

# Install gems and the ember framework.
#
#
WORKDIR /home/findahome/findahome
RUN /bin/bash -l -c "bundle install && bundle exec rake ember:install"

# Remember, the port format for docker is <host_port>:<container_port>
#
# So, if you're running this from the command line, you need to execute
# something like docker run -p 3000:80 to view the site.
#
# There are two separate start scripts. The idea is that this container
# image can also be used to create a container that only runs Sidekiq.
#
#
ENV RAILS_ENV=production
ENV REDIS_URL=redis://redis:6379/0
RUN chmod +x deploy/start_sidekiq.sh && chmod +x deploy/start_rails.sh
CMD deploy/start_rails.sh
EXPOSE 3000

LABEL description="A container for the Find a Home project."
LABEL maintainer="Tyler Hamption <howdoicomputer@fastmail.com>"
LABEL version="v2"
