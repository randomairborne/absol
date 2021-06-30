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

ENV DISCORD_TOKEN="ODQzNTcwOTI4OTg2MDk1NjY3.YKFypg.oitHaYth01yypXcxb4SA9mgMsoM"
ENV DATABASE="absol:Password@/absol"

ENTRYPOINT ["/go/bin/absol"]
CMD ["alert", "factoids", "hjt"]
