FROM java:8-jre

MAINTAINER Adriano Bonat <adrianob@gmail.com>

ENV GOCD_VERSION=15.3.1-2777
ENV GOCD_AGENT_SHA1=0a39f38a8fde5f33fe204c6d7e0d0d5d70a866cf
ENV GOCD_AGENT_URL=https://download.go.cd/gocd-deb/go-agent-${GOCD_VERSION}.deb

RUN set -x \
 # Download/Install/Cleanup Go Agent
 && curl -fSL "$GOCD_AGENT_URL" -o go-agent.deb \
 && echo "$GOCD_AGENT_SHA1 go-agent.deb" | sha1sum -c - \
 && dpkg -i --debug=10 go-agent.deb \
 && rm go-agent.deb

RUN set -x \
 # Uses default environment values from start script
 && rm /etc/default/go-agent

COPY start-agent.sh /

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre \

    # Agent will look for server at this hostname
    GO_SERVER=go-server \

    # Need to set this otherwise work dir will be /usr/share/go-agent
    # and auto register won't work
    AGENT_WORK_DIR=/var/lib/go-agent

CMD ["/start-agent.sh"]
