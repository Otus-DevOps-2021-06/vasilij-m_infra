FROM ruby:2.4.2

ENV APP_HOME /app
ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

RUN apt-get update -qq && apt-get install -y build-essential

WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN gem install bundler:1.16.1 && bundle install
COPY . $APP_HOME

CMD ["puma"]
