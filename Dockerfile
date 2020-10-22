FROM golang:1.15 as build
WORKDIR /build
COPY . .
ENV CGO_ENABLED=0
RUN go build -a -ldflags \
  '-extldflags "-static"' server.go

FROM scratch
COPY --from=build /build/server .
CMD ["/server"]
EXPOSE 80
