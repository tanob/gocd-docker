FROM java:8-jre

MAINTAINER Adriano Bonat <adrianob@gmail.com>

ENV GOCD_VERSION=15.3.0-2715
ENV GOCD_SERVER_SHA1=ed2bd054c5260c9984f08fcdd6d761483993b58c
ENV GOCD_SERVER_URL=https://download.go.cd/local/15.3.0-2715/go-server-15.3.0-2715.deb

RUN set -x \
 # Download/Install/Cleanup Go Server
 && curl -fSL "$GOCD_SERVER_URL" -o go-server.deb \
 && echo "$GOCD_SERVER_SHA1 go-server.deb" | sha1sum -c - \
 && dpkg -i --debug=10 go-server.deb \
 && rm go-server.deb

RUN set -x \
 # Redirect log output to stdout
 && ln -sf /dev/stdout /var/log/go-server/go-server.log \

 # Uses default environment values from start script
 && rm /etc/default/go-server

COPY set-agent-key.sh /

VOLUME /var/lib/go-server /etc/go /var/go

# Start script requires JAVA_HOME to be specified
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

# Default Go Server HTTP and HTTPS ports
EXPOSE 8153 8154

CMD ["/usr/share/go-server/server.sh"]
