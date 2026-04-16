###### 1. Pick a base image (web builder stage 1) **IMPORTANT (1)
FROM node:20-alpine AS web-builder

###### 2. Set working directory inside the container
WORKDIR /web

###### 3. COPY files required
COPY web/package*.json ./
RUN npm install

COPY web/ .
RUN npm run release

###### 1. Pick a base image (builder stage 2) **IMPORTANT (1)
FROM golang:1.25-alpine AS builder

###### 2. Set working directory inside the container
WORKDIR /build

###### 3. COPY go.mod and go.sum files for dependency installation
COPY go.mod .
COPY go.sum .

###### 4. Download dependencies 
RUN go mod download

###### 5. Copy the entire app source
COPY . .

# Bring in built frontend assets
COPY --from=web-builder /server/router/frontend/dist ./server/router/frontend/dist

# Build the Go
RUN go build -o app cmd/memos/main.go

#Final lightweight stage (stage 3)
FROM alpine:3.23 AS final

# Copy the compiled binary from the builder stage
COPY --from=builder ./build/app /bin/app

# Set the environment variable path
# ENV MEMOS_DATA=/var/opt/memos

# Create non-root user
RUN addgroup -g 1001 memos-user && \ 
    adduser -D -u 1001 -G memos-user memos-user

# # Create directory and give ownership to user
RUN mkdir -p /var/opt/memos && \
    chown -R memos-user:memos-user /var/opt/memos

# Switch user 
USER memos-user

# Expose the applications port
EXPOSE 5230

# Run the application
CMD ["/bin/app", "--addr", "0.0.0.0"]