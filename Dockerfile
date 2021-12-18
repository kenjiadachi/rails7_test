FROM ruby:2.7.0-alpine AS dev

WORKDIR /src
ENV LANG ja_JP.UTF-8
ENV TZ Asia/TOKYO
ENV BUNDLE_JOBS 20
ENV BUNDLE_PATH /bundle
ENV EDITOR=vim

RUN set -eux; \
    \
    apk --update --no-cache add \
      udev \
      ttf-freefont \
      chromium \
      chromium-chromedriver \
    ;
  
ENV DOCKERIZE_VERSION v0.6.1
RUN set -eux; \
    \
    apk add --no-cache openssl; \
    wget https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz; \
    tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    rm dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz

RUN set -eux; \
    \
    apk --update --no-cache add \
      libxml2-dev \
      libxslt-dev \
      postgresql-dev \
      build-base \
      curl-dev \
      make \
      python2 \
      imagemagick \
      gcc \
      libc-dev \
      g++ \
      tzdata \
      yarn \
      bash \
      vim \
      less \
      git \
      graphviz \
      redis

RUN set -eux; \
    \
    gem install bundler -v 2.1.4; \
    bundle config build.nokogiri --use-system-libraries; \
    mkdir -p /bundle $(yarn cache dir)

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
