#!/bin/bash
if [ "$1" = 'osmium' ]; then
  exec /usr/bin/java -server -Xms10m -jar osmium.jar server joblauncher.yml
else
  exec "$@"
fi
