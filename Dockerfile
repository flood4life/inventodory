FROM ruby:3.0.0

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn bash

WORKDIR /app

COPY Gemfile Gemfile.lock yarn.lock ./
COPY bin/ ./bin

RUN bin/bundle config set --local deployment 'true'
RUN bin/bundle install --jobs 5 --retry 3
RUN bin/yarn

COPY . /app

ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "web-server" ]
