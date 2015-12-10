#!/bin/bash

readonly CONFIG_FILE=/var/lib/go-agent/config/autoregister.properties

echo "agent.auto.register.key=$AGENT_KEY" > $CONFIG_FILE

if [ -n "$AGENT_RESOURCES" ]; then
  echo "agent.auto.register.resources=$AGENT_RESOURCES" >> $CONFIG_FILE
fi

if [ -n "$AGENT_ENVIRONMENTS" ]; then
  echo "agent.auto.register.environments=$AGENT_ENVIRONMENTS" >> $CONFIG_FILE
fi

exec /usr/share/go-agent/agent.sh
