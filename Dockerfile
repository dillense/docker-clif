FROM ubuntu:22.04

ENV CLIF 2.3.9
ENV JAVA openjdk-8-jre-headless

LABEL org.opencontainers.image.authors="bruno.dillenseger@orange.com"
LABEL version="$CLIF"

RUN \
	apt-get update && \
	apt-get -y install vim wget unzip $JAVA iproute2 iputils-ping dnsutils net-tools && \
	apt-get -y --purge autoremove && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN \
	wget -q https://release.ow2.org/clif/$CLIF/clif-$CLIF-server.zip -O /tmp/clif-$CLIF-server.zip && \
	unzip -d /opt /tmp/clif-$CLIF-server.zip && \
	adduser --quiet --disabled-password --gecos "CLIF user" --shell /bin/bash clif && \
	echo "PATH=\"$PATH:/opt/clif-$CLIF-server/bin\"" >> /home/clif/.profile && \
	rm -rf /tmp/*

COPY entrypoint.sh /

EXPOSE 1234
EXPOSE 1357
USER clif
ENTRYPOINT /entrypoint.sh
