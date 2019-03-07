FROM alpine:latest AS build

# Install build tools.
RUN apk add --update openssl make git

COPY ./install-hugo.sh /install-hugo.sh
RUN /install-hugo.sh

COPY . /usr/share/nginx/html
WORKDIR /usr/share/nginx/html

# Build docs.
RUN make

# Copy static docs to alpine-based nginx container.
FROM nginx:alpine

# Copy nginx configuration
COPY ./docker/default.conf /etc/nginx/conf.d/default.conf

COPY --from=build /usr/share/nginx/html/public /usr/share/nginx/html
