FROM ubuntu:latest
MAINTAINER Alex

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update  \
 && apt-get -y upgrade  \
 && apt-get install -y -q --no-install-recommends \
    vim \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*


COPY container-content/entry.sh /
CMD ["/entry.sh"]

