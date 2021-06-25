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
ENV DISCORD_TOKEN="ODI4MzE1NjQxMTY0MzMzMDg3.YGnzDg.8IXd6pVBoroe-q0TFYUy8_OhJzw"
ENTRYPOINT ["/go/bin/absol"]
CMD ["alert", "cleaner", "factoids", "log", "twitch", "hjt"]
