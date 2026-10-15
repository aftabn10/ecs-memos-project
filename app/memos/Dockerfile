# Web Builder Stage - Stage 1
FROM node:20-alpine AS web-builder

WORKDIR /web

COPY web/package*.json ./
RUN npm install

COPY web/ .
RUN npm run release

# Builder Stage - Stage 2
FROM golang:1.25-alpine AS builder

WORKDIR /build

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

COPY --from=web-builder /server/router/frontend/dist ./server/router/frontend/dist

RUN go build -o app cmd/memos/main.go

# Final Lightweight Stage - Stage 3
FROM alpine:3.23 AS final

COPY --from=builder ./build/app /bin/app

RUN addgroup -g 1001 memos-user && \
    adduser -D -u 1001 -G memos-user memos-user

RUN mkdir -p /var/opt/memos && \
    chown -R memos-user:memos-user /var/opt/memos

USER memos-user

EXPOSE 5230

CMD ["/bin/app", "--addr", "0.0.0.0"]
