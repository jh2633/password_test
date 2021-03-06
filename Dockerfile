
FROM ruby:2.4.1

RUN apt-get update -qq && apt-get install -y \
  qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xvfb
#qt5 package allows capybara webkit tests to be run

# Set our working directory inside the image
WORKDIR /app

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

RUN gem install bundler
RUN bundle install

# Copy the application into place
COPY . .
EXPOSE 4567
CMD ["rake", "server:start"]
