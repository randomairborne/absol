###
# Builder to compile our golang code
###
FROM golang:alpine AS builder

WORKDIR /build
COPY . .

RUN go build -o absol -v github.com/randomairborne/absol/core

###
# Now generate our smaller image
###
FROM alpine

COPY --from=builder /build/absol /go/bin/absol
ENV DISCORD_TOKEN="ODI4MzE1NjQxMTY0MzMzMDg3.YGnzDg._lGdkshVZU9madNhHvu4Ge1XxnQ"
ENTRYPOINT ["/go/bin/absol"]
CMD ["alert", "cleaner", "factoids", "log", "twitch", "hjt"]
