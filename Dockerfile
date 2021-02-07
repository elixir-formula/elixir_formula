FROM bitwalker/alpine-elixir:1.11.0

RUN apk update \
    && apk upgrade --no-cache \
    && apk add --no-cache \
      nodejs-npm \
      alpine-sdk \
      openssl-dev \
      inotify-tools \
    && mix local.rebar --force \
    && mix local.hex --force

WORKDIR /elixir_formula

COPY . /elixir_formula

RUN mix do deps.get, deps.compile, compile

RUN cd assets && npm install && cd ..
