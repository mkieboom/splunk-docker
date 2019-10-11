#!/bin/bash

# Specify the container version tag. Versions available:
CONTAINER_VERSION=latest

# Launch the Splunk container based on MapR PACC
docker run -it \
  -p 8000:8000 \
  -e "SPLUNK_START_ARGS=--accept-license" \
  -e "SPLUNK_PASSWORD=adminadmin" \
  mkieboom/splunk-docker:$CONTAINER_VERSION
