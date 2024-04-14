FROM ruby:2.6.6

RUN apt-get update -qq \
    && DEBIAN_FRONTED=noninteractive apt-get install -yq --no-install-recommends \
    build-essential curl gnupg2 less git
# Add Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
#Add NodeJS
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    libpq-dev yarn nodejs

RUN mkdir /sismobase
WORKDIR /sismobase

RUN gem install bundler:2.1.4 rake:12.3.3
COPY Gemfile /sismobase/
COPY Gemfile.lock /sismobase/
RUN bundle install
COPY . /sismobase
RUN yarn install --check-files

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]