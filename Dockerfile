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

COPY mix.exs .
COPY mix.lock .

RUN mix do deps.get, deps.compile

RUN mkdir assets

COPY assets/package.json assets
COPY assets/package-lock.json assets

RUN cd assets && npm install && cd ..
