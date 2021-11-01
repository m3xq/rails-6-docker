FROM ruby:VERSION

ENV APP_HOME /app
ENV BUNDLE_VERSION VERSION
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV RAILS_PORT 3000

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update -qq && apt install -y build-essential libpq-dev nodejs yarn

RUN gem install bundler --version "$BUNDLE_VERSION"

WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

COPY package.json $APP_HOME/package.json
COPY yarn.lock $APP_HOME/yarn.lock

COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh

COPY . $APP_HOME

EXPOSE $RAILS_PORT

ENTRYPOINT ["bundle", "exec"]