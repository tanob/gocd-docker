FROM java:8-jre

MAINTAINER Adriano Bonat <adrianob@gmail.com>

ENV GOCD_VERSION=15.2.0-2248
ENV GOCD_SERVER_SHA1=63847ce16d559e9cb4d2204ead64b9bccc72fe6e
ENV GOCD_SERVER_URL=https://download.go.cd/gocd-deb/go-server-$GOCD_VERSION.deb

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
