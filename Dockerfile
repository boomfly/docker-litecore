FROM node:8-slim as builder

RUN apt-get update && apt-get install -y curl build-essential libzmq3-dev python

RUN npm init -y && npm i litecore

# Actual image
FROM node:8-slim

LABEL maintainer="boomfly@rambler.ru"
LABEL description="litecore image"

RUN apt-get update && apt-get install -y libzmq3-dev

COPY --from=builder /node_modules /node_modules
COPY ./litecore-node.json /.litecore/litecore-node.json

VOLUME ["/.litecore/data"]
EXPOSE 3001

CMD ["/node_modules/litecore/bin/litecored", "-c", "/.litecore/litecore-node.json"]
