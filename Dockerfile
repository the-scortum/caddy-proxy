FROM ubuntu:latest
MAINTAINER Alex

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update  \
 && apt-get -y upgrade  \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    psmisc \
    vim \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Install Forego
ADD https://github.com/jwilder/forego/releases/download/v0.16.1/forego /usr/local/bin/forego
RUN chmod u+x /usr/local/bin/forego

ENV DOCKER_GEN_VERSION 0.7.3

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz


# install caddy
RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \  
 && /usr/bin/caddy -version



VOLUME ["/certs"]

ADD container-content/entry.sh /
ADD container-content/Procfile /
ADD container-content/Caddyfile.template /

EXPOSE 80 443 2015

ENTRYPOINT ["/entry.sh"]
CMD ["forego", "start", "-r"]
