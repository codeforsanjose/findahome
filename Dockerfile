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
FROM phusion/passenger-full

# Let's give findahome a home within the container.
#
#
COPY . /home/app/findahome

# Phusion has included some 'lockfiles' that
# prevent Nginx and Redis from starting. Let's
# remove them so those services start up.
#
#
RUN rm /etc/service/nginx/down
RUN rm /etc/service/redis/down

# Let's remove the default site served
# by Nginx and serve up our own.
#
#
RUN rm /etc/nginx/sites-enabled/default
COPY ./deploy_conf/nginx_site.conf /etc/nginx/sites-enabled/findahome.conf

# Nginx clears environment variables by default
# so let's preserve those variables by laying
# down a configuration file.
#
#
ADD ./deploy_conf/postgres_env.conf /etc/nginx/main.d/postgres_env.conf

# Use Ruby version 2.3.3
#
#
RUN bash -lc 'rvm --default use ruby-2.3.3'

# Install dependencies for findahome
#
#
WORKDIR /home/app/findahome
RUN npm install -g npm
RUN npm install -g ember-cli
RUN npm install -g bower
RUN gem install bundler
RUN bundle install
RUN echo '{ "allow_root": true }' > /root/.bowerrc
RUN bundle exec rake ember:install
RUN bundle exec rails assets:precompile

# Let's get our packages within the container up to date and then
# clean up after ourselves.
#
#
# RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Since everything is ran under the app user then
# let's make sure that 'app' has permissions to access
# the copied over findahome database
#
#
RUN chown -R app:app /home/app/findahome
RUN chmod o+x /home/app

# Remember, the port format for docker is <host_port>:<container_port>
#
# So, if you're running this from the command line, you need to execute
# something like docker run -p 8080:80 to view the site.
#
#
CMD ["/sbin/my_init"]
EXPOSE 80
