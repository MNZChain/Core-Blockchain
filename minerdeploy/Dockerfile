FROM golang:1.16-buster as builder

ADD . /go-ethereum
RUN cd /go-ethereum && go run build/ci.go install ./cmd/geth

# Pull Geth into a second stage deploy alpine container
FROM ubuntu:18.04

RUN apt-get update && \
  apt install -y tmux

COPY --from=builder /go-ethereum/build/bin/geth /app/geth
ADD ./minerdeploy/testnet.json /app/genesis.json
ADD ./minerdeploy/start.sh /app/start.sh
RUN chmod +x /app/start.sh

RUN mkdir -p /app/keystore \
&& mkdir -p /app/data \
&& chmod 755 /app/geth

ARG privatekey
ARG password
RUN echo $password > /app/.accountpassword
RUN echo $privatekey > /app/.privatekey



WORKDIR "/app"

RUN /app/geth --datadir mainnetz account import /app/.privatekey --password /app/.accountpassword
RUN /app/geth --datadir mainnetz init /app/genesis.json

CMD /app/start.sh
EXPOSE 8545
