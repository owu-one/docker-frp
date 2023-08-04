FROM golang:latest AS building

RUN apt update && apt install -y git
RUN git clone --single-branch -b master --depth 1 https://github.com/fatedier/frp /building
WORKDIR /building

RUN make frpc

FROM alpine:latest

COPY --from=building /building/bin/frpc /usr/bin/frpc

ENTRYPOINT ["/usr/bin/frpc"]