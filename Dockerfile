# Passenger-full is a monolith container that includes
# multiple programming languages and services. It is
# ideal for running Find-a-Home because it comes with
# Ruby, Node, Phusion, Nginx, and Redis.
#
# Here are some assumptions that this Dockerfile makes:
#
# * Rails environment is automatically set to production
# * Redis, Nginx, Ruby, and Node are preinstalled
#
#
FROM node:6.10.0

ENV CONFIGURE_OPTS --disable-install-doc

# Let's install and upate the command line tools that
# are needed for installing the dependencies.
#
#
RUN npm install -g ember-cli
RUN npm install -g bower
RUN echo '{ "allow_root": true }' > /root/.bowerrc

RUN useradd findahome
RUN mkdir /home/findahome
RUN chown -R findahome:findahome /home/findahome

USER findahome
RUN git clone https://github.com/rbenv/rbenv.git /home/findahome/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/findahome/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> /home/findahome/.bash_profile
RUN git clone https://github.com/rbenv/ruby-build.git /home/findahome/.rbenv/plugins/ruby-build

RUN /bin/bash -l -c "rbenv install 2.3.3"
RUN /bin/bash -l -c "rbenv rehash"
RUN /bin/bash -l -c "rbenv global 2.3.3"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

COPY . /home/findahome/findahome
USER root
RUN chown -R findahome:findahome /home/findahome/findahome
USER findahome

WORKDIR /home/findahome/findahome
RUN /bin/bash -l -c "bundle install"
RUN /bin/bash -l -c "bundle exec rake ember:install"
RUN /bin/bash -l -c "bundle exec rails assets:precompile"

# Remember, the port format for docker is <host_port>:<container_port>
#
# So, if you're running this from the command line, you need to execute
# something like docker run -p 3000:80 to view the site.
#
#
ENV RAILS_ENV=production
CMD /bin/bash -l -c "rm -f tmp/pids/server.pid && rails server --bind 0.0.0.0"
EXPOSE 3000
