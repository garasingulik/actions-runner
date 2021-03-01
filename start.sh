#!/bin/bash

if [[ -z "${URL}" ]]; then
  echo "URL is not set ..."
  exit 1
fi

if [[ -z "${TOKEN}" ]]; then
  echo "Token is not set ..."
  exit 1
fi

#Define cleanup procedure
cleanup() {
    echo "Container stopped, performing cleanup..."
    ./config.sh remove --token $TOKEN
}

#Trap SIGTERM
trap 'true' SIGTERM

#Execute a command
./config.sh --url $URL --token $TOKEN
./run.sh &

#Wait
wait $!

#Cleanup
cleanup