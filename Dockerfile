# Use the official Golang image to create a build stage
FROM golang:1.22.5 AS builder

WORKDIR /app

COPY go.mod ./

RUN go mod download

# Copy the source code into the container.
COPY . .

# Build the Go app
RUN go build -o main .

FROM debian:bookworm-slim

# Set the current Working Directory inside the container
WORKDIR /app

# Copy the pre-built binary file from the previous stage
COPY --from=builder /app/main .

COPY static /app/static
COPY templates /app/templates
COPY web /app/web
COPY banners /app/banners

# Expose port 8080 to the outside world.
EXPOSE 8080

# Apply metadata
LABEL org.opencontainers.image.title="Go Web Server" \
      org.opencontainers.image.description="Website that displays Ascii art" \
      org.opencontainers.image.version="1.0" \
      org.opencontainers.image.author="JosephOKumu"

# Run the executable
CMD ["./main"]