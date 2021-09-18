# Docker Phoenix
A docker image based on ubuntu with pre installed erlang, elixir and nodejs.

Everything is installed with asdf and plugins.

Current versions:

**Ubuntu** 20.04

**Elixir** 1.12.3

**Erlang/OTP** 24.0.6

**Phoenix** 1.5.12

**Node** 14.17.6

Dockerize your phoenix project quicly with docker-compose with this image.

Example:

```yaml
version: '3.7'

volumes:
  deps:
  builds:
  node_modules:

services:
  phx:
    image: erickueen/phoenix:1.5.4
    ports:
      - ${HTTP_PORT:-4000}:${HTTP_PORT:-4000}
    volumes:
      - ./:/app/src
      - deps:/app/src/deps
      - builds:/app/src/_build
      - node_modules:/app/src/assets/node_modules
    depends_on:
      - postgres
    environment:
      - MIX_ENV=${ENV:-dev}
      - POSTGRES_URL=ecto://postgres:postgres@postgres/your_app_name_${ENV:-dev}
      - HTTP_PORT=${HTTP_PORT:-4000}
    working_dir: /app/src

  postgres:
    image: postgres:9.6
    ports:
      - ${DATABASE_EXTERNAL_PORT:-5432}:5432
    environment:
      POSTGRES_HOST_AUTH_METHOD: "trust"
```

And execute with:
```bash
# Commands to set-up your app
docker-compose run --rm phx sh -c "mix ecto.create"
docker-compose run --rm phx sh -c "mix ecto.migrate"
docker-compose run --rm phx sh -c "cd assets/node_modules && npm install"

# Start your server
docker-compose run --service-ports phx iex --sname your_app -S mix phx.server

# To run tests
ENV=test docker-compose run --rm phx sh -c "mix test"
```